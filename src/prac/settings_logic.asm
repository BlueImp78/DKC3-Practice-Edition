settings_logic:
        JSR set_unused_OAM_offscreen
 	JSR update_settings_OAM
 	INC active_frame_counter
 	LDA screen_brightness
 	CMP #$000F
 	BNE .logic_done
 	JSR handle_settings_cursor_and_selections
	LDA settings.cursor_y_position
	CMP #$0008
	BNE .logic_done
	JSR handle_rng_seed_cursor
.logic_done:
	LDA #settings_NMI_hop
	STA NMI_pointer
	SEP #$20
	LDA CPU.nmi_flag
	LDA #$81
	STA CPU.enable_interrupts
-
	WAI
	BRA -



handle_settings_cursor_and_selections:
	LDA player_1_pressed
	BIT #!input_down
	BEQ .check_up
	LDA settings.cursor_y_position
	STA settings.previous_cursor_pos		;Save previous cursor position
	INC
	CMP #$0009
	BCS .wrap_up
	STZ settings.cursor_x_position
	STA settings.cursor_y_position
	RTS

.wrap_up:
	STZ settings.cursor_x_position
	STZ settings.cursor_y_position
.done:
	RTS




.check_up:
	BIT #!input_up
	BEQ .check_R
	LDA settings.cursor_y_position
	STA settings.previous_cursor_pos		;Save previous cursor position
	DEC
	BMI ..wrap_down
	STZ settings.cursor_x_position
	STA settings.cursor_y_position
	RTS

..wrap_down:
	LDA #$0008
	STA settings.cursor_y_position
	RTS


.check_R:
	BIT #!input_R
	BEQ .check_L
	LDA #$0081
	STA screen_fade_speed
	STZ settings.transition_triggered
	RTS


.check_L:
	BIT #!input_L
	BEQ .check_left
	LDA #$0081
	STA screen_fade_speed
	INC settings.transition_triggered
	RTS


.check_left:
	BIT #!input_left
	BEQ .check_right
	JSR .get_selection_cap
	BEQ .done
	LDA settings.selection_base,x
	DEC
	BMI .wrap_right
	BRA .update_selection


.check_right:
	BIT #!input_right
	BEQ .done
+:
	JSR .get_selection_cap
	BEQ .done
	LDA settings.selection_base,x
	INC
	CMP temp_1A
	BCC .update_selection
	STZ settings.selection_base,x
	STZ sram.settings_base,x
	JSL calculate_and_save_checksum
	RTS


.wrap_right:
	LDA temp_1A
	DEC
.update_selection:
	STA settings.selection_base,x
	STA sram.settings_base,x
	JSL calculate_and_save_checksum
	RTS


.get_selection_cap:
	LDA settings.cursor_y_position
	ASL
	TAX
	LDA.l settings_selection_text_table,x
	STA $CE
	LDY #$0000
	LDA [$CE],y				;Get selection cap
	STA temp_1A
	RTS


update_settings_OAM:
	LDA settings.cursor_y_position
	LDX #$3099				;Left arrow
	STX OAM[0].display			;Write arrow sprite to first slot of OAM
	ASL
	TAX
	LDA.w arrow_OAM_positions,x
	STA OAM[0].position
	LDA #OAM_table
	STA next_OAM_slot
	LDX #settings.selection_base
	LDY #$0000
.next:
	LDA.w settings_selection_text_table,y
	STA $CE
	LDA $00,x
	ASL
	PHY
	TAY
	INY
	INY
	LDA [$CE],y
	STA temp_22
	PLY
	LDA.w options_selection_text_pos,y
	STA temp_20
	PHX
	PHY
	JSR render_text
	PLY
	PLX
	INY 					;Move to next option
	INY
	CPY #$0010
	BEQ .print_rng
	INX
	INX					;Move to next address
	BRA .next

