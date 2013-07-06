-- Particle system project
solution "MScript"
    configurations { "Debug", "Release" }
    language "C++"
    
    -- make sure we can search and link properly
    libdirs { os.getenv("MSDKDIR") .. "/SDK/MCore/Libs",
          os.getenv("MSDKDIR") .. "/SDK/MEngine/Libs",
          "." }
    includedirs { os.getenv("MSDKDIR") .. "/SDK/MCore/Includes",
              os.getenv("MSDKDIR") .. "/SDK/MEngine/Includes",
              "include" }

              print (os.getenv("MSDKDIR") .. "/SDK/MCore/Libs")

    defines { "M_SAVE_FILE_BUILD" }
    
    -- OS defines
    if os.is("windows") then
        defines { "WIN32" }
    end

    configuration "Debug"
        defines { "DEBUG" }
        flags { "Symbols" }

    configuration "Release"
        defines { "NDEBUG" }
        flags { "Optimize" }  

    project "lua"
        kind "StaticLib"
        language "C++"
        files { "lua/**" }
        includedirs { "lua" }
        targetdir "bin"
        
    project "MSaveFile"
        kind "SharedLib"
        language "C++"

        -- include all the files, including Maratis SDK ones
        files {
            "src/**.cpp",
            "include/**.h",
            "**.md",
            "tinyxml/**",
            os.getenv("MSDKDIR") .. "SDK/**.h"
        }
        includedirs { "include" , "lua" }
        targetdir "bin"

        -- split the files up a bit nicer inside Visual Studio
        vpaths { 
            ["MCore/*"] = os.getenv("MSDKDIR") .. "/SDK/MCore/Includes/**.h",
            ["MEngine/*"] = os.getenv("MSDKDIR") .. "/SDK/MEngine/Includes/**.h",
            ["Plugin/*"] = { "**.h", "**.cpp" },
            ["Doc/*"] = { "**.md" }
        }
        -- link to Maratis
        links { "MCore", "MEngine", "lua" }
