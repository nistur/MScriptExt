#include "MScriptPlugin.h"

#include "MScript.h"

MScript* s_script = NULL;
void StartPlugin(void)
{
    MEngine* engine = MEngine::getInstance();
    s_script = new MScript;
    engine->setScriptContext(s_script);
}

void EndPlugin(void)
{
    MEngine* engine = MEngine::getInstance();
    if(engine->getScriptContext() == s_script)
        engine->setScriptContext(NULL);

    delete s_script;
}