records_NMI:
	LDX #stack
	TXS
	STZ PPU.oam_address
	JSL prepare_OAM_DMA_channel_global
	SEP #$20
	LDA #$01
	STA CPU.enable_DMA
	LDA screen_brightness
	STA PPU.screen
	REP #$20

	LDA screen_brightness
	BEQ .trigger_transition
	JSL handle_screen_fade
	JSR read_controller
	LDA records.del_mode_enabled
	JSR update_records_palette
	JMP records_logic

.trigger_transition:
	LDA records.transition_triggered
	BEQ ..start_settings
	JML main_menu_init_short


..start_settings:
	JML settings_init



update_records_palette:
	LDA records.del_mode_enabled
	BEQ .set_normal_palette_full
	LDA records.del_cursor_previous_pos
	CMP records.del_cursor_pos
	BEQ .skip_normal_palette
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC #$0092
	SEP #$20
	STA PPU.cgram_address
	REP #$20
	LDA #$7FFF
	SEP #$20
	STA PPU.cgram_write
	XBA
	STA PPU.cgram_write
.skip_normal_palette:
	REP #$20
	LDA active_frame_counter
	BIT #$0007
	BNE .done
	LDA records.text_pal_index
	EOR #$0002
	STA records.text_pal_index
	LDA records.del_cursor_pos
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC #$0092
	SEP #$20
	STA PPU.cgram_address
	LDX records.text_pal_index
	LDA records_text_color_table,x
	STA PPU.cgram_write
	INX
	LDA records_text_color_table,x
	STA PPU.cgram_write
	REP #$20
.done:
	RTS


.set_normal_palette_full:
	LDX #$0081
	LDY #$0008
..loop:
	REP #$30
	LDA #$7FFF
	SEP #$30
	STX PPU.cgram_address
	STZ PPU.cgram_write
	STZ PPU.cgram_write
	STA PPU.cgram_write
	XBA
	STA PPU.cgram_write
	DEY
	BEQ ..done
	TXA
	CLC
	ADC #$10
	TAX
	BRA ..loop
..done:
	REP #$30
	RTS