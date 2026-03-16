settings_NMI:
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
	JMP settings_logic

.trigger_transition:
	LDA settings.transition_triggered
	BNE ..start_records
	JMP main_menu_init_short


..start_records:
	JMP records_init

