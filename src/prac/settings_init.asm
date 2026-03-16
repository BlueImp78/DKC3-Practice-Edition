settings_init:
	JSL disable_screen


%dma_bg($5000, settings_tiledata, $7400, settings_tilemap)


;DMA Layer 1 Palette
	LDA #settings_palette
	LDY #$0060
	LDX #datasize(records_palette)/8
	JSL DMA_palette



;write oam text colors
	LDA #$7FFF
	SEP #$30
	LDX #$81
	STX PPU.cgram_address
	STZ PPU.cgram_write
	STZ PPU.cgram_write
	STA PPU.cgram_write
	XBA
	STA PPU.cgram_write
	REP #$30


	LDA #$0100
	JSL set_screen_fade
	STZ settings.cursor_x_position
	STZ settings.cursor_y_position
	JSR set_all_OAM_to_8x8
	LDA #$BA00
	STA $CF					;Set bank to use for text
	LDA #$0030
	STA temp_26 				;Set OAM properties to use for text
	LDA #settings_NMI_hop
	JML set_and_wait_for_NMI