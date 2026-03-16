records_init:
	JSL disable_screen


	%dma_bg($5000, records_tiledata, $7400, records_tilemap)



;DMA Layer 1 Palette
	LDA #records_palette
	LDY #$0060
	LDX #datasize(records_palette)/8
	JSL DMA_palette


	JSL load_data_from_sram


	LDA #$0100
	JSL set_screen_fade
	JSR set_all_OAM_to_8x8
	LDA #$3075
	STA OAM[0].display			;Write arrow sprite to first slot of OAM
	LDA #$BA00
	STA $CF					;Set bank to use for text
	LDA #$0030
	STA temp_26 				;Set OAM properties to use for text
	STZ records.cursor_position
	STZ records.del_cursor_pos
	LDA #records_NMI_hop
	JML set_and_wait_for_NMI