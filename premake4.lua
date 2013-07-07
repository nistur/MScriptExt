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
              os.getenv("MSDKDIR") .. "/Plugins/Includes" }

    -- use MGameEvent if it exists
    if os.isfile(os.getenv("MSDKDIR") .. "Plugins/Includes/MGameEvent.h") then
        defines { "M_USE_GAME_EVENT" }
    end

    defines { "M_SCRIPT_EXT_BUILD" }
    
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

    dofile("proj-dynamic.lua")
    dofile("proj-static.lua")