.print_rng:
	LDA settings.cursor_y_position
	CMP #$0008
	BNE +
	LDX #$3098
	STX OAM[0].display			;Write arrow sprite to first slot of OAM
	ASL
	TAX
	LDA.w arrow_OAM_positions,x
	STA OAM[0].position
	LDA settings.cursor_x_position
	TAX
	SEP #$20
	LDA OAM[0].x
	CLC
	ADC.l arrow_x_offsets,x
	STA OAM[0].x
	REP #$20
+
	LDA next_OAM_slot
	CLC
	ADC #$0004   				;Set next free OAM address
	STA next_OAM_slot
	LDA #$0004
	STA temp_30				;Loop counter
	LDA #$60C4
	STA temp_32				;X/Y position
	LDA #$0008
	STA temp_34				;X offset
	LDY #$0000
	SEP #$20
..next_rng_byte:
	LDA settings.rng_seed_1,y
	AND #$F0
	LSR
	LSR
	LSR
	LSR
	JSR ..print
	LDA settings.rng_seed_1,y
	AND #$0F
	JSR ..print
	LDA temp_30
	DEC
	BEQ ..done
	CMP #$02
	BNE ..no_tab
	LDX #$8AC4
	STX temp_32
..no_tab:
	STA temp_30
	INY
	BRA ..next_rng_byte


..print:
	LDX next_OAM_slot
	ORA #$F0
	STA OAM_relative[0].tile,x
	LDA #$30
	STA OAM_relative[0].property,x
	LDA temp_32
	STA OAM_relative[0].y,x
	LDA temp_33
	STA OAM_relative[0].x,x
	CLC
	ADC #$08
	STA temp_33
	REP #$20
	TXA
	CLC
	ADC #$0004   				;Set next free OAM address
	STA next_OAM_slot
	SEP #$20
	RTS

..done:
	REP #$20
	RTS


handle_rng_seed_cursor:
	LDA player_1_pressed
	BIT #!input_right
	BEQ .check_left
	LDA settings.cursor_x_position
	INC
	CMP #$0008
	BNE .set_pos
	LDA #$0000
	BRA .set_pos

.check_left:
	BIT #!input_left
	BEQ +
	LDA settings.cursor_x_position
	DEC
	BPL .set_pos
	LDA #$0007
.set_pos:
	STA settings.cursor_x_position
+
	LDA settings.cursor_x_position
	ASL
	TAX
	JSR (handle_rng_seed_nibbles,x)
	RTS


handle_rng_seed_nibbles:
	dw .first_nibble
	dw .second_nibble
	dw .first_nibble
	dw .second_nibble
	dw .first_nibble
	dw .second_nibble
	dw .first_nibble
	dw .second_nibble


.first_nibble:
	JSR .check_ab
	BCC .return
	LDA settings.cursor_x_position
	LSR
	TAX
	SEP #$20
	LDA settings.rng_seed_1,x
	PHA
	AND #$0F
	STA temp_1C
	PLA
	AND #$F0
	STA temp_1E
	LDA temp_1A
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC temp_1E
	ORA temp_1C
	STA settings.rng_seed_1,x
	REP #$20
	JSR .save_seed
.return:
	RTS


.second_nibble:
	JSR .check_ab
	BCC .return
	LDA settings.cursor_x_position
	LSR
	TAX
	SEP #$20
	LDA settings.rng_seed_1,x
	PHA
	AND #$F0
	STA temp_1C
	PLA
	AND #$0F
	CLC
	ADC temp_1A
	AND #$0F				;Wrap if went past #$0F
	ORA temp_1C
	STA settings.rng_seed_1,x
	REP #$20
	JSR .save_seed
	RTS


.check_ab:
	LDA player_1_pressed
	AND #!input_A|!input_B
	BEQ ..no_input
	CMP #!input_A
	BNE ..check_b
	LDA #$0001
	BRA ..set

..check_b:
	CMP #!input_B
	BNE .return
	LDA #$FFFF
..set:
	STA temp_1A
	SEC
	RTS

..no_input:
	CLC
	RTS


.save_seed:
	LDA settings.rng_seed_1
	STA.l sram.rng_seed_1
	LDA settings.rng_seed_2
	STA.l sram.rng_seed_2
	JSL calculate_and_save_checksum
	RTS