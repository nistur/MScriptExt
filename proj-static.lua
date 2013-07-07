-- this needs to be dofile'd in a premake4.lua solution
    project "MScriptExtStatic"
        kind "StaticLib"
        language "C++"

        -- include all the files, including Maratis SDK ones
        files {
            "src/**.cpp",
            "include/**.h",
            "**.md",
            "lua/**", -- do we need to do a build without lua for linking to the player?
            os.getenv("MSDKDIR") .. "SDK/**.h"
        }
        includedirs { "include" , "lua" }
        targetdir "bin"
        -- make sure we're still called the right thing
        -- but don't unset the prefix because it's more
        -- difficult to link against
        targetname "MScriptExt"
        defines { "M_SCRIPT_EXT_STATIC" }

        -- split the files up a bit nicer inside Visual Studio
        vpaths { 
            ["MCore/*"] = os.getenv("MSDKDIR") .. "/SDK/MCore/Includes/**.h",
            ["MEngine/*"] = os.getenv("MSDKDIR") .. "/SDK/MEngine/Includes/**.h",
            ["Lua/*"] = { "lua/**" },
            ["Plugin/*"] = { "**.h", "**.cpp" },
            ["Doc/*"] = { "**.md" }
        }
        -- link to Maratis
        links { "MCore", "MEngine" }