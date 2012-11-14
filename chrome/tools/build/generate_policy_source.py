#!/usr/bin/env python
# Copyright (c) 2012 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

'''python %prog [options] platform chromium_os_flag template

platform specifies which platform source is being generated for
  and can be one of (win, mac, linux)
chromium_os_flag should be 1 if this is a Chromium OS build
template is the path to a .json policy template file.'''

from __future__ import with_statement
from collections import namedtuple
from optparse import OptionParser
import re
import sys
import textwrap


CHROME_MANDATORY_SUBKEY = 'SOFTWARE\\\\Policies\\\\Google\\\\Chrome'
CHROME_RECOMMENDED_SUBKEY = CHROME_MANDATORY_SUBKEY + '\\\\Recommended'
CHROMIUM_MANDATORY_SUBKEY = 'SOFTWARE\\\\Policies\\\\Chromium'
CHROMIUM_RECOMMENDED_SUBKEY = CHROMIUM_MANDATORY_SUBKEY + '\\\\Recommended'

TYPE_MAP = {
  'dict': 'TYPE_DICTIONARY',
  'int': 'TYPE_INTEGER',
  'int-enum': 'TYPE_INTEGER',
  'list': 'TYPE_LIST',
  'main': 'TYPE_BOOLEAN',
  'string': 'TYPE_STRING',
  'string-enum': 'TYPE_STRING',
}

PolicyDetails = namedtuple(
    'PolicyDetails',
    'id name vtype platforms is_deprecated is_device_policy')


def main():
  parser = OptionParser(usage=__doc__)
  parser.add_option('--pch', '--policy-constants-header', dest='header_path',
                    help='generate header file of policy constants',
                    metavar='FILE')
  parser.add_option('--pcc', '--policy-constants-source', dest='source_path',
                    help='generate source file of policy constants',
                    metavar='FILE')
  parser.add_option('--ppb', '--policy-protobuf', dest='proto_path',
                    help='generate cloud policy protobuf file',
                    metavar='FILE')
  parser.add_option('--ppd', '--protobuf-decoder', dest='decoder_path',
                    help='generate C++ code decoding the policy protobuf',
                    metavar='FILE')

  (opts, args) = parser.parse_args()

  if len(args) != 3:
    print 'exactly platform, chromium_os flag and input file must be specified.'
    parser.print_help()
    return 2
  template_file_contents = _LoadJSONFile(args[2])
  if opts.header_path is not None:
    _WritePolicyConstantHeader(template_file_contents, args, opts)
  if opts.source_path is not None:
    _WritePolicyConstantSource(template_file_contents, args, opts)
  if opts.proto_path is not None:
    _WriteProtobuf(template_file_contents, args, opts.proto_path)
  if opts.decoder_path is not None:
    _WriteProtobufParser(template_file_contents, args, opts.decoder_path)
  return 0


#------------------ shared helpers ---------------------------------#
def _OutputGeneratedWarningForC(f, template_file_path):
    f.write('//\n'
            '// DO NOT MODIFY THIS FILE DIRECTLY!\n'
            '// IT IS GENERATED BY generate_policy_source.py\n'
            '// FROM ' + template_file_path + '\n'
            '//\n\n')


COMMENT_WRAPPER = textwrap.TextWrapper()
COMMENT_WRAPPER.width = 80
COMMENT_WRAPPER.initial_indent = '// '
COMMENT_WRAPPER.subsequent_indent = '// '
COMMENT_WRAPPER.replace_whitespace = False


# Writes a comment, each line prefixed by // and wrapped to 80 spaces.
def _OutputComment(f, comment):
  for line in comment.splitlines():
    if len(line) == 0:
      f.write('//')
    else:
      f.write(COMMENT_WRAPPER.fill(line))
    f.write('\n')


PH_PATTERN = re.compile('<ph[^>]*>([^<]*|[^<]*<ex>([^<]*)</ex>[^<]*)</ph>')


# Simplistic grit placeholder stripper.
def _RemovePlaceholders(text):
  result = ''
  pos = 0
  for m in PH_PATTERN.finditer(text):
    result += text[pos:m.start(0)]
    result += m.group(2) or m.group(1)
    pos = m.end(0)
  result += text[pos:]
  return result;


