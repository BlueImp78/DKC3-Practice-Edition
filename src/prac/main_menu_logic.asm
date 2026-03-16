main_menu_logic:
	INC active_frame_counter
	JSR set_unused_OAM_offscreen
	JSR update_OAM
	JSR update_HDMA_buffer_colors
	LDA screen_brightness
	BNE +
	JMP trigger_transition

+
	CMP #$000F
	BNE .logic_done
        JSR handle_menu_cursor_and_selections
	JSR handle_song
	LDA settings.rng
	BNE .set_custom_seed
	JSL get_RNG					;Advance RNG every frame so we dont have predictable bosses or cave inputs
.logic_done:
	LDA #main_menu_NMI_hop
	STA NMI_pointer
	SEP #$20
	LDA CPU.nmi_flag
	LDA #$81
	STA CPU.enable_interrupts
-
	WAI
	BRA -

.set_custom_seed:
	LDA settings.rng_seed_1
	XBA
	STA rng_result
	LDA settings.rng_seed_2
	XBA
	STA rng_seed
	BRA .logic_done

handle_menu_cursor_and_selections:
	LDA player_1_pressed
	BIT #!input_down
	BEQ .check_up
	LDA main_menu.current_cursor_pos
	STA main_menu.previous_cursor_pos		;Save previous cursor position
	CLC
	ADC #$0010
	CMP #$0080
	BNE .move_cursor
	LDA #$0020
.move_cursor:
	STA main_menu.current_cursor_pos
        RTS

.check_up:
	BIT #!input_up
	BEQ ..check_left
	LDA main_menu.current_cursor_pos
	STA main_menu.previous_cursor_pos		;Save previous cursor position
	SEC
	SBC #$0010
	CMP #$0010
	BNE .move_cursor
	LDA #$0070
	BRA .move_cursor


..check_left:
	BIT #!input_left
	BEQ ..check_right
	LDA main_menu.current_cursor_pos
	CMP #$0020
	BNE ...not_on_world
	STZ main_menu.selected_level
...not_on_world:
	CMP #$0040
	BCS ...below_entrance
	STZ main_menu.selected_entrance
...below_entrance:
	JSR get_selection_cap
	DEC main_menu.selection_base,x
	BMI ...wrap
	RTS

...wrap:
	LDA main_menu.current_selection_cap
	DEC
	STA main_menu.selection_base,x
	RTS



..check_right:
	BIT #!input_right
	BEQ ..check_start
	LDA main_menu.current_cursor_pos
	CMP #$0040
	BCS ...below_entrance
	STZ main_menu.selected_entrance
...below_entrance:
	CMP #$0020
	BNE ...not_on_world
	STZ main_menu.selected_level
...not_on_world:
	JSR get_selection_cap
	INC main_menu.selection_base,x
	LDA main_menu.selection_base,x
	CMP main_menu.current_selection_cap
	BCS ...wrap
	RTS

...wrap:
	STZ main_menu.selection_base,x
	RTS


..check_start:
	BIT #!input_start
	BEQ ..check_L
	JSR setup_level
	RTS


..check_L:
	BIT #!input_L
	BEQ ..check_R
	INC main_menu.transition_triggered
..set_fade:
	LDA #$0081
	STA screen_fade_speed
	RTS


..check_R:
	BIT #!input_R
	BEQ ..done
	LDA #$0002
	STA main_menu.transition_triggered
	BRA ..set_fade

..done
	RTS




get_selection_cap:
	LDA main_menu.current_cursor_pos
	LSR
	LSR
	LSR
	LSR
	DEC
	DEC
	ASL
	TAX
	LDA main_menu_selection_cap_values,x
	LDY main_menu.current_cursor_pos
	CPY #$0030
	BNE .not_on_level
	PHX
	LDA main_menu.selected_world
	ASL
	TAX
	LDA main_menu_level_cap_values,x
	STA main_menu.current_selection_cap
	PLX
	RTS

.not_on_level:
	CPY #$0040
	BNE .not_on_entrance
	PHX
	PHA
	LDA main_menu.selected_world
	ASL
	TAX
	LDA world_offset_values_table,x
	STA main_menu.world_index_offset
	LDA main_menu.selected_world
	CLC
	ADC main_menu.selected_level
	ASL
	ADC main_menu.world_index_offset
	TAX
	LDA entrance_cap_table,x
	STA temp_26
	PLA
	INC
	SEC
	SBC temp_26
	PLX
