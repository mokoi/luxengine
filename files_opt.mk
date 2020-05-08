#Custom code
ifeq ($(CUSTOMOBJECTS),TRUE)
	OBJ += $(OBJDIR)/custom_platform_main.o $(OBJDIR)/custom_lux_screen.o $(OBJDIR)/custom_project_media.o
else
	OBJ += $(OBJDIR)/$(PLATFORM_DIRECTORY)/platform_main.o $(OBJDIR)/lux_screen.o $(OBJDIR)/$(PLATFORM_DIRECTORY)/project_media.o
endif

#Pawn code
ifeq ($(INCLUDE_PAWN),TRUE)
	PROJECT_FLAGS += -DPAWN_VERSION=4 -DAMXTIME_NOIDLE -DAMX_NOPROPLIST -DAMXCONSOLE_NOIDLE -DAMX_NODYNALOAD  -DFIXEDPOINT -DFLOATPOINT -Wno-unused-local-typedefs

	OBJ += $(OBJDIR)/entity_systems/pawn_core.o $(OBJDIR)/entity_systems/pawn_float.o $(OBJDIR)/entity_systems/pawn_string.o
	OBJ += $(OBJDIR)/entity_systems/pawn_functions.o $(OBJDIR)/entity_systems/pawn_graphics.o $(OBJDIR)/entity_systems/pawn_player.o
	OBJ += $(OBJDIR)/entity_systems/pawn_entity.o $(OBJDIR)/entity_systems/pawn_maps.o $(OBJDIR)/entity_systems/pawn_game.o
	OBJ += $(OBJDIR)/entity_systems/pawn_network.o  $(OBJDIR)/entity_systems/pawn_online.o $(OBJDIR)/entity_systems/pawn_console.o
	OBJ += $(OBJDIR)/entity_systems/pawn_time.o $(OBJDIR)/entity_systems/pawn_system.o $(OBJDIR)/entity_systems/pawn_input.o
	OBJ += $(OBJDIR)/entity_systems/pawn_fixed.o $(OBJDIR)/entity_systems/pawn.o
	OBJ += $(OBJDIR)/scripting/amx4/amx.o $(OBJDIR)/scripting/amx4/amxcons.o $(OBJDIR)/scripting/amx4/amxcore.o

	ifdef ASM
		PROJECT_FLAGS += -DAMX_ASM
		OBJ += $(OBJDIR)/scripting/amx4/amxexecn.o
	else
		ifdef PAWNSIMPLEEXEC

		else
			PROJECT_FLAGS += -DAMX_ALTCORE
			OBJ += $(OBJDIR)/scripting/amx4/amxexec_gcc.o
		endif
	endif

	ifeq ($(PLATFORMBITS), 64)
		PROJECT_FLAGS += -DPAWN_CELL_SIZE=64 -DHAVE_I64
	else
		PROJECT_FLAGS += -DPAWN_CELL_SIZE=32
	endif

endif

#Squirrel code
ifeq ($(INCLUDE_SQUIRREL),TRUE)
	OBJ += $(OBJDIR)/scripting/squirrel/sqapi.o $(OBJDIR)/scripting/squirrel/sqbaselib.o $(OBJDIR)/scripting/squirrel/sqfuncstate.o
	OBJ += $(OBJDIR)/scripting/squirrel/sqdebug.o $(OBJDIR)/scripting/squirrel/sqlexer.o $(OBJDIR)/scripting/squirrel/sqobject.o
	OBJ += $(OBJDIR)/scripting/squirrel/sqcompiler.o $(OBJDIR)/scripting/squirrel/sqstate.o $(OBJDIR)/scripting/squirrel/sqtable.o
	OBJ += $(OBJDIR)/scripting/squirrel/sqmem.o $(OBJDIR)/scripting/squirrel/sqvm.o $(OBJDIR)/scripting/squirrel/sqclass.o
endif

# OpenGL code
ifeq ($(INCLUDE_OPENGL),TRUE)
	PROJECT_FLAGS += -DOPENGLENABLED -DDISPLAYMODE_OPENGL
	OBJ += $(OBJDIR)/$(PLATFORM_DIRECTORY)/graphics_opengl.o
	OBJ += $(OBJDIR)/gles/gles_display.o $(OBJDIR)/gles/shaders.o
	OBJ += $(OBJDIR)/gles/draw_vertex1.inc.o $(OBJDIR)/gles/draw_vertex2.inc.o
	OBJ += $(OBJDIR)/gles/shaders_desktop.o $(OBJDIR)/gles/shaders_gles.o $(OBJDIR)/gles/shaders_none.o
endif

# Network code
ifeq ($(INCLUDE_NETWORK),TRUE)
	PROJECT_FLAGS += -DNETWORKENABLED
	OBJ += $(OBJDIR)/libs/enet/callbacks.o $(OBJDIR)/libs/enet/host.o  $(OBJDIR)/libs/enet/packet.o $(OBJDIR)/libs/enet/peer.o $(OBJDIR)/libs/enet/protocol.o $(OBJDIR)/libs/enet/list.o
	OBJ += $(OBJDIR)/$(PLATFORM_DIRECTORY)/core_network.o
	OBJ += $(OBJDIR)/map_network.o
endif
