main_menu_init:
	LDA main_menu.entered_world_map
	BEQ .not_on_map
	LDA #$0040
	%conditional_ram_word(TRB, game_state_flags)
	RTL

.not_on_map:
	PHK
	PLB
	JSL disable_screen
	JSL init_registers_global
	JSL clear_VRAM_global
	JSL clear_wram_tables
	LDA #$0009
	STA PPU.layer_mode
	LDA #$0013
	STA PPU.screens
	LDA #$0625
	STA PPU.layer_all_tiledata_base
	LDA #$7C74
	STA PPU.layer_1_2_tilemap_base
	LDA #$0006
	STA PPU.layer_3_4_tilemap_base


;DMA BG1 tiledata/tilemap (use hijacked file select menu payload)
	LDA #$0021
	JSL VRAM_payload_handler


;DMA BG2 palette
	LDA #tv_screen_bg_palette
	LDY #$0010
	LDX #$0010
	JSL DMA_palette


;DMA all purple sprite text palette
	LDA #main_menu_sprite_text_purple_pall_full
	LDY #$0080
	LDX #$001C
	JSL DMA_palette


;Write BG3 text colors
	LDA #$7FFF
	SEP #$30
	LDX #$01
	STX PPU.cgram_address
	STZ PPU.cgram_write
	STZ PPU.cgram_write
	STA PPU.cgram_write
	XBA
	STA PPU.cgram_write
	REP #$30


;Default cursor position
	LDA #$0001
	STA main_menu.menu_active
	STZ main_menu.entered_bonus
	LDA #$0020
	STA main_menu.current_cursor_pos
	LDA #$0040
	STA main_menu.previous_cursor_pos


;Set kong icon slots to 16x16 and initial OAM slot
	LDA #$A000
	STA OAM_attribute[$1E].size
	LDA #$0200
	STA next_OAM_slot


;Init CGRAM address reset HDMA on channel 1
	LDX #$2108					;Direct, fixed transfer
	STX HDMA[1].settings
	LDA.w #cgram_address_reset_HDMA_table
	STA HDMA[1].source_word
	SEP #$20
	LDA #bank(cgram_address_reset_HDMA_table)
	STA HDMA[1].source_bank
	REP #$20


;Init CGRAM write HDMA channel 2 settings
	LDA #$2242					;Indirect
	STA HDMA[2].settings
	LDA.w #menu_HDMA_buffer.indirect_table
	STA HDMA[2].source_word
	SEP #$20
	LDA #bank(menu_HDMA_buffer.indirect_table)
	STA HDMA[2].source_bank
	LDA #$7E
	STA HDMA[2].indirect_source_bank
	REP #$20


;Write indirect table to RAM
	SEP #$30
	LDX #$00
	LDY #$00
.loop:
	LDA menu_colors_HDMA_table,y
	STA.l menu_HDMA_buffer.indirect_table,x
	INY
	INX
	CPX.b #datasize(menu_colors_HDMA_table)
	BNE .loop
	REP #$30


;Write initial color data
	LDX #$0000
--
	LDY #$0000
-
	LDA purple_text_colors,y
	STA.l menu_HDMA_buffer.color_tables,x
	INX
	INX
	CPX #$0048
	BEQ +
	INY
	INY
	CPY #datasize(purple_text_colors)
	BNE -
	BRA --
+

	LDA #$0000
	STA.l sram.unused_1
	STA.l sram.unused_2

	JSL validate_sram
	BCC .valid_save
	JSL set_default_file_status
	JSL save_data_to_sram
	BRA .skip_load

.valid_save:
	JSL load_data_from_sram
.skip_load:
	JSR get_song_id_from_table
	CMP current_song
	BEQ .skip_song
	JSL play_song_with_transition
.skip_song:
	STZ main_menu.entered_world_map
	STZ parry_index
	%conditional_ram_word(STZ, bear_coin_count)
	%conditional_ram_word(STZ, bonus_coin_count)
	%conditional_ram_word(STZ, dk_coin_count)
	%conditional_ram_word(STZ, krematoa_gear_count)
	%conditional_ram_word(STZ, game_state_flags)
	%conditional_ram_word(STZ, kong_letter_flags)


;Clear world map stuff
	LDA #$0630
	LDX #$0070
	JSR clear_RAM_block

	LDA #$8080
	TRB active_cheats			;Disable TUFST cheat
	LDA #$4000
	TSB active_cheats			;Disable HARDR cheat
	STZ savestate.save_exists

	STZ $04EA				;Not clearing this results in being sent to world map if it has a 05 in it after a bonus