.not_on_entrance:
	STA main_menu.current_selection_cap
	RTS






setup_level:
	LDA #$0082
	STA screen_fade_speed
	LDA main_menu.selected_world
	INC
	%conditional_ram_word(STA, current_world)
	JSR set_level_and_animal
	JSR set_kong_order
	LDA #$0040
	LDX main_menu.selected_color
	BEQ .default_colors
	TSB active_cheats
	BRA +

.default_colors:
	TRB active_cheats
+
	TXA
	STA.l sram.selected_color
	LDA settings.game_mode
	STA current_game_mode
	JSL preserve_menu_player_status
	RTS




set_level_and_animal:
	LDA.w #bank(level_entrances_table)
	STA temp_1C
	LDA main_menu.selected_world
	ASL
	TAX
	LDA world_offset_values_table,x
	STA main_menu.world_index_offset
	LDA main_menu.selected_level
	ASL
	CLC
	ADC main_menu.world_index_offset
	TAX
	LDA level_entrances_table,x
	STA temp_1A
	LDA main_menu.selected_entrance
	ASL
	ASL
	TAY
	LDA [temp_1A],y
	PHA
	AND #$00FF
	STA main_menu.chosen_level_mirror
	STA returning_level_number
	PLA
	AND #$FF00
	XBA
	STA main_menu.chosen_entrance
	LDA settings.player_start
	BEQ .auto
	LDA settings.player_start
	DEC
	ASL
	TAX
	LDA .animal_ids,x
	STA current_animal_type
	STZ current_mount
	RTS

.auto:
	INY
	INY
	LDA [temp_1A],y
	PHA
	AND #$007F
	TAX
	LDA .animal_ids,x
	STA current_animal_type
	PLA
	AND #$00FF
	SEC
	SBC #$0080
	BMI .no_mount
	%conditional_ram_word(LDA, #non_kong_sprite_slots)
	STA current_mount
	RTS

.no_mount:
	STZ current_mount
	RTS


.animal_ids:
	dw $0000
	dw !sprite_ellie
	dw !sprite_enguarde
	dw !sprite_squawks
	dw !sprite_squitter





setup_bear_flags:
	%conditional_ram_word(STZ, inventory_flags+$2)
	%conditional_ram_word(STZ, inventory_flags+$4)
	%conditional_ram_word(STZ, inventory_flags+$6)
	LDA.w #bank(bear_setup_table)
	STA temp_1C
	%conditional_ram_word(LDA, $05E3)
	AND #$FF00
	XBA
	ASL
	TAX
	LDA bear_setup_table,x
	STA temp_1A
	PHX
	LDA main_menu.selected_entrance
	ASL
	TAX
	LDA .offsets,x
	CLC
	ADC temp_1A
	STA temp_1A
	LDY #$0000
	SEP #$20
	LDA [temp_1A],y
	%conditional_ram_word(STA, bear_coin_count)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, bonus_coin_count)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, krematoa_gear_count)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, boomer_explosive_count)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, $0605)
	%conditional_ram_word(STA, inventory_flags)
	INY
	PLX
	REP #$20
	LDA [temp_1A],y
	%conditional_ram_word_idx(STA, brother_bear_dialogue_flags_start,x)
	%conditional_ram_word(STZ, boomer_cog_count)
	%conditional_ram_word(STZ, $05FB)
.done:
	RTS


.offsets:
	dw $0000
	dw $0007
	dw $000E
	dw $0015
	dw $001C
	dw $0023
	dw $002A




setup_world_map_flags:
	JSL init_world_map_flags

