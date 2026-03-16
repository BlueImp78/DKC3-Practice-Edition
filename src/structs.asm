include

struct OAM OAM_table
	.position:
	.x				skip 1
	.y				skip 1
	.display
	.tile				skip 1
	.property			skip 1
endstruct


struct OAM_relative $0000
	.position:
	.x				skip 1
	.y				skip 1
	.display
	.tile				skip 1
	.property			skip 1
endstruct


struct OAM_attribute OAM_attribute_table
	.size				skip 1
endstruct






struct sprite $0000
	.type 				skip 2 		;00,x
	.main_routine_address:		skip 2 		;02,x
	.main_routine_bank:		skip 2 		;04,x
	.constants_address:		skip 2  	;06,x
	.placement_number:		skip 2  	;08,x
	.placement_parameter:		skip 2  	;0A,x
	.offscreen_despawn_time:	skip 2  	;0C,x
	.render_order:			skip 2  	;0E,x
	.x_sub_position:		skip 2  	;10,x
	.x_position:			skip 2  	;12,x
	.y_sub_position:		skip 2  	;14,x
	.y_position:			skip 2  	;16,x
	.ground_y_position:		skip 2  	;18,x
	.ground_distance:		skip 2  	;1A,x
	.terrain_attributes:		skip 2  	;1C,x
	.oam_property:			skip 2  	;1E,x
	.last_rendered_graphic:		skip 2  	;20,x
	.current_graphic_mirror:	skip 2  	;22,x
	.current_graphic:		skip 2  	;24,x
	.display_mode:			skip 2  	;26,x
	.terrain_interaction:		skip 2  	;28,x
	.x_speed:			skip 2  	;2A,x
	.unknown_2C:			skip 1  	;2C,x
	.unknown_2D:			skip 1		;2D,x
	.y_speed:			skip 2  	;2E,x
	.max_x_speed:			skip 2  	;30,x
	.unknown_32:			skip 1  	;32,x
	.unknown_33:			skip 1  	;33,x
	.max_y_speed:			skip 2  	;34,x
	.slip_velocity:			skip 2  	;36,x
	.state:				skip 1  	;38,x
	.sub_state:			skip 1  	;39,x
	.interaction_flags:		skip 2  	;3A,x
	.carry_or_defeat_flags:		skip 2  	;3C,x
	.unknown_3E:			skip 2  	;3E,x   34,x in DKC2
	.animation_id:			skip 2  	;40,x
	.animation_timer:		skip 2  	;42,x
	.animation_speed:		skip 2  	;44,x
	.animation_address:		skip 2  	;46,x
	.animation_routine:		skip 2  	;48,x
	.animation_flags:		skip 2  	;4A,x
	.general_purpose_4C:		skip 2  	;4C,x
	.general_purpose_4E:		skip 2  	;4E,x
	.general_purpose_50:		skip 2  	;50,x
	.general_purpose_52:		skip 2  	;52,x
	.unknown_54:			skip 2  	;54,x   sometimes copy of X position
	.unknown_56:			skip 2  	;56,x   sometimes copy of Y position
	.unknown_58:			skip 2  	;58,x   standable sprite related?
	.movement_state:		skip 1  	;5A,x
	.movement_sub_state:		skip 1  	;5B,x
	.general_purpose_5C:		skip 2  	;5C,x   movement behavior: home X position
	.general_purpose_5E:		skip 2  	;5E,x   movement behavior: home Y position
	.general_purpose_60:		skip 2  	;60,x   movement behavior: horizontal deviation distance
	.general_purpose_62:		skip 2  	;62,x   movement behavior: X velocity
	.general_purpose_64:		skip 2  	;64,x   movement behavior: vertical deviation distance
	.general_purpose_66:		skip 2  	;66,x   movement behavior: Y velocity
	.general_purpose_68:		skip 2  	;68,x   movement behavior?
	.general_purpose_6A:		skip 2  	;6A,x   movement behavior?
	.general_purpose_6C:		skip 2  	;6C,x   movement behavior?
endstruct

















;Hack specific

struct sram $B06000
	.additive_checksum		skip 2		;$6000 / $000
	.xor_checksum			skip 2		;$6002 / $002
	.selected_color			skip 2		;$6004 / $004
	.selected_song			skip 2		;$6006 / $006
	.settings_base:
		.game_mode		skip 2		;$6008 / $008
		.show_timer		skip 2		;$600A / $00A
		.show_lag_counter	skip 2		;$600C / $00C
		.show_sprite_slots	skip 2		;$600E / $00E
		.input_display		skip 2		;$6010 / $010
		.mute_bgm		skip 2		;$6012 / $012
		.records_slot		skip 2		;$6014 / $014
		.rng			skip 2		;$6016 / $016
		.rng_seed_1		skip 2		;$6018 / $018
		.rng_seed_2		skip 2		;$601A / $01A
		.unused_1		skip 2		;$601C / $01C
		.unused_2		skip 2		;$601E / $01E
	.best_times					;$6020 / $020
