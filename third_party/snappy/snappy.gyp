# Copyright (c) 2012 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

{
'variables': {
    'conditions': [
      # Define an "os_include" variable that points at the OS-specific generated
      # headers.  These were generated by running the configure script offline.
      ['os_posix == 1 and OS != "mac"', {
        'os_include': 'linux'
      }],
      ['OS=="mac"', {'os_include': 'mac'}],
      ['OS=="win"', {'os_include': 'win32'}],
    ],
    'use_system_libxml%': 0,
  },
  'targets': [
    {
      'target_name': 'snappy',
      'type': 'static_library',
      'include_dirs': [
        '<(os_include)',
        'src',
        '../..',
      ],
      'direct_dependent_settings': {
        'include_dirs': [
          '<(os_include)',
          'src',
        ],
      },
      'sources': [
        'src/snappy-internal.h',
        'src/snappy-sinksource.cc',
        'src/snappy-sinksource.h',
        'src/snappy-stubs-internal.cc',
        'src/snappy-stubs-internal.h',
        'src/snappy.cc',
        'src/snappy.h',
      ],
    },
    {
      'target_name': 'snappy_unittest',
      'type': 'executable',
      'sources': [
        'src/snappy-test.cc',
        'src/snappy-test.h',
        'src/snappy_unittest.cc',
      ],
      'dependencies': [
        'snappy',
        '../../base/base.gyp:base',
        '../../testing/gtest.gyp:gtest',
        '../../third_party/zlib/zlib.gyp:zlib',
      ],
    },
  ],
}