# Returns a PolicyDetails named tuple with details about the given policy.
def _GetPolicyDetails(policy):
  name = policy['name']
  if not TYPE_MAP.has_key(policy['type']):
    print 'Unknown policy type for %s: %s' % (name, policy['type'])
    sys.exit(3)
  vtype = TYPE_MAP[policy['type']]
  # platforms is a list of 'chrome', 'chrome_os' and/or 'chrome_frame'.
  platforms = [ x.split(':')[0] for x in policy['supported_on'] ]
  is_deprecated = policy.get('deprecated', False)
  is_device_policy = policy.get('device_only', False)
  return PolicyDetails(name=name, vtype=vtype, platforms=platforms,
                       is_deprecated=is_deprecated, id=policy['id'],
                       is_device_policy=is_device_policy)


def _GetPolicyList(template_file_contents):
  policies = []
  for policy in template_file_contents['policy_definitions']:
    if policy['type'] == 'group':
      for sub_policy in policy['policies']:
        policies.append(_GetPolicyDetails(sub_policy))
    else:
      policies.append(_GetPolicyDetails(policy))
  policies.sort(key=lambda policy: policy.name)
  return policies


def _LoadJSONFile(json_file):
  with open(json_file, 'r') as f:
    text = f.read()
  return eval(text)


#------------------ policy constants header ------------------------#
def _WritePolicyConstantHeader(template_file_contents, args, opts):
  os = args[0]
  with open(opts.header_path, 'w') as f:
    _OutputGeneratedWarningForC(f, args[2])

    f.write('#ifndef CHROME_COMMON_POLICY_CONSTANTS_H_\n'
            '#define CHROME_COMMON_POLICY_CONSTANTS_H_\n'
            '\n'
            '#include <string>\n'
            '\n'
            '#include "base/values.h"\n'
            '\n'
            'namespace policy {\n\n')

    if os == 'win':
      f.write('// The windows registry path where mandatory policy '
              'configuration resides.\n'
              'extern const wchar_t kRegistryMandatorySubKey[];\n'
              '// The windows registry path where recommended policy '
              'configuration resides.\n'
              'extern const wchar_t kRegistryRecommendedSubKey[];\n\n')

    f.write('// Lists policy types mapped to their names and expected types.\n'
            '// Used to initialize ConfigurationPolicyProviders.\n'
            'struct PolicyDefinitionList {\n'
            '  struct Entry {\n'
            '    const char* name;\n'
            '    base::Value::Type value_type;\n'
            '    bool device_policy;\n'
            '    int id;\n'
            '  };\n'
            '\n'
            '  const Entry* begin;\n'
            '  const Entry* end;\n'
            '};\n'
            '\n'
            '// Returns true if the given policy is deprecated.\n'
            'bool IsDeprecatedPolicy(const std::string& policy);\n'
            '\n'
            '// Returns the default policy definition list for Chrome.\n'
            'const PolicyDefinitionList* GetChromePolicyDefinitionList();\n\n')
    f.write('// Key names for the policy settings.\n'
            'namespace key {\n\n')
    for policy in _GetPolicyList(template_file_contents):
      f.write('extern const char k' + policy.name + '[];\n')
    f.write('\n}  // namespace key\n\n'
            '}  // namespace policy\n\n'
            '#endif  // CHROME_COMMON_POLICY_CONSTANTS_H_\n')