;Clear some shit to stop map kong from breaking
	%conditional_ram_word(STZ, $05E3)
	%conditional_ram_word(STZ, map_kong_preserved_x_position)
	%conditional_ram_word(STZ, map_kong_preserved_y_position)
	%conditional_ram_word(STZ, $05F5)
	%conditional_ram_word(STZ, $05F7)

	LDA.w #bank(world_map_setup_table)
	STA temp_1C
	LDA main_menu.selected_level
	ASL
	TAX
	LDA world_map_setup_table,x
	STA temp_1A
	LDY #$0000
	SEP #$20
	LDA [temp_1A],y
	%conditional_ram_word(STA, current_world)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, current_map_vehicle)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, map_node_number)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, returning_node_number)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, $0605)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, inventory_flags)
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, inventory_flags+$2)
	REP #$20
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, $05FB)
	INY
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, $05FD)
	INY
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, funkys_rentals_flags)
	INY
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, docked_vehicle_x_position)
	INY
	INY
	LDA [temp_1A],y
	%conditional_ram_word(STA, docked_vehicle_y_position)
	INY
	INY
	LDA [temp_1A],y
	STA temp_1A
	JMP [temp_1A]




unlock_world_map:
	LDA #$7F3F
	%conditional_ram_word(STA, $0601)
	%conditional_ram_word(STA, $067F)
	%conditional_ram_word(STA, $068F)
	%conditional_ram_word(STA, $0657)
	%conditional_ram_word(STA, $0662)
	%conditional_ram_word(STA, $0667)
	%conditional_ram_word(STA, $066D)
	%conditional_ram_word(STA, $0673)
	%conditional_ram_word(STA, $0676)
	%conditional_ram_word(STA, $0685)
	%conditional_ram_word(STA, $067A)
	%conditional_ram_word(STA, $0687)
	%conditional_ram_word(STA, $067B)
	%conditional_ram_word(STA, $0691)
	%conditional_ram_word(STA, $0693)
	RTS


unlock_levels:
	LDA #$00A1
	STA temp_1A
	LDX #$000D
	LDY #$0010
	JSR .write_flags
	LDX #$0008
	LDY #$001D
	JSR .write_flags
	LDX #$0010
	LDY #$004D
	JSR .write_flags
	LDX #$000D
	LDY #$0003
	JSR .write_flags
	LDA #$003F
	STA temp_1A
	LDX #$0028
	LDY #$0025
.write_flags:
	%conditional_ram_word_idx(LDA, $0632,y)
	ORA temp_1A
	%conditional_ram_word_idx(STA, $0632,y)
	INY
	DEX
	BNE .write_flags
	RTS



set_game_start_map_stuff:
	%conditional_ram_word(STZ, $0695)				;Krematoa locked
	LDA #$000C
	%conditional_ram_word(STA, $0615)				;Reset Bazaar
	%conditional_ram_word(STZ, $0619)				;Reset Bramble
	%conditional_ram_word(STZ, $061D)				;Reset Barnacle
	%conditional_ram_word(STZ, $0623)				;Reset Bazooka
	%conditional_ram_word(STZ, $0601)				;No rocks removed in Krematoa
	%conditional_ram_word(STZ, boomer_explosive_count)
	%conditional_ram_word(STZ, boomer_cog_count)
	%conditional_ram_word(STZ, banana_bird_count)
	%conditional_ram_word(STZ, bear_coin_count)
	%conditional_ram_word(STZ, bonus_coin_count)
	%conditional_ram_word(STZ, dk_coin_count)
	RTS




set_w8_unlock_map_stuff:
	JSR unlock_world_map
	JSR unlock_levels
	%conditional_ram_word(STZ, $0695)				;Krematoa locked
	%conditional_ram_word(STZ, $0601)				;No rocks removed in Krematoa
	%conditional_ram_word(STZ, boomer_explosive_count)
	%conditional_ram_word(STZ, boomer_cog_count)
	%conditional_ram_word(STZ, $062D)				;Reset Boomer
	LDA #$000C
	%conditional_ram_word(STA, $0615)				;Reset Bazaar
	%conditional_ram_word(STZ, $0619)				;Reset Bramble
	%conditional_ram_word(STZ, $061D)				;Reset Barnacle
	%conditional_ram_word(STZ, $0623)				;Reset Bazooka
	LDA #$0006
	%conditional_ram_word(STA, banana_bird_count)
	LDA #$0035
	%conditional_ram_word(STA, bear_coin_count)
	LDA #$004A
	%conditional_ram_word(STA, bonus_coin_count)
	RTS


