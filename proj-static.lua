-- this needs to be dofile'd in a premake4.lua solution
    project "MScriptExtStatic"
        kind "StaticLib"
        language "C++"

        -- include all the files, including Maratis SDK ones
        files {
            "src/**.cpp",
            "include/**.h",
            "**.md",
            "lua/**",
            os.getenv("MSDKDIR") .. "SDK/**.h"
        }
        includedirs { "include" , "lua" }
        targetdir "bin"
        targetname "MScriptExt"
        --targetprefix ""
        defines { "M_SCRIPT_EXT_STATIC" }

        -- split the files up a bit nicer inside Visual Studio
        vpaths { 
            ["MCore/*"] = os.getenv("MSDKDIR") .. "/SDK/MCore/Includes/**.h",
            ["MEngine/*"] = os.getenv("MSDKDIR") .. "/SDK/MEngine/Includes/**.h",
            ["lua/*"] = { "lua/**" },
            ["Plugin/*"] = { "**.h", "**.cpp" },
            ["Doc/*"] = { "**.md" }
        }
        -- link to Maratis
        links { "MCore", "MEngine" }