#------------------ policy constants source ------------------------#
def _WritePolicyConstantSource(template_file_contents, args, opts):
  os = args[0]
  is_chromium_os = args[1] == '1'
  platform = None
  platform_wildcard = None
  if is_chromium_os:
    platform = 'chrome_os'
  else:
    platform = 'chrome.' + os.lower()
    platform_wildcard = 'chrome.*'
  with open(opts.source_path, 'w') as f:
    _OutputGeneratedWarningForC(f, args[2])

    f.write('#include "base/basictypes.h"\n'
            '#include "base/logging.h"\n'
            '#include "policy/policy_constants.h"\n'
            '\n'
            'namespace policy {\n\n')

    f.write('namespace {\n\n')

    f.write('const PolicyDefinitionList::Entry kEntries[] = {\n')
    for policy in _GetPolicyList(template_file_contents):
      if (platform in policy.platforms) or \
         (platform_wildcard in policy.platforms):
        f.write('  { key::k%s, Value::%s, %s, %s },\n' %
            (policy.name, policy.vtype,
                'true' if policy.is_device_policy else 'false', policy.id))
    f.write('};\n\n')

    f.write('const PolicyDefinitionList kChromePolicyList = {\n'
            '  kEntries,\n'
            '  kEntries + arraysize(kEntries),\n'
            '};\n\n')

    f.write('// List of deprecated policies.\n'
            'const char* kDeprecatedPolicyList[] = {\n')
    for policy in _GetPolicyList(template_file_contents):
      if policy.is_deprecated:
        f.write('  key::k%s,\n' % policy.name)
    f.write('};\n\n')

    f.write('}  // namespace\n\n')

    if os == 'win':
      f.write('#if defined(GOOGLE_CHROME_BUILD)\n'
              'const wchar_t kRegistryMandatorySubKey[] = '
              'L"' + CHROME_MANDATORY_SUBKEY + '";\n'
              'const wchar_t kRegistryRecommendedSubKey[] = '
              'L"' + CHROME_RECOMMENDED_SUBKEY + '";\n'
              '#else\n'
              'const wchar_t kRegistryMandatorySubKey[] = '
              'L"' + CHROMIUM_MANDATORY_SUBKEY + '";\n'
              'const wchar_t kRegistryRecommendedSubKey[] = '
              'L"' + CHROMIUM_RECOMMENDED_SUBKEY + '";\n'
              '#endif\n\n')

    f.write('bool IsDeprecatedPolicy(const std::string& policy) {\n'
            '  for (size_t i = 0; i < arraysize(kDeprecatedPolicyList);'
              ' ++i) {\n'
            '    if (policy == kDeprecatedPolicyList[i])\n'
            '      return true;\n'
            '  }\n'
            '  return false;\n'
            '}\n'
            '\n'
            'const PolicyDefinitionList* GetChromePolicyDefinitionList() {\n'
            '  return &kChromePolicyList;\n'
            '}\n\n')

    f.write('namespace key {\n\n')
    for policy in _GetPolicyList(template_file_contents):
      f.write('const char k{name}[] = "{name}";\n'.format(name=policy.name))
    f.write('\n}  // namespace key\n\n'
            '}  // namespace policy\n')


#------------------ policy protobuf --------------------------------#
PROTO_HEAD = '''
syntax = "proto2";

package enterprise_management;

message StringList {
  repeated string entries = 1;
}

message PolicyOptions {
  enum PolicyMode {
    // The given settings are applied regardless of user choice.
    MANDATORY = 0;
    // The user may choose to override the given settings.
    RECOMMENDED = 1;
    // No policy value is present and the policy should be ignored.
    UNSET = 2;
  }
  optional PolicyMode mode = 1 [default = MANDATORY];
}

'''


# TODO(joaodasilva): introduce a message to represent dictionary values.
# Mapping 'dict' to 'string' for now. http://crbug.com/108997
PROTOBUF_TYPE = {
  'dict': 'string',
  'int': 'int64',
  'int-enum': 'int64',
  'list': 'StringList',
  'main': 'bool',
  'string': 'string',
  'string-enum': 'string',
}


# Field IDs [1..RESERVED_IDS] will not be used in the wrapping protobuf.
RESERVED_IDS = 2


def _WritePolicyProto(file, policy, fields):
  if policy.get('device_only', False):
    return
  desc = '\n'.join(map(str.strip,
                       _RemovePlaceholders(policy['desc']).splitlines()))
  _OutputComment(file, _RemovePlaceholders(policy['caption']) + '\n\n' + desc)
  file.write('message %sProto {\n' % policy['name'])
  file.write('  optional PolicyOptions policy_options = 1;\n')
  file.write('  optional %s %s = 2;\n' %
             (PROTOBUF_TYPE[policy['type']], policy['name']))
  file.write('}\n\n')
  fields += ['  optional %sProto %s = %s;\n' %
             (policy['name'], policy['name'], policy['id'] + RESERVED_IDS)]


def _WriteProtobuf(template_file_contents, args, outfilepath):
  with open(outfilepath, 'w') as f:
    _OutputGeneratedWarningForC(f, args[2])
    f.write(PROTO_HEAD)

    fields = []
    f.write('// PBs for individual settings.\n\n')
    for policy in template_file_contents['policy_definitions']:
      if policy['type'] == 'group':
        for sub_policy in policy['policies']:
          _WritePolicyProto(f, sub_policy, fields)
      else:
        _WritePolicyProto(f, policy, fields)

    f.write('// --------------------------------------------------\n'
            '// Big wrapper PB containing the above groups.\n\n'
            'message CloudPolicySettings {\n')
    f.write(''.join(fields))
    f.write('}\n\n')