set_w7_to_w8_map_stuff:
	JSR unlock_world_map
	JSR unlock_levels
	LDA #$7F3F
	%conditional_ram_word(STA, $0695)				;Krematoa unlocked
	%conditional_ram_word(STZ, $0601)				;No rocks removed in Krematoa
	%conditional_ram_word(STZ, boomer_explosive_count)
	%conditional_ram_word(STZ, boomer_cog_count)
	%conditional_ram_word(STZ, $062D)				;Reset Boomer
	%conditional_ram_word(STZ, $0615)				;Empty bazaar inventory
	%conditional_ram_word(STZ, $0619)				;Reset Bramble
	%conditional_ram_word(STZ, $061D)				;Reset Barnacle
	%conditional_ram_word(STZ, $0623)				;Reset Bazooka
	LDA #$0006
	%conditional_ram_word(STA, banana_bird_count)
	LDA #$004A
	%conditional_ram_word(STA, bonus_coin_count)
	RTS


set_103_cleanup_map_stuff:
	JSR unlock_world_map
	JSR unlock_levels
	LDA #$7F3F
	%conditional_ram_word(STA, $0695)				;Krematoa unlocked
	LDA #$0006
	%conditional_ram_word(STA, boomer_explosive_count)
	LDA #$0500
	%conditional_ram_word(STA, boomer_cog_count)
	LDA #$8000
	%conditional_ram_word(STA, $062D)				;Set boomer to last visit (red palette and fan)
	%conditional_ram_word(STZ, $0615)				;Empty bazaar inventory
	%conditional_ram_word(STZ, $0619)				;Reset Bramble
	%conditional_ram_word(STZ, $061D)				;Reset Barnacle
	%conditional_ram_word(STZ, $0623)				;Reset Bazooka
	LDA #$9090
	%conditional_ram_word(STA, $0629)				;Enable Bjorn lifts
	LDA #$0006
	%conditional_ram_word(STA, banana_bird_count)
	LDA #$0035
	%conditional_ram_word(STA, bear_coin_count)
	%conditional_ram_word(STZ, bonus_coin_count)
	LDA #$0029
	%conditional_ram_word(STA, dk_coin_count)
	RTS




set_kong_order:
	LDA main_menu.selected_kongs
	ASL
	TAX
	JMP (.kong_order_table,x)

.kong_order_table:
	dw .solo_dixie
	dw .dixie_and_kiddy
	dw .solo_kiddy
	dw .kiddy_and_dixie


.solo_dixie:
	%conditional_ram_word(STZ, current_kong)
	STZ menu_player_status.current_kong
-
	LDA #$4000
	%conditional_ram_word(TRB, game_state_flags)
	TRB menu_player_status.game_state_flags
	RTS

.solo_kiddy
	LDA #$0001
	%conditional_ram_word(STA, current_kong)
	STA menu_player_status.current_kong
	BRA -

.dixie_and_kiddy:
	%conditional_ram_word(STZ, current_kong)
	STZ menu_player_status.current_kong
--
	LDA #$4000
	%conditional_ram_word(TSB, game_state_flags)
	TSB menu_player_status.game_state_flags
	RTS

.kiddy_and_dixie:
	LDA #$0001
	%conditional_ram_word(STA, current_kong)
	STA menu_player_status.current_kong
	BRA --





update_OAM:
	LDA #$0200
	STA next_OAM_slot
	JSR .update_text
	JMP .update_kong_icons


.update_text:
;Practice Menu text
	LDA #$1080
	STA main_menu.text_OAM_offset
	LDA prac_menu_text
	STA temp_22
	LDA #$3002
	STA main_menu.text_pal_index_offset
	LDA.w #bank(prac_menu_text)
	JSR build_OAM_text

;World text
	LDA main_menu.selected_world
	ASL
	TAX
	LDA #$388C
	STA main_menu.text_OAM_offset
	LDA world_text_table,x
	STA temp_22
	LDA #$3202
	STA main_menu.text_pal_index_offset
	LDA.w #bank(world_text_table)
	JSR build_OAM_text

;Level text
	LDA main_menu.selected_world
	ASL
	TAX
	LDA world_offset_values_table,x
	STA temp_1E
	LDA main_menu.selected_level
	ASL
	CLC
	ADC temp_1E
	TAX
	LDA #$518C
	STA main_menu.text_OAM_offset
	LDA level_text_table,x
	STA temp_22
	LDA #$3402
	STA main_menu.text_pal_index_offset
	LDA.w #bank(level_text_table)
	JSR build_OAM_text

