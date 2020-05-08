# Lux Engine Makefile
# Build Options
# BUILDOS - windows, linux, apple
# OPTIMIZE - FULL, SOME, NONE
# BUILDDEBUG - TRUE, FALSE
# PLATFORMBITS 64, 32
# CC (Compiler)
# BIN (Binary output)
# CUSTOMSETTINGS - Custom build
# CUSTOMOBJECTS - Uses custom_platform_main.cpp, custom_project_media.cpp and custom_lux_screen.cpp instead of platform_main.cpp, project_media.cpp and lux_screen.cpp

#Default Settings
include setting.mk

#Compiled Files
OBJDIR = $(OBJECTDIR)-$(BUILDMODE)-$(PLATFORMOS)-$(PLATFORMPROCESSOR)
include files.mk

#Read platform and custom settings
include makefiles/$(PLATFORMOS).make
ifneq ($(CUSTOMSETTINGS), )
	include custom/$(CUSTOMSETTINGS).make
endif

include files_opt.mk


#Compiler
PROJECT_FLAGS += -I'src/$(PLATFORM_DIRECTORY)' -DTIXML_USE_STL -DDOWNLOADER_MODE=$(DOWNLOADER_MODE)
COMPILER_FLAGS += -DPLATFORM_$(PLATFORMOSUC) -DPLATFORM_BITS=$(PLATFORMBITS) -DPLATFORM_ARCH=$(PLATFORMPROCESSOR) $(PROJECT_FLAGS) $(PLATFORM_FLAGS)
COMPILER_FLAGSPP += -DPLATFORM_$(PLATFORMOSUC) -DPLATFORM_BITS=$(PLATFORMBITS) -DPLATFORM_ARCH=$(PLATFORMPROCESSOR) $(PROJECT_FLAGS) $(PLATFORM_FLAGS)
COMPILER_LIBS += $(PLATFORM_LIBS)

#Extras Platform Objects
OBJ += $(PLATFORM_OBJECTS)

# Input icons header
UI = $(wildcard res/input/*.txt)
UIH = $(patsubst res/input/%.txt, include/input/%.h, $(UI))


#Build
.PHONY: all-before all clean

all: all-before $(BIN) $(FINALOUTPUT)
	@echo --------------------------------

all-before:
	@-$(MKDIR) $(dir $(OBJDIR))
	@echo --------------------------------
	@echo Building $(BIN) $(PROGRAM_VERSION)
	@echo Build Platform: $(BUILDPLATFORM) $(BUILDMACHINE)
	@echo Target Platform: $(PLATFORMOS)/$(PLATFORMPROCESSOR)
	@echo Build Mode: $(BUILDMODE)
	@echo Build C Flags: $(COMPILER_FLAGS)
	@echo Build C++ Flags: $(COMPILER_FLAGSPP)
	@echo Build Libs: $(COMPILER_LIBS)

clean:
	@echo --------------------------------
	@echo Cleaning $(BIN)
	${RM} $(OBJ) $(BUILDDIR)/$(BIN)

# Resource Headers
$(OBJDIR)/update_input_header.exe:
	@-$(MKDIR) $(dir $@)
	@$(CPP) update_input_header.cpp -o $(OBJDIR)/update_input_header.exe  -s

include/input/%.h: res/input/%.txt
	$(OBJDIR)/update_input_header.exe $< $@

# Code Compling
$(OBJDIR)/%.o : src/%.cpp
	@echo Compiling $@ $(MESSAGE)
	@-$(MKDIR) $(dir $@)
	@$(CPP) -c $(COMPILER_FLAGSPP) -o $@ $<

$(OBJDIR)/%.o : src/%.c
	@echo Compiling $@ $(MESSAGE)
	@-$(MKDIR) $(dir $@)
	@$(CC) -c $(COMPILER_FLAGS) -o $@ $<

$(OBJDIR)/%.o : $(CUSTOMPATH)/%.cpp
	@echo Compiling $@ $(MESSAGE)
	@-$(MKDIR) $(dir $@)
	@$(CPP) -c $(COMPILER_FLAGSPP) -o $@ $<


$(OBJDIR)/%.o : src/%.asm
	@echo Compiling $@ $(MESSAGE) [ASM]
	@-$(MKDIR) $(dir $@)
	@$(ASM) -O1 -f $(ASMTYPE) -o $@ $< -I$(dir $<)

$(BIN): $(OBJDIR)/update_input_header.exe $(UIH) $(OBJ) $(EXTRABINARIES)
	@echo --------------------------------
	@-$(MKDIR) $(OBJDIR)
	@-$(MKDIR) $(BUILDDIR)
	$(CPP) $(OBJ) -o $(BUILDDIR)/$(BIN) $(COMPILER_LIBS)

install-bin: $(BIN)
	@-$(MKDIR) $(INSTALLDIR)
	@cp $(BUILDDIR)/$(BIN) $(INSTALLDIR)/bin/


install: install-bin
	@-$(MKDIR) $(INSTALLDIR)
	@echo --------------------------------
	@echo Installing to $(INSTALLDIR)
	@cp -r ./share/ $(INSTALLDIR)/

compiler:
	$(MAKE) -C $(CURDIR)/../meg/meg_pawn BUILDDIR=$(CURDIR)/$(BUILDDIR)
	$(MAKE) -C $(CURDIR)/../meg/meg_pawn install BUILDDIR=$(CURDIR)/$(BUILDDIR) INSTALLDIR=$(CURDIR)/$(INSTALLDIR)


info:
	@echo --------------------------------
	@echo Build Platform: $(BUILDPLATFORM) $(BUILDMACHINE)
	@echo Target Platform: $(PLATFORMOS)/$(PLATFORMPROCESSOR)
	@echo Build Mode: $(BUILDMODE)
	@echo Build C Flags: $(COMPILER_FLAGS)
	@echo Build C++ Flags: $(COMPILER_FLAGSPP)
	@echo Build Libs: $(COMPILER_LIBS)
