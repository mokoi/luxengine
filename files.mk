#Main code
OBJ += $(OBJDIR)/config.o  $(OBJDIR)/engine.o $(OBJDIR)/entity.o $(OBJDIR)/entity_manager.o $(OBJDIR)/entity_section.o
OBJ += $(OBJDIR)/language.o $(OBJDIR)/map_object.o $(OBJDIR)/misc_functions.o $(OBJDIR)/mokoi_game.o $(OBJDIR)/player.o
OBJ += $(OBJDIR)/save_system.o  $(OBJDIR)/game_system.o $(OBJDIR)/object_effect.o $(OBJDIR)/sprite_sheet.o  $(OBJDIR)/lux_virtual_sprite.o
OBJ += $(OBJDIR)/lux_canvas.o $(OBJDIR)/lux_sprite.o $(OBJDIR)/map.o
OBJ += $(OBJDIR)/world_section.o $(OBJDIR)/map_screen.o $(OBJDIR)/masks.o $(OBJDIR)/lux_polygon.o $(OBJDIR)/map_xml_reader.o $(OBJDIR)/game_config.o
OBJ += $(OBJDIR)/options.o $(OBJDIR)/global_objects.o

OBJ += $(OBJDIR)/gui/css.o $(OBJDIR)/gui/dialog.o $(OBJDIR)/gui/gui_base.o $(OBJDIR)/gui/gui_settings.o $(OBJDIR)/gui/gui_theme.o $(OBJDIR)/gui/widget.o
OBJ += $(OBJDIR)/portal/portal.o $(OBJDIR)/portal/game_info.o $(OBJDIR)/test/test_code.o
OBJ += $(OBJDIR)/display/display.o $(OBJDIR)/display/display_functions.o $(OBJDIR)/display/layers.o $(OBJDIR)/display/graphics_system.o

#Platform code
OBJ += $(OBJDIR)/$(PLATFORM_DIRECTORY)/audio.o $(OBJDIR)/$(PLATFORM_DIRECTORY)/core.o $(OBJDIR)/$(PLATFORM_DIRECTORY)/graphics_native.o $(OBJDIR)/$(PLATFORM_DIRECTORY)/worker.o
OBJ += $(OBJDIR)/$(PLATFORM_DIRECTORY)/platform_controls.o $(OBJDIR)/$(PLATFORM_DIRECTORY)/platform_functions.o $(OBJDIR)/$(PLATFORM_DIRECTORY)/platform_media.o
OBJ += $(OBJDIR)/$(PLATFORM_DIRECTORY)/platform_config.o $(OBJDIR)/$(PLATFORM_DIRECTORY)/display_bitfont.o

#FFI code
OBJ += $(OBJDIR)/entity_systems/ffi_system.o $(OBJDIR)/entity_systems/ffi_object.o $(OBJDIR)/entity_systems/ffi_collisions.o
OBJ += $(OBJDIR)/entity_systems/ffi_path.o $(OBJDIR)/entity_systems/ffi_entities.o $(OBJDIR)/entity_systems/ffi_player.o
OBJ += $(OBJDIR)/entity_systems/ffi_functions.o $(OBJDIR)/entity_systems/ffi_shaders.o $(OBJDIR)/entity_systems/ffi_layer.o
OBJ += $(OBJDIR)/entity_systems/ffi_spritesheet.o $(OBJDIR)/entity_systems/ffi_map.o $(OBJDIR)/entity_systems/ffi_world.o
OBJ += $(OBJDIR)/entity_systems/ffi_game.o $(OBJDIR)/entity_systems/ffi_input.o $(OBJDIR)/entity_systems/ffi_mask.o

#Tinyxml code
OBJ += $(OBJDIR)/libs/tinyxml/tinyxml2.o $(OBJDIR)/libs/tinyxml/tinyxml2ext.o

#elix code
OBJ += $(OBJDIR)/libs/elix/elix_directory.o $(OBJDIR)/libs/elix/elix_endian.o  $(OBJDIR)/libs/elix/elix_file.o $(OBJDIR)/libs/elix/elix_string.o $(OBJDIR)/libs/elix/elix_path.o $(OBJDIR)/libs/elix/elix_png.o $(OBJDIR)/libs/elix/elix_program.o

#Download code
OBJ += $(OBJDIR)/downloader-$(DOWNLOADER_MODE).o