;Entrance text
	LDA #$6AA4
	STA main_menu.text_OAM_offset
	LDA.w #bank(level_entrances_table)
	STA temp_1C
	LDA main_menu.selected_world
	ASL
	TAX
	LDA world_offset_values_table,x
	STA main_menu.world_index_offset
	LDA main_menu.selected_level
	ASL
	CLC
	ADC main_menu.world_index_offset
	TAX
	LDA level_entrances_table,x
	STA temp_1A
	LDA main_menu.selected_entrance
	ASL
	ASL
	TAY
	INY
	INY
	LDA [temp_1A],y
	XBA
	AND #$00FF
	TAX
	LDA entrance_text_table,x
	STA temp_22
	LDA #$3602
	STA main_menu.text_pal_index_offset
	LDA.w #bank(entrance_text_table)
	JSR build_OAM_text

;Color text
	LDA main_menu.selected_color
	ASL
	TAX
	LDA #$9C8E
	STA main_menu.text_OAM_offset
	LDA color_numbers_table,x
	STA temp_22
	LDA #$3A02
	STA main_menu.text_pal_index_offset
	LDA.w #bank(color_numbers_table)
	JSR build_OAM_text

;Jukebox text
	LDA main_menu.selected_song
	ASL
	TAX
	LDA #$B59C
	STA main_menu.text_OAM_offset
	LDA song_text_table,x
	STA temp_22
	LDA #$3C02
	STA main_menu.text_pal_index_offset
	LDA.w #bank(song_text_table)
	JSR build_OAM_text
.return:
	RTS




.update_kong_icons:
	LDA main_menu.selected_kongs
	ASL
	TAX
	JMP (.get_kong_icon,x)

.get_kong_icon:
	dw .solo_dixie
	dw .dixie_and_kiddy
	dw .solo_kiddy
	dw .kiddy_and_dixie


.solo_dixie:
 	LDA #$01F8
 	STA next_OAM_slot
	LDY next_OAM_slot
	LDA #$877E
	STA OAM[0].position,y
	LDA #$2E7A
	STA OAM[0].display,y
	RTS

.dixie_and_kiddy:
	JSR .solo_dixie
 	LDA #$01FC
 	STA next_OAM_slot
	LDY next_OAM_slot
	LDA #$8791
	STA OAM[0].position,y
	LDA #$2E7C
	STA OAM[0].display,y
	RTS

.solo_kiddy:
 	LDA #$01F8
 	STA next_OAM_slot
	LDY next_OAM_slot
	LDA #$877E
	STA OAM[0].position,y
	LDA #$2E7C
	STA OAM[0].display,y
	RTS

.kiddy_and_dixie:
	JSR .solo_kiddy
 	LDA #$01FC
 	STA next_OAM_slot
	LDY next_OAM_slot
	LDA #$8791
	STA OAM[0].position,y
	LDA #$2E7A
	STA OAM[0].display,y
	RTS




;Tweaked DKC2 routine to construct the 8x16 text from 8x8 tiles
build_OAM_text:
	STA temp_24
	LDY next_OAM_slot
	LDA #$C902
	XBA
	CLC
	ADC main_menu.text_OAM_offset
	BCS .idk1
	CMP #$E000
	BCC .idk2
.idk1:
	LDA #$E000
.idk2:
	STA temp_1A
.idk3:
	LDA [temp_22]
	AND #$00FF
	BEQ .done
	CMP #$0020
	BEQ .idk4
	SEC
	SBC #$0021
	TAX


	LDA font_tile_offsets,x
	AND #$00FF
	ASL
	CLC
	ADC main_menu.text_pal_index_offset
	STA temp_1C


	LDA temp_1A
	STA OAM_relative[0].position,y
	LDA temp_1C
	STA OAM_relative[0].display,y
	LDA temp_1A
	CLC
	ADC #$0800
	STA OAM_relative[1].position,y
	INC temp_1C
	LDA temp_1C
	STA OAM_relative[1].display,y
	TYA
	CLC
	ADC #$0008
	STA next_OAM_slot
	TAY
