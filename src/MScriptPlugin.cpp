#include "MScriptPlugin.h"

#include "MScriptExt.h"

MScriptExt* s_script = NULL;
void MPluginStart(MScriptExt)
{
    MEngine* engine = MEngine::getInstance();
    s_script = new MScriptExt;
    engine->setScriptContext(s_script);
}

void MPluginEnd(MScriptExt)
{
    MEngine* engine = MEngine::getInstance();
    if(engine->getScriptContext() == s_script)
        engine->setScriptContext(NULL);

    delete s_script;
}   