endstruct align 1760


if !version == !us
struct main_menu $1DA4
else
struct main_menu $1E34
endif
	.menu_active			skip 2
	.transition_triggered		skip 2
	.entered_bonus			skip 2
	.current_cursor_pos		skip 2
	.previous_cursor_pos		skip 2
	.cursor_selection		skip 2
	.current_selection_cap		skip 2
	.selection_base:
		.selected_world		skip 2
		.selected_level		skip 2
		.selected_entrance	skip 2
		.selected_kongs		skip 2
		.selected_color		skip 2
		.selected_song		skip 2
	.world_index_offset		skip 2
	.text_OAM_offset		skip 2
	.text_pal_index_offset		skip 2
	.chosen_level_mirror		skip 2
	.chosen_entrance		skip 2
	.game_state_flags_mirror	skip 2
	.active_kong_sprite_mirror	skip 2
	.entered_world_map		skip 2
	.fade_started		skip 2		;Not really menu related but can go here ig lol
	.end
endstruct







struct settings main_menu.end
	.transition_triggered		skip 2
	.cursor_x_position		skip 2
	.cursor_y_position		skip 2
	.previous_cursor_pos		skip 2
	.selection_base:
		.game_mode		skip 2
		.show_timer		skip 2
		.top_left_display	skip 2
		.input_display		skip 2
		.mute_bgm		skip 2
		.records_slot		skip 2
		.player_start		skip 2
		.rng			skip 2
		.rng_seed_1		skip 2
		.rng_seed_2		skip 2
	.end
endstruct


struct records settings.end
	.transition_triggered		skip 2
	.is_first_boot			skip 2
	.cursor_position		skip 2
	.del_mode_enabled		skip 2
	.del_cursor_pos			skip 2
	.del_cursor_previous_pos	skip 2
	.text_pal_index			skip 2
	.end
endstruct




struct menu_player_status records.end
	.current_level			skip 2
	.game_state_flags		skip 2
	.active_kong_sprite		skip 2
	.current_kong			skip 2
	.kong_letter_flags		skip 2
	.current_animal_type		skip 2
	.current_mount			skip 2
	.parry_index			skip 2
	.rng_seed_1			skip 2
	.rng_seed_2			skip 2
	.end
endstruct



struct previous_player_status menu_player_status.end
	.current_level			skip 2
	.current_entrance		skip 2
	.game_state_flags		skip 2
	.active_kong_sprite		skip 2
	.current_kong			skip 2
	.kong_letter_flags		skip 2
	.current_animal_type		skip 2
	.current_mount			skip 2
	.parry_index			skip 2
	.rng_seed_1			skip 2
	.rng_seed_2			skip 2
	.end
endstruct



struct timer previous_player_status.end
	.started			skip 2
	.stopped			skip 2
	.frames:			skip 2
		.frames_mirror		skip 2
	.minutes:			skip 2
		.minutes_mirror		skip 2
	.seconds:			skip 2
		.seconds_mirror		skip 2
	.previous_frame			skip 2
	.lag_frames			skip 2
	.real_frames			skip 2
	.bleak_or_boomer_frame		skip 2
	.bleak_or_boomer_frame_oam	skip 2
	.end
endstruct



struct timer_hud timer.end
	.frames				skip 2
	.minutes			skip 2
	.seconds			skip 2
	.end
endstruct




struct savestate timer_hud.end
	.save_exists			skip 2
	.copy_restore_routine		skip 2
	;.shit				skip 2
	.screen_scroll_x_copy		skip 2
	.screen_scroll_y_copy		skip 2
	.end				skip 2
endstruct


struct player_inputs_copy savestate.end
	.p1_pressed			skip 2
	.p1_held			skip 2
endstruct


struct menu_HDMA_buffer HDMA_buffer
	.indirect_table			skip 192

	.color_tables:
		.world_text_color	skip 12
		.level_text_color	skip 12
		.entrance_text_color	skip 12
		.kong_oder_text_color	skip 12
		.color_text_color	skip 12
		.jukebox_text_color	skip 12
endstruct


struct savestate_buffer $7FB000
	.active_frame_counter		skip 2
	.rng_result			skip 2
	.rng_seed			skip 2
	.direct_page			skip 248
	.low_ram			skip 7680
	.follower_waypoint_buffer	skip 256
	.banana_tracking_buffer		skip 534
	.sprite_tracking_buffer		skip 1024
	.camera_buffer			skip 2048
	.cgram				skip 512
endstruct