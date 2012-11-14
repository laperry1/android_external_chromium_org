# Copyright (c) 2012 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import logging
import os
import re
import sys
import time

import android_commands
import cmd_helper
import constants
import ports

from pylib import pexpect


def _MakeBinaryPath(build_type, binary_name):
  return os.path.join(constants.CHROME_DIR, 'out', build_type, binary_name)


class Forwarder(object):
  """Class to manage port forwards from the device to the host."""

  _DEVICE_FORWARDER_PATH = constants.TEST_EXECUTABLE_DIR + '/device_forwarder'

  # Unix Abstract socket path:
  _DEVICE_ADB_CONTROL_PORT = 'chrome_device_forwarder'
  _TIMEOUT_SECS = 30

  def __init__(self, adb, build_type):
    """Forwards TCP ports on the device back to the host.

    Works like adb forward, but in reverse.

    Args:
      adb: Instance of AndroidCommands for talking to the device.
      build_type: 'Release' or 'Debug'.
    """
    assert build_type in ('Release', 'Debug')
    self._adb = adb
    self._host_to_device_port_map = dict()
    self._device_process = None
    self._host_forwarder_path = _MakeBinaryPath(build_type, 'host_forwarder')
    self._device_forwarder_path = _MakeBinaryPath(
        build_type, 'device_forwarder')

  def Run(self, port_pairs, tool, host_name):
    """Runs the forwarder.

    Args:
      port_pairs: A list of tuples (device_port, host_port) to forward. Note
                 that you can specify 0 as a device_port, in which case a
                 port will by dynamically assigned on the device. You can
                 get the number of the assigned port using the
                 DevicePortForHostPort method.
      tool: Tool class to use to get wrapper, if necessary, for executing the
            forwarder (see valgrind_tools.py).
      host_name: Address to forward to, must be addressable from the
                 host machine. Usually use loopback '127.0.0.1'.

    Raises:
      Exception on failure to forward the port.
    """
    host_adb_control_port = ports.AllocateTestServerPort()
    if not host_adb_control_port:
      raise Exception('Failed to allocate a TCP port in the host machine.')
    self._adb.PushIfNeeded(self._device_forwarder_path,
                           Forwarder._DEVICE_FORWARDER_PATH)
    redirection_commands = [
        '%d:%d:%d:%s' % (host_adb_control_port, device, host,
                         host_name) for device, host in port_pairs]
    logging.info('Command format: <ADB port>:<Device port>' +
                 '[:<Forward to port>:<Forward to address>]')
    logging.info('Forwarding using commands: %s', redirection_commands)
    if cmd_helper.RunCmd(
        ['adb', '-s', self._adb._adb.GetSerialNumber(), 'forward',
         'tcp:%s' % host_adb_control_port,
         'localabstract:%s' % Forwarder._DEVICE_ADB_CONTROL_PORT]) != 0:
      raise Exception('Error while running adb forward.')

    if not self._adb.ExtractPid('device_forwarder'):
      # TODO(pliard): Get rid of pexpect here and make device_forwarder a daemon
      # with a blocking CLI process that exits with a proper exit code and not
      # while the daemon is still setting up. This would be similar to how
      # host_forwarder works.
      self._device_process = pexpect.spawn(
          'adb', ['-s',
                  self._adb._adb.GetSerialNumber(),
                  'shell',
                  '%s %s -D --adb_sock=%s' % (
                      tool.GetUtilWrapper(),
                      Forwarder._DEVICE_FORWARDER_PATH,
                      Forwarder._DEVICE_ADB_CONTROL_PORT)])
      device_success_re = re.compile('Starting Device Forwarder.')
      device_failure_re = re.compile('.*:ERROR:(.*)')
      index = self._device_process.expect([device_success_re,
                                           device_failure_re,
                                           pexpect.EOF,
                                           pexpect.TIMEOUT],
                                           Forwarder._TIMEOUT_SECS)
      if index == 1:
        error_msg = str(self._device_process.match.group(1))
        logging.error(self._device_process.before)
        self._device_process.close()
        raise Exception('Failed to start Device Forwarder with Error: %s' %
                        error_msg)
      elif index == 2:
        logging.error(self._device_process.before)
        self._device_process.close()
        raise Exception(
            'Unexpected EOF while trying to start Device Forwarder.')
      elif index == 3:
        logging.error(self._device_process.before)
        self._device_process.close()
        raise Exception('Timeout while trying start Device Forwarder')

    for redirection_command in redirection_commands:
      (exit_code, output) = cmd_helper.GetCmdStatusAndOutput(
          [self._host_forwarder_path, redirection_command])
      if exit_code != 0:
        raise Exception('%s exited with %d: %s' % (self._host_forwarder_path,
                                                   exit_code, output))
      tokens = output.split(':')
      if len(tokens) != 2:
        raise Exception('Unexpected host forwarder output "%s", ' +
                        'expected "device_port:host_port"' % output)
      device_port = int(tokens[0])
      host_port = int(tokens[1])
      self._host_to_device_port_map[host_port] = device_port
      logging.info('Forwarding device port: %d to host port: %d.', device_port,
                   host_port)

  @staticmethod
  def KillHost(build_type):
    host_forwarder_path = _MakeBinaryPath(build_type, 'host_forwarder')
    (exit_code, output) = cmd_helper.GetCmdStatusAndOutput(
        [host_forwarder_path, 'kill-server'])
    if exit_code != 0:
      raise Exception('%s exited with %d: %s' % (host_forwarder_path,
                                                 exit_code, output))

  @staticmethod
  def KillDevice(adb):
    logging.info('Killing device_forwarder.')
    timeout_sec = 5
    processes_killed = adb.KillAllBlocking('device_forwarder', timeout_sec)
    if not processes_killed:
      pids = adb.ExtractPid('device_forwarder')
      if pids:
        raise Exception('Timed out while killing device_forwarder')

  def DevicePortForHostPort(self, host_port):
    """Get the device port that corresponds to a given host port."""
    return self._host_to_device_port_map.get(host_port)

  def Close(self):
    """Terminate the forwarder process."""
    if self._device_process:
      self._device_process.close()
      self._device_process = None
