#Settings
INCLUDE_OPENGL=TRUE
INCLUDE_NETWORK=FALSE
DOWNLOADER_MODE=basic

ifeq ($(SUPPORTPATH), )
	$(error Please set SUPPORTPATH environment variable before running make. )
endif

LDFLAGS += -L"$(SUPPORTPATH)/lib"
CPPFLAGS += -I"$(SUPPORTPATH)/include" -I"$(SUPPORTPATH)/include/SDL2"

#Commands
CPP=g++
CC=gcc

ASMTYPE=win32
ASM= 

BIN=luxengine.exe

RES= $(OBJDIR)/lux.res
RES_SOURCE = res/lux.rc

ifeq ($(PLATFORMBITS), 64)
	RES_OUTPUT=pe-x86-64
else
	RES_OUTPUT=pe-i386
	PLATFORM_FLAGS += -march=i586
endif

#Static Settings
PLATFORM_DIRECTORY = platform/sdl2

PLATFORM_LIBS = -lmingw32 -lSDL2main -lSDL2 -lSDL2_mixer -lwinmm -static-libgcc -lws2_32
PLATFORM_LIBS += -ldinput8 -ldxguid -ldxerr8 -luser32 -lgdi32 -lwinmm -limm32 -lole32 -loleaut32 -lversion -luuid
PLATFORM_FLAGS = -DHAVE_UNISTD_H -DHAVE_INTTYPES_H -DHAVE_STDINT_H -DNO_ZLIB -DUSE_SDL2 -DDISPLAYMODE_NATIVE  -Dmain=SDL_main

PLATFORM_OBJECTS =  $(OBJDIR)/lux.res

ifeq ($(INCLUDE_NETWORK), TRUE)
	PLATFORM_OBJECTS += $(OBJDIR)/enet/win32.o
endif

ifeq ($(DOWNLOADER_MODE), curl)
	PLATFORM_LIBS += -lcurldll -lssl.dll -lcrypto.dll
endif

ifeq ($(INCLUDE_OPENGL), TRUE)
	PLATFORM_LIBS += -lopengl32
	PLATFORM_FLAGS += -DDISPLAYMODE_OPENGL
endif

ifeq ($(BUILDDEBUG), TRUE)
	PLATFORM_LIBS += -mconsole
else
	PLATFORM_LIBS += -mwindows
endif



$(RES): $(RES_SOURCE)
	@-$(MKDIR) $(dir $@)
	@windres -i $(RES_SOURCE) --input-format=rc -o $@ -O coff -F $(RES_OUTPUT)
