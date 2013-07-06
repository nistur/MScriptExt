#ifndef __M_SCRIPT_PLUGIN_H__
#define __M_SCRIPT_PLUGIN_H__

#ifdef WIN32
# include <windows.h>
# ifdef M_SCRIPT_EXT_BUILD
#  define EXPORT __declspec(dllexport)
# else
#  define EXPORT __declspec(dllimport)
# endif
#else
# define EXPORT
#endif

extern "C"
{

EXPORT void StartPlugin();
EXPORT void EndPlugin();

}
#endif/*__M_SCRIPT_PLUGIN_H__*/