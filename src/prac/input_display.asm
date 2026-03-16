handle_input_display:
	PHB
	PHK
	PLB
	LDY player_active_held
	%conditional_ram_word(LDA, parent_level_number)
	CMP #!level_poisonous_pipeline
	BNE .no_invert
	JSR check_underwater
	BEQ .no_invert
	LDA player_active_held+$1
	AND #$0003
	ASL
	TAX
	LDA inputs_to_invert,x
	EOR player_active_held
	AND #!input_left|!input_right
	EOR player_active_held
	TAY
.no_invert:
	STY player_active_held_mirror
	LDY #$0000
	LDX next_OAM_slot
.write_positions:
	LDA settings.input_display
	CMP #$0002
	BEQ .middle
	CMP #$0003
	BEQ .right
.left:
	LDA inputs_OAM_positions_left,y
	BRA .write

.middle:
	LDA inputs_OAM_positions_middle,y
	BRA .write

.right:
	LDA inputs_OAM_positions_right,y
.write:
	STA OAM_relative[0].position,x
	INX
	INX
	INX
	INX
	INY
	INY
	CPY #$0014
	BCC .write_positions
	LDY #$0000
	LDX next_OAM_slot
.write_properties:
	LDA next_OAM_slot
	CLC
	ADC #$0004
	STA next_OAM_slot
 	LDA inputs_OAM_properties,y
	PHA
	PHX
	TYX
	LDA player_active_held_mirror
	JSR (handle_inputs,x)
	PLX
	PLA
	BCC +
	EOR #$0400
+:
	STA OAM_relative[0].display,x
	INX
	INX
	INX
	INX
	INY
	INY
	CPY #$0014
	BCC .write_properties
	PLB
.return:
	RTS


check_underwater:
	LDX active_kong_sprite
	LDA water_y_position
	BMI .no_water
	SEC
	SBC sprite.y_position,x
	CMP #$FFEC
	BMI .in_water
	CMP #$FFF8
	BPL .no_water
	LDA #$0001
	RTS

.no_water:
	LDA.w #$0000
	RTS

.in_water:
	LDA.w #$0002
	RTS


handle_inputs:
	dw .up
	dw .down
	dw .left
	dw .right
	dw .a
	dw .b
	dw .x
	dw .y
	dw .l
	dw .r


.up:
	BIT #$0800
	BNE .pressed
	CLC
	RTS


.down:
	BIT #$0400
	BNE .pressed
	CLC
	RTS


.left:
	BIT #$0200
	BNE .pressed
	CLC
	RTS


.right:
	BIT #$0100
	BNE .pressed
	CLC
	RTS


.a:
	BIT #$0080
	BNE .pressed
	CLC
	RTS


.b:
	BIT #$8000
	BNE .pressed
	CLC
	RTS


.x:
	BIT #$0040
	BNE .pressed
	CLC
	RTS


.y:
	BIT #$4000
	BNE .pressed
	CLC
	RTS


.l:
	BIT #$0020
	BNE .pressed
	CLC
	RTS


.r:
	BIT #$0010
	BNE .pressed
	CLC
	RTS


.pressed:
	SEC
	RTS



inputs_to_invert:
	dw $0000
	dw !input_left
	dw !input_right
	dw $0000



inputs_OAM_positions_left:
	dw $BF15			;Up
	dw $D115			;Down
	dw $C80A			;Left
	dw $C820			;Right

	dw $C83D			;A
	dw $D135			;B
	dw $BF35			;X
	dw $C82D			;Y

	dw $B415			;L
	dw $B435			;R


inputs_OAM_positions_middle:
	dw $BF6A			;Up
	dw $D16A			;Down
	dw $C85F			;Left
	dw $C875			;Right

	dw $C892			;A
	dw $D18A			;B
	dw $BF8A			;X
	dw $C882			;Y

	dw $B46A			;L
	dw $B48A			;R


inputs_OAM_positions_right:
	dw $BFCA			;Up
	dw $D1CA			;Down
	dw $C8BF			;Left
	dw $C8D5			;Right

	dw $C8F2			;A
	dw $D1EA			;B
	dw $BFEA			;X
	dw $C8E2			;Y

	dw $B4CA			;L
	dw $B4EA			;R


inputs_OAM_properties:
	dw $35C0			;Up
	dw $B5C0			;Down
	dw $75C1			;Left
	dw $B5C1			;Right

	dw $35C3			;A
	dw $35C3			;B
	dw $35C3			;X
	dw $35C3			;Y

	dw $B5C2			;L
	dw $B5C2			;R