#------------------ protobuf decoder -------------------------------#
CPP_HEAD = '''
#include <limits>
#include <string>

#include "base/logging.h"
#include "base/values.h"
#include "chrome/browser/policy/policy_map.h"
#include "chrome/browser/policy/proto/cloud_policy.pb.h"
#include "policy/policy_constants.h"

using google::protobuf::RepeatedPtrField;

namespace policy {

namespace em = enterprise_management;

Value* DecodeIntegerValue(google::protobuf::int64 value) {
  if (value < std::numeric_limits<int>::min() ||
      value > std::numeric_limits<int>::max()) {
    LOG(WARNING) << "Integer value " << value
                 << " out of numeric limits, ignoring.";
    return NULL;
  }

  return Value::CreateIntegerValue(static_cast<int>(value));
}

ListValue* DecodeStringList(const em::StringList& string_list) {
  ListValue* list_value = new ListValue;
  RepeatedPtrField<std::string>::const_iterator entry;
  for (entry = string_list.entries().begin();
       entry != string_list.entries().end(); ++entry) {
    list_value->Append(Value::CreateStringValue(*entry));
  }
  return list_value;
}

void DecodePolicy(const em::CloudPolicySettings& policy, PolicyMap* map) {
'''


CPP_FOOT = '''}

}  // namespace policy
'''


def _CreateValue(type, arg):
  if type == 'main':
    return "Value::CreateBooleanValue(%s)" % arg
  elif type in ('int', 'int-enum'):
    return "DecodeIntegerValue(%s)" % arg
  elif type in ('string', 'string-enum'):
    return "Value::CreateStringValue(%s)" % arg
  elif type == 'list':
    return "DecodeStringList(%s)" % arg
  elif type == 'dict':
    # TODO(joaodasilva): decode 'dict' types. http://crbug.com/108997
    return "new DictionaryValue()"
  else:
    raise NotImplementedError()


def _WritePolicyCode(file, policy):
  if policy.get('device_only', False):
    return
  membername = policy['name'].lower()
  proto_type = '%sProto' % policy['name']
  proto_name = '%s_proto' % membername
  file.write('  if (policy.has_%s()) {\n' % membername)
  file.write('    const em::%s& %s = policy.%s();\n' %
             (proto_type, proto_name, membername))
  file.write('    if (%s.has_%s()) {\n' % (proto_name, membername))
  file.write('      PolicyLevel level = POLICY_LEVEL_MANDATORY;\n'
             '      bool do_set = true;\n'
             '      if (%s.has_policy_options()) {\n'
             '        do_set = false;\n'
             '        switch(%s.policy_options().mode()) {\n' %
             (proto_name, proto_name))
  file.write('          case em::PolicyOptions::MANDATORY:\n'
             '            do_set = true;\n'
             '            level = POLICY_LEVEL_MANDATORY;\n'
             '            break;\n'
             '          case em::PolicyOptions::RECOMMENDED:\n'
             '            do_set = true;\n'
             '            level = POLICY_LEVEL_RECOMMENDED;\n'
             '            break;\n'
             '          case em::PolicyOptions::UNSET:\n'
             '            break;\n'
             '        }\n'
             '      }\n'
             '      if (do_set) {\n')
  file.write('        Value* value = %s;\n' %
             (_CreateValue(policy['type'],
                           '%s.%s()' % (proto_name, membername))))
  file.write('        map->Set(key::k%s, level, POLICY_SCOPE_USER, value);\n' %
             policy['name'])
  file.write('      }\n'
             '    }\n'
             '  }\n')


def _WriteProtobufParser(template_file_contents, args, outfilepath):
  with open(outfilepath, 'w') as f:
    _OutputGeneratedWarningForC(f, args[2])
    f.write(CPP_HEAD)
    for policy in template_file_contents['policy_definitions']:
      if policy['type'] == 'group':
        for sub_policy in policy['policies']:
          _WritePolicyCode(f, sub_policy)
      else:
        _WritePolicyCode(f, policy)
    f.write(CPP_FOOT)


if __name__ == '__main__':
  sys.exit(main())
