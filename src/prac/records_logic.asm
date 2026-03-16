records_logic:
	JSR set_unused_OAM_offscreen
 	JSR update_records_OAM
	INC active_frame_counter
 	LDA screen_brightness
 	CMP #$000F
 	BNE .logic_done
  	JSR handle_records_cursor_and_selections
.logic_done:
	LDA #records_NMI_hop
	STA NMI_pointer
	SEP #$20
	LDA CPU.nmi_flag
	LDA #$81
	STA CPU.enable_interrupts
-
	WAI
	BRA -



handle_records_cursor_and_selections:
	LDA player_1_pressed
	BIT #!input_left
	BNE .cursor_left
	BIT #!input_right
	BNE .cursor_right
	BIT #!input_R
	BNE .init_settings
        BIT #!input_L
        BNE .init_main_menu
	BIT #!input_select
	BNE .toggle_delete_mode
	LDA records.del_mode_enabled
	BNE .handle_del_mode_inputs
.done:
	RTS

.cursor_left:
	LDA records.cursor_position
	DEC
	BPL .update_cursor_pos
	LDA #$0007
.update_cursor_pos:
	STA records.cursor_position
.force_del_cursor_pal_update:
	LDA records.del_cursor_pos
	STA records.del_cursor_previous_pos
	STZ records.del_cursor_pos
	RTS

.cursor_right:
	LDA records.cursor_position
	INC
	CMP #$0008
	BCC .update_cursor_pos
	STZ records.cursor_position
	BRA .force_del_cursor_pal_update

.init_settings:
	LDA #$0081
	STA screen_fade_speed
	STZ records.transition_triggered
	STZ records.del_mode_enabled
        RTS

.init_main_menu:
	LDA #$0081
	STA screen_fade_speed
	INC records.transition_triggered
	STZ records.del_mode_enabled
        RTS

.toggle_delete_mode:
	LDA records.del_mode_enabled
	EOR #$0001
	STA records.del_mode_enabled
	STZ records.del_cursor_pos
	STZ records.del_cursor_previous_pos
	RTS


.handle_del_mode_inputs:
	LDA player_1_pressed
	BIT #!input_down
	BNE ..del_cursor_down
	BIT #!input_up
	BNE ..del_cursor_up
	BIT #!input_X
	BNE ..delete_selected_time
..done:
	RTS


..delete_selected_time:
	LDA records.cursor_position
	ASL
	TAX
	LDA.l records_world_adress_offsets,x
	STA temp_1A
	LDA settings.records_slot
	ASL
	TAX
	LDA.l records_slot_sram_offsets,x
	STA temp_1C
	LDA records.del_cursor_pos
	ASL
	ASL
	ASL
	CLC
	ADC temp_1A
	TAX
	LDA #$FFFF
	STA $7E0000,x
	TXA
	SEC
	SBC #recorded_times
	CLC
	ADC temp_1C
	TAX
	LDA #$FFFF
	STA.l sram.best_times,x
	RTS


..del_cursor_down:
	LDA records.del_cursor_pos
	STA records.del_cursor_previous_pos
	INC
	CMP temp_24
	BCS ..wrap_down
	STA records.del_cursor_pos
	RTS

..wrap_down:
	STZ records.del_cursor_pos
	RTS


..del_cursor_up:
	LDA records.del_cursor_pos
	STA records.del_cursor_previous_pos
	DEC
	BMI ..wrap_up
	STA records.del_cursor_pos
	RTS

..wrap_up:
	LDA temp_24
	DEC
	STA records.del_cursor_pos
	RTS








update_records_OAM:
	JSR .update_world_text
	JSR .update_level_text
	JMP .update_times_text


.update_world_text:
	LDA #OAM_table-4
	STA next_OAM_slot
	LDA records.cursor_position
	ASL
	TAX
	LDA records_world_text,x
	STA temp_22			;Set text table address
	LDA #$7187
	STA temp_20			;Set oam tile position
	LDA #$0030
	STA temp_26			;Set oam tile property
	JSR render_text
	RTS


.update_level_text:
	LDA #$000A
	STA temp_20			;Set initial OAM Y pos
	LDA #$0032			;Set initial OAM tile property
	STA temp_26
	LDA records.cursor_position
	ASL
	TAX
	LDA records_level_names,x
	STA $CE
	LDY #$0000
	LDA [$CE],y
	STA temp_24			;Store cap
	LDX #$0000
	INY				;Move to next address
	INY
..next:
	LDA [$CE],y
	STA temp_22			;Store text address
	SEP #$20
	LDA #$02
	STA temp_21			;Reset OAM X positon that routine INC's
	REP #$20
	PHX
	PHY
	JSR render_text
	PLY
	PLX
	INX
	CPX temp_24			;Check if we exceeded the cap
	BCS ..done
	INY				;Move to next address
	INY
	INC temp_20
	INC temp_20			;Offset Y pos for next text
	INC temp_26
	INC temp_26			;Set next palette slot
	BRA ..next
..done:
	RTS



.update_times_text:
	PHB
	LDA #$150A
	STA temp_20			;Set initial OAM Y pos
	LDA #$0032			;Set initial OAM tile property
	STA temp_26
	LDA records.cursor_position
	ASL
	TAX
	LDA records_level_names,x
	STA $CE
	LDY #$0000
	LDA [$CE],y
	STA temp_24			;Store cap for how many levels to render the text for
	LDA records_world_adress_offsets,x
	TAY
	LDX #$0000
..next:
	SEP #$20
	LDA #$15
	STA temp_21			;Reset OAM X positon that routine INC's
	REP #$20
	PEA $7E7E			;Set DB to WRAM
	PLB
	PLB
	LDA $0000,y
	BMI ..print_placeholder_text
	STY temp_22
	PHX
	PHY
	JSR render_text
	PLY
	PLX
..fuck:
	INX
	CPX temp_24			;Check if we exceeded the cap
	BCS ..done
	INC temp_20
	INC temp_20			;Offset Y pos for next text
	INC temp_26
	INC temp_26 			;Move to next palette slot
	TYA
	CLC
	ADC #$0008			;Move to next text
	TAY
	BRA ..next

..done:
	PLB
	RTS


..print_placeholder_text:
	PEA $BABA			;Set DB to bank of placeholder text
	PLB
	PLB
	PHX
	PHY
	LDY #placeholder_text
	STY temp_22
	JSR render_text
	PLY
	PLX
	BRA ..fuck