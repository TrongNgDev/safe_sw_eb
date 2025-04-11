#include "platform_internal.h"

/**
 * os_printf() - redirect message to JLinkRTTViewer terminal 0
 */
int
os_printf(const char *format, ...)
{
	  int r;
	  va_list ParamList;
	  va_start(ParamList, format);
	  r = SEGGER_RTT_vprintf(0, format, &ParamList);
	  va_end(ParamList);
	  return r;
}

/**
 * os_vprintf() - redirect message to JLinkRTTViewer terminal 0
 */
int
os_vprintf(const char *format, va_list ap)
{
    return SEGGER_RTT_vprintf(0, format, ap);
}
