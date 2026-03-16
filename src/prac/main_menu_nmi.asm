main_menu_NMI:
	LDX #stack
	TXS
	STZ PPU.oam_address
	PHK
	PLB
	JSR update_palettes
	JSL prepare_OAM_DMA_channel_global
	LDA #$0601
	STA CPU.enable_DMA
	SEP #$20
	LDA screen_brightness
	STA PPU.screen
	REP #$20
	JSL handle_screen_fade
	JSR read_controller
	JMP main_menu_logic



update_palettes:
	JSR update_cursor_palette
	JMP update_kong_icon_palette


update_cursor_palette:
	LDA main_menu.current_cursor_pos
	PHA
	TAY
	JSR .DMA_green_cursor_palette
	PLA
	CMP main_menu.previous_cursor_pos
	BNE .cursor_changed
.done:
	RTS

.cursor_changed:
	LDY main_menu.previous_cursor_pos
	JSR .DMA_purple_cursor_palette
	BRA .done

.DMA_green_cursor_palette:
	LDX #$0004
	TYA
	CLC
	ADC #$0070
	TAY
	LDA #main_menu_sprite_text_palettes+$20
	JSL DMA_palette
	RTS

.DMA_purple_cursor_palette:
	LDX #$0004
	TYA
	CLC
	ADC #$0070
	TAY
	LDA #main_menu_sprite_text_palettes
	JSL DMA_palette
	RTS


update_kong_icon_palette:
	LDA main_menu.selected_color
	ASL
	TAX
	LDA .icon_palettes,x
	LDY #$00F0
	LDX #$0004
	JSL DMA_palette
	RTS


.icon_palettes:
	dw kong_icons_palette_p1
	dw kong_icons_palette_p2