#include "MScriptPlugin.h"

#include "MScriptExtImpl.h"

MScriptExtImpl* s_script = NULL;

MResource* MScriptExtGetter()
{
    return s_script;
}

#ifdef  M_USE_GAME_EVENT
#include "MEventListener.h"

#include "editorLua.c"

class MScriptExtEventListener : public MEventListener
{
public:
    MEventListenerDeclare(MScriptExtEventListener);
    void onEvent(const char* event)
    {
        MScriptExt* script = NULL;
        MScriptExtGet(script);
        if(!script) return;
        if(strcmp(event, "publish") == 0)
        {
            script->callFunction("editor.publish");
        }
        else if(strcmp(event, "MScriptInit") == 0)
        {
            script->parse(scriptseditor, 
                          scriptseditorName, 
                          scriptseditorSize);

            // also load all editor scripts
            // add behaviors

            MSystemContext* system = MEngine::getInstance()->getSystemContext();
            char editorScriptDir[256];
            getGlobalFilename(editorScriptDir, system->getWorkingDirectory(), "editor");

            vector<string> files;
            readDirectory(editorScriptDir, &files);

            for(vector<string>::iterator iFile = files.begin();
                iFile != files.end();
                iFile++)
            {
                if(iFile->find(".lua") != string::npos)
                {
                    char scriptFileName[256];
                    getGlobalFilename(scriptFileName, editorScriptDir, iFile->c_str());
                    MFile* scriptFile = M_fopen(scriptFileName, "r");
                    if(scriptFile)
                    {
                        M_fseek(scriptFile, 0L, SEEK_END);
                        long size = M_ftell(scriptFile);

                        char* buffer = new char[size];

                        M_rewind(scriptFile);
                        if(M_fread(buffer, 1, size, scriptFile) != size)
                        {
                            delete[] buffer;
                            M_fclose(scriptFile);
                        }

                        string name = "editor/" + *iFile;

                        script->parse(buffer, name.c_str(), size);

                        delete[] buffer;

                        M_fclose(scriptFile);
                    }
                }
            }

        }
    }
};
MScriptExtEventListener s_EventListener;
#endif/*M_USE_GAME_EVENT*/

void MPluginStart(MScriptExt)
{
    MResource::registerFactory("MScriptExt", MScriptExtGetter);
    MEngine* engine = MEngine::getInstance();
    s_script = new MScriptExtImpl;

    // copy the existing environment
    MScriptContext* oldScriptContext = engine->getScriptContext();
    char fnName[256];
    if(oldScriptContext)
        for(int i = 0; i < oldScriptContext->getNumCFunctions(); ++i)
        {
            MScriptContext::CFunction fn = oldScriptContext->getCFunction(i, fnName);
            s_script->addFunction(fnName, fn);
        }
        
    engine->setScriptContext(s_script);

    s_script->init();
}

void MPluginEnd(MScriptExt)
{
    MResource::unregisterFactory("MScriptExt", MScriptExtGetter);
    MEngine* engine = MEngine::getInstance();
    if(engine->getScriptContext() == s_script)
        engine->setScriptContext(NULL);

    delete s_script;
}   