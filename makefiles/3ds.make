#Settings
INCLUDE_OPENGL=FALSE
INCLUDE_NETWORK=FALSE
DOWNLOADER_MODE=none

BUILDDEBUG = FALSE
OPTIMIZE = NONE

CPP = arm-none-eabi-g++.exe
CC =  arm-none-eabi-gcc.exe
ASM = 
ASMTYPE = elf

BIN  = luxengine.elf
BUILDDIR = ./bin/3ds


FINALOUTPUT = $(BUILDDIR)/luxengine.3dsx

#Static Settings
PLATFORM = __3DS__
PLATFORM_DIRECTORY = platform/3ds
PLATFORMBITS = other



PLATFORM_LIBS := -L"$(DEVKITPRO)\devkitARM\lib" -L"$(DEVKITPRO)\libctru\lib"
PLATFORM_LIBS += -march=armv6k -mtune=mpcore -mfloat-abi=hard -specs=3dsx.specs
PLATFORM_LIBS += -lcitro2d -lcitro3d -lctru -lm
PLATFORM_FLAGS :=  -I"include" -I"$(DEVKITPRO)\devkitARM\arm-eabi\include" -I"$(DEVKITPRO)\libctru\include" -I"$(DEVKITPRO)\ports\libsf2d\include"
PLATFORM_FLAGS += -DNO_ZLIB -DMINIZ_NO_TIME -DHAVE_STDINT_H -DHAVE_ALLOCA_H -DAMX_ANSIONLY -DNOCONSOLE -DARM11 -D_3DS
PLATFORM_FLAGS += -march=armv6k -mtune=mpcore -mfloat-abi=hard -Wall

PLATFORM_OBJECTS = 

$(FINALOUTPUT): $(BIN)
#	arm-none-eabi-strip $(BUILDDIR)/$(BIN)
	@smdhtool --create "Mokoi" "Lux Engine 0.98" "Mokoi" "res/mokoi-gaming.png" $(BUILDDIR)/luxengine.smdh
	@3dsxtool $(BUILDDIR)/$(BIN) $(FINALOUTPUT)

