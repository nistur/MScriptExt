#include "MScriptPlugin.h"

#include "MScriptExtImpl.h"

MScriptExtImpl* s_script = NULL;

MResource* MScriptExtGetter()
{
    return s_script;
}

void MPluginStart(MScriptExt)
{
    MResource::registerFactory("MScriptExt", MScriptExtGetter);
    MEngine* engine = MEngine::getInstance();
    s_script = new MScriptExtImpl;
    engine->setScriptContext(s_script);
}

void MPluginEnd(MScriptExt)
{
    MResource::unregisterFactory("MScriptExt", MScriptExtGetter);
    MEngine* engine = MEngine::getInstance();
    if(engine->getScriptContext() == s_script)
        engine->setScriptContext(NULL);

    delete s_script;
}   