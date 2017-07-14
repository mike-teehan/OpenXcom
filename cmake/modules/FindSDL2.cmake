###

SET(SDL2_SEARCH_PATHS
	~/Library/Frameworks
	/Library/Frameworks
	/usr/local
	/usr
	/sw # Fink
	/opt/local # DarwinPorts
	/opt/csw # Blastwave
	/opt
)

SET(SDL2_LIBRARIES "")

macro(FindComponent UCOMP)

    set(SDL2_COMPONENT "")
    if("${UCOMP}" STRGREATER "")
        set(SDL2_COMPONENT "_${UCOMP}")
    else()
        set(SDL2_COMPONENT "")
    endif("${UCOMP}" STRGREATER "")

    # find the lib itself
    find_library(SDL2${SDL2_COMPONENT}_LIB
        NAMES "SDL2${SDL2_COMPONENT}"
        HINTS
            $ENV{SDL2DIR}
        PATH_SUFFIXES lib64 lib lib/x86_64-linux-gnu
        PATHS ${SDL2_SEARCH_PATHS}
    )
    MESSAGE("SDL2${SDL2_COMPONENT}_LIB is ${SDL2${SDL2_COMPONENT}_LIB}")
    set(SDL2${SDL2_COMPONENT}_LIB "${SDL2${SDL2_COMPONENT}_LIB}")

    if(EXISTS "${SDL2${SDL2_COMPONENT}_LIB}")
        set(SDL2_LIBRARIES "${SDL2_LIBRARIES} ${SDL2${SDL2_COMPONENT}_LIB}")
        set(SDL2${SDL2_COMPONENT}_FOUND "TRUE")
    else()
        set(SDL2${SDL2_COMPONENT}_FOUND "FALSE")
    endif(EXISTS "${SDL2${SDL2_COMPONENT}_LIB}")
    message("SDL2${SDL2_COMPONENT}_FOUND: ${SDL2${SDL2_COMPONENT}_FOUND}")

endmacro()

# find the include path
find_path(SDL2_INCLUDE_DIR
    NAMES "SDL.h"
    HINTS
        $ENV{SDL2DIR}
    PATH_SUFFIXES include/SDL2 include
    PATHS ${SDL2_SEARCH_PATHS}
)
MESSAGE("SDL2_INCLUDE_DIR is ${SDL2_INCLUDE_DIR}")
set(SDL2_INCLUDE_DIR "${SDL2_INCLUDE_DIR}")

FindComponent("")
foreach(component ${SDL2_FIND_COMPONENTS})
    FindComponent(${component})
endforeach()

MESSAGE("SDL2_LIBRARIES: ${SDL2_LIBRARIES}")

INCLUDE(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL2 REQUIRED_VARS SDL2_LIBRARIES SDL2_INCLUDE_DIR)
