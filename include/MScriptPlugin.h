#ifndef __M_SCRIPT_EXT_PLUGIN_H__
#define __M_SCRIPT_EXT_PLUGIN_H__

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

#ifdef  MPluginStart
# undef MPluginStart
#endif/*MPluginStart*/

#ifdef  MPluginEnd
# undef MPluginEnd
#endif/*MPluginEnd*/

#ifdef  M_SCRIPT_EXT_STATIC

#define MPluginStart(x) \
x##Start()

#define MPluginEnd(x)  \
x##End()

#else/*!M_SCRIPT_EXT_STATIC*/

#define MPluginStart(x) \
StartPlugin()

#define MPluginEnd(x)  \
EndPlugin()

#endif/*M_SCRIPT_EXT_STATIC*/

extern "C"
{

EXPORT void MPluginStart(MScriptExt);
EXPORT void MPluginEnd  (MScriptExt);

}
#endif/*__M_SCRIPT_EXT_PLUGIN_H__*/