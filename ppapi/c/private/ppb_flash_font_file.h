/* Copyright (c) 2012 The Chromium Authors. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/* From private/ppb_flash_font_file.idl modified Mon Oct 08 10:46:09 2012. */

#ifndef PPAPI_C_PRIVATE_PPB_FLASH_FONT_FILE_H_
#define PPAPI_C_PRIVATE_PPB_FLASH_FONT_FILE_H_

#include "ppapi/c/dev/ppb_font_dev.h"
#include "ppapi/c/pp_bool.h"
#include "ppapi/c/pp_instance.h"
#include "ppapi/c/pp_macros.h"
#include "ppapi/c/pp_resource.h"
#include "ppapi/c/pp_stdint.h"
#include "ppapi/c/pp_var.h"
#include "ppapi/c/private/pp_private_font_charset.h"

#define PPB_FLASH_FONTFILE_INTERFACE_0_1 "PPB_Flash_FontFile;0.1"
#define PPB_FLASH_FONTFILE_INTERFACE PPB_FLASH_FONTFILE_INTERFACE_0_1

/**
 * @file
 * This file contains the <code>PPB_Flash_FontFile</code> interface.
 */


/**
 * @addtogroup Interfaces
 * @{
 */
struct PPB_Flash_FontFile_0_1 {
  /* Returns a resource identifying a font file corresponding to the given font
   * request after applying the browser-specific fallback.
   */
  PP_Resource (*Create)(PP_Instance instance,
                        const struct PP_FontDescription_Dev* description,
                        PP_PrivateFontCharset charset);
  /* Determines if a given resource is Flash font file.
   */
  PP_Bool (*IsFlashFontFile)(PP_Resource resource);
  /* Returns the requested font table.
   * |output_length| should pass in the size of |output|. And it will return
   * the actual length of returned data. |output| could be NULL in order to
   * query the size of the buffer size needed. In that case, the input value of
   * |output_length| is ignored.
   * Note: it is Linux only and fails directly on other platforms.
   */
  PP_Bool (*GetFontTable)(PP_Resource font_file,
                          uint32_t table,
                          void* output,
                          uint32_t* output_length);
};

typedef struct PPB_Flash_FontFile_0_1 PPB_Flash_FontFile;
/**
 * @}
 */

#endif  /* PPAPI_C_PRIVATE_PPB_FLASH_FONT_FILE_H_ */