;Set fade, NMI and prepare OAM
	LDA #$0100
	JSL set_screen_fade
	JSL prepare_OAM_DMA_channel_global
	JSR set_all_OAM_to_8x8
	LDA #$A000
	STA OAM_attribute[$1E].size		;Mark kong icon slots as 16x16
	LDA #$0200
	STA next_OAM_slot			;Set initial OAM slot
        LDA #main_menu_NMI_hop
	JML set_and_wait_for_NMI




;Direct
cgram_address_reset_HDMA_table:
	db 80 : db $53
	db 20 : db $53
	db 20 : db $53
	db 20 : db $53
	db 20 : db $53
	db 20 : db $53
	db $00



;Indirect
;DMA this instead of loop copy later?
menu_colors_HDMA_table:
	db 1  	: dw menu_HDMA_buffer.world_text_color
	db 1  	: dw menu_HDMA_buffer.world_text_color+2
	db 1  	: dw menu_HDMA_buffer.world_text_color+4
	db 1  	: dw menu_HDMA_buffer.world_text_color+6
	db 1  	: dw menu_HDMA_buffer.world_text_color+8
	db 75 	: dw menu_HDMA_buffer.world_text_color+10


	db 1  	: dw menu_HDMA_buffer.level_text_color
	db 1  	: dw menu_HDMA_buffer.level_text_color+2
	db 1  	: dw menu_HDMA_buffer.level_text_color+4
	db 1  	: dw menu_HDMA_buffer.level_text_color+6
	db 1  	: dw menu_HDMA_buffer.level_text_color+8
	db 18	: dw menu_HDMA_buffer.level_text_color+10


	db 1 	: dw menu_HDMA_buffer.entrance_text_color
	db 1  	: dw menu_HDMA_buffer.entrance_text_color+2
	db 1  	: dw menu_HDMA_buffer.entrance_text_color+4
	db 1  	: dw menu_HDMA_buffer.entrance_text_color+6
	db 1  	: dw menu_HDMA_buffer.entrance_text_color+8
	db 18 	: dw menu_HDMA_buffer.entrance_text_color+10


	db 1 	: dw menu_HDMA_buffer.kong_oder_text_color
	db 1  	: dw menu_HDMA_buffer.kong_oder_text_color+2
	db 1  	: dw menu_HDMA_buffer.kong_oder_text_color+4
	db 1  	: dw menu_HDMA_buffer.kong_oder_text_color+6
	db 1  	: dw menu_HDMA_buffer.kong_oder_text_color+8
	db 20  	: dw menu_HDMA_buffer.kong_oder_text_color+10


	db 1 	: dw menu_HDMA_buffer.color_text_color
	db 1  	: dw menu_HDMA_buffer.color_text_color+2
	db 1  	: dw menu_HDMA_buffer.color_text_color+4
	db 1  	: dw menu_HDMA_buffer.color_text_color+6
	db 1  	: dw menu_HDMA_buffer.color_text_color+8
	db 20  	: dw menu_HDMA_buffer.color_text_color+10


	db 1 	: dw menu_HDMA_buffer.jukebox_text_color
	db 1  	: dw menu_HDMA_buffer.jukebox_text_color+2
	db 1  	: dw menu_HDMA_buffer.jukebox_text_color+4
	db 1  	: dw menu_HDMA_buffer.jukebox_text_color+6
	db 1  	: dw menu_HDMA_buffer.jukebox_text_color+8
	db 1  	: dw menu_HDMA_buffer.jukebox_text_color+10
	db $00



purple_text_colors:
	dw $1462
	dw $28A6
	dw $3CCB
	dw $510F
	dw $6553
	dw $7977

green_text_colors:
	dw $0080
	dw $0100
	dw $0180
	dw $0200
	dw $02A0
	dw $372D









main_menu_init_short:
	JSL disable_screen


%dma_bg($5000, main_menu_tiledata, $7400, main_menu_tilemap)



;DMA all purple sprite text palette
	LDA #main_menu_sprite_text_purple_pall_full
	LDY #$0080
	LDX #$001C
	JSL DMA_palette


;Write complementary text color
	LDA #$7FFF
	SEP #$30
	LDX #$01
	STX PPU.cgram_address
	STZ PPU.cgram_write
	STZ PPU.cgram_write
	STA PPU.cgram_write
	XBA
	STA PPU.cgram_write
	REP #$30


	JSL load_data_from_sram


;Set fade, NMI and prepare OAM
	LDA #$0100
	JSL set_screen_fade
	JSL prepare_OAM_DMA_channel_global
	JSR set_all_OAM_to_8x8
	LDA #$A000
	STA OAM_attribute[$1E].size		;Mark kong icon slots as 16x16
	LDA #$0200
	STA next_OAM_slot			;Set initial OAM slot
        LDA #main_menu_NMI_hop
	JML set_and_wait_for_NMI