.idk4:
	INC temp_22
	LDA temp_1A
	CLC
	ADC #$0008
	STA temp_1A
	BRA .idk3

.done:
	RTS



handle_song:
	LDA main_menu.current_cursor_pos
	CMP #$0070
	BNE .no_press
	LDA player_1_pressed
	BIT #!input_ABXY
	BEQ .no_press
	JSR get_song_id_from_table
	JSL play_song_with_transition
	LDA main_menu.selected_song
	STA.l sram.selected_song
.no_press:
	RTS



update_HDMA_buffer_colors:
	PHK
	PLB
	LDA main_menu.current_cursor_pos
	SEC
	SBC #$0020
	LSR
	LSR
	LSR
	TAX
	LDA .offsets,x
	TAX
	LDY #$0000
-
	LDA green_text_colors,y
	STA.l menu_HDMA_buffer.color_tables,x
	INX
	INX
	INY
	INY
	CPY #datasize(green_text_colors)
	BNE -

;For previous pos
	LDA main_menu.previous_cursor_pos
	SEC
	SBC #$0020
	LSR
	LSR
	LSR
	TAX
	LDA .offsets,x
	TAX
	LDY #$0000
-
	LDA purple_text_colors,y
	STA.l menu_HDMA_buffer.color_tables,x
	INX
	INX
	INY
	INY
	CPY #datasize(purple_text_colors)
	BNE -
	RTS


.offsets:
	dw $0000
	dw $000C
	dw $0018
	dw $0024
	dw $0030
	dw $003C

.end



trigger_transition:
	LDA main_menu.transition_triggered
	STZ main_menu.transition_triggered
	BEQ .start_level
	CMP #$0001
	BEQ .start_settings
	JMP records_init


.start_settings:
	JML settings_init



.start_level:
	JSL clear_timer_ram
	STZ main_menu.fade_started
	LDA main_menu.selected_world
	CMP #$0008
	BEQ .start_world_map
	CMP #$0009
	BEQ .start_bear_house
	CMP #$000A
	BEQ .start_crystal_cave
	%conditional_ram_word(STZ, $05E3)
	JSR check_tufst
.no_tufst:
	LDA main_menu.chosen_level_mirror
	PHA
	CMP #!bonus_level_range_start
	BCC .check_exit_room
	INC main_menu.entered_bonus
	LDA #!music_bonus_time_2
	CMP current_song
	BEQ .init_level
	JSL play_song_with_transition
.init_level:
	PLA
	JML init_level

.check_exit_room:
	CMP #!level_bazzas_blockade_exit_room
	BEQ .play_water_song
	CMP #!level_fish_food_frenzy_exit_room
	BEQ .play_water_song
	CMP #!level_floodlit_fish_exit_room
	BEQ .play_water_song
	BRA .init_level

.play_water_song:
	LDA #!music_water_world
	CMP current_song
	BEQ .init_level
	JSL play_song_with_transition
	BRA .init_level



.start_world_map:
	INC main_menu.entered_world_map
	JSR check_tufst
	JSR setup_world_map_flags
	JML $BBA250



.start_bear_house:
	STZ active_frame_counter
	LDA main_menu.selected_level
	XBA
	ORA #$000A
	%conditional_ram_word(STA, $05E3)
	JSR setup_bear_flags
	LDA #generic_level_NMI
	STA $4C
	JSR check_tufst
	LDA #init_npc_or_cave_screen
	LDX.w #bank(init_npc_or_cave_screen)
	JML set_and_wait_for_NMI_2


.start_crystal_cave:
	LDA #$1408
	%conditional_ram_word(STA, $05E3)
	LDA main_menu.selected_level
	TAX
	LDA crystal_cave_bird_counts,x
	AND #$00FF
	%conditional_ram_word(STA, banana_bird_count)
	LDA #generic_level_NMI
	STA $4C
	JSR check_tufst
	LDA #init_npc_or_cave_screen
	LDX.w #bank(init_npc_or_cave_screen)
	JML set_and_wait_for_NMI_2


check_tufst:
	LDA player_1_held
	BIT #!input_start
	BEQ .return
	LDA #$4000
	TRB active_cheats
	LDA #$8080
	TSB active_cheats			;Enable TUFST cheat
.return:
	RTS