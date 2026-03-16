map_kong_pos_preserve_check:
	LDA fast_retry_type
	BNE .return
	LDX active_kong_sprite
	LDY sprite.x_position,x
	PLA : PLB				;Pop JSL
	JML preserve_map_kong_position+$8

.return:
	RTL


handle_bear_house_inputs:
	JSL copy_player_inputs

;Also handle quitting on select press here cuz convenient spot + update timer if entered from map
	LDA main_menu.entered_world_map
	BEQ .skip_timer
	JSL update_timer_in_level
	BRA .return

.skip_timer:
	LDA player_inputs_copy.p1_pressed
	BIT #!input_select
	BNE .set_fadeout



.return:
	LDX #$0001				;Hijacked instruction
	LDA #$0080				;Hijacked instruction
	RTL

.set_fadeout:
	LDA #$820F
	JSL set_screen_fade
	;INC main_menu.fade_started
	BRA .return



clear_timer_ram_on_map:
	%conditional_ram_word(STA, $05E3)
	JSL clear_timer_ram
if !version == !us
	LDA #$807B
else
	LDA #$8081
endif
	RTL