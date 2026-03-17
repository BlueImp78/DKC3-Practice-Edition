;TODO: copy banana buffer ($C000-$D55B)


savestate_vram_NMI:
	LDA savestate.copy_restore_routine
	ASL
	TAX
	JMP (copy_or_restore_routines,x)


copy_or_restore_routines:
	dw .copy_cgram_first_half
	dw .copy_cgram_second_half
	dw .restore_cgram_first_half
	dw .restore_cgram_second_half



.copy_cgram_first_half:
	SEP #$20
	STZ PPU.cgram_address
	PHB
	PEA $7F7F
	PLB
	PLB
	LDX #$0000
..loop:
	LDA.l PPU.cgram_read
	STA savestate_buffer.cgram,x
	INX
	CPX #$0110
	BMI ..loop
	PLB
	INC savestate.copy_restore_routine
	JMP .return


.copy_cgram_second_half:
	SEP #$20
	LDA #$88
	STA PPU.cgram_address
	PHB
	PEA $7F7F
	PLB
	PLB
	LDX #$0000
..loop:
	LDA.l PPU.cgram_read
	STA savestate_buffer.cgram+$0110,x
	INX
	CPX #$00F0
	BMI ..loop
	PLB
	INC savestate.copy_restore_routine
	JMP .return_vanilla_nmi


.restore_cgram_first_half:
	SEP #$20
	STZ PPU.cgram_address
	PHB
	PEA $7F7F
	PLB
	PLB
	LDX #$0000
..loop:
	LDA savestate_buffer.cgram,x
	STA.l PPU.cgram_write
	INX
	CPX #$0110
	BMI ..loop
	PLB
	INC savestate.copy_restore_routine
	JMP .return


.restore_cgram_second_half:
	SEP #$20
	LDA #$88
	STA PPU.cgram_address
	PHB
	PEA $7F7F
	PLB
	PLB
	LDX #$0000
..loop:
	LDA savestate_buffer.cgram+$0110,x
	STA.l PPU.cgram_write
	INX
	CPX #$00F0
	BMI ..loop
	PLB
.return_vanilla_nmi:
	REP #$30
if !version == !us
	LDA #$8348
else
	LDA #$8337
endif
	STA NMI_pointer
	STA $4C
.return:
	REP #$30
	PLY
	PLX
	PLA
	PLD
	RTI




handle_savestates:
	RTL

        LDA player_active_held
        BIT #!input_L
	BEQ .check_R
	LDA player_active_pressed
	BIT #!input_X
	BNE .save
	RTL

.check_R:
	BIT #!input_R
	BEQ .return
	LDA player_active_pressed
	BIT #!input_X
	BEQ .return
	JMP .load

.return
	RTL

.save:
	;LDA #$0003
	STZ savestate.copy_restore_routine
	LDA #NMI_return
	STA NMI_pointer
	STA $4C

	LDA #$0001
	STA savestate.save_exists			;Mark that we made a savestate

	SEP #$20
	LDA #$80
	STA PPU.screen
	REP #$20


;Clear player inputs (crashes if we don't)
	STZ player_active_held
	STZ player_active_pressed


;Copy stuff thats before $06
	LDA active_frame_counter
	STA.l savestate_buffer.active_frame_counter
	LDA rng_result
	STA.l savestate_buffer.rng_result
	LDA rng_seed
	STA.l savestate_buffer.rng_seed


;Copy direct page starting from $08 ($06 is audio stuff)
	PHB
        LDX #$0008
        LDY #savestate_buffer.direct_page
        LDA #$00F7
        MVN $7F, $7E


;Copy low ram
        LDX #$0200
        LDY #savestate_buffer.low_ram
        LDA #$1DFF
        MVN $7F, $7E


; ;Copy follower buffer
        LDX #follower_kong_waypoint_buffer
        LDY #savestate_buffer.follower_waypoint_buffer
        LDA #$00FF
        MVN $7F, $7E


;Copy banana tracking buffer
        LDX #level_banana_tracking_buffer
        LDY #savestate_buffer.banana_tracking_buffer
        LDA #$0215
        MVN $7F, $7E


;Copy sprite tracking buffer
        LDX #level_sprite_tracking_buffer
        LDY #savestate_buffer.sprite_tracking_buffer
        LDA #$03FF
        MVN $7F, $7E


;Copy camera buffer
        LDX #level_camera_buffer
        LDY #savestate_buffer.camera_buffer
        LDA #$07FF
        MVN $7F, $7E


.done:
	PLB
	LDA #savestate_vram_NMI
	STA NMI_pointer
	STA $4C
-
	WAI
	BRA -




.load:
	LDA savestate.save_exists			;If a savestate was not made yet, return
	BNE ..check_level
..return:
	RTL

..check_level:
	LDA $7FB0BE
	CMP level_number
	BNE ..return
	LDA #NMI_return
	STA NMI_pointer
	STA $4C


;Clear ppu regs
	SEP #$20
	LDA #$80
	STA PPU.screen
	REP #$20

	SEP #$30					;8-Bit A/X/Y
	LDX #$00
..clear_PPU:
	STZ $2101,x
	STZ $2101,x 					;Clear $2101-$2134 (Twice to handle write twice registers)
	INX
	CPX #$34
	BNE ..clear_PPU
	LDA #$80
	STA PPU.vram_control				;Increment VRAM after high byte write
	LDA #$E0
	STA PPU.fixed_color				;Set fixed color
	LDA #$30
	STA PPU.color_addition_logic
	REP #$30


;Restore stuff thats before $06
	LDA.l savestate_buffer.active_frame_counter
	STA active_frame_counter
	LDA.l savestate_buffer.rng_result
	STA rng_result
	LDA.l savestate_buffer.rng_seed
	STA rng_seed


;Restore direct page
	PHB
        LDY #$0008
        LDX #savestate_buffer.direct_page
        LDA #$00F9
        MVN $7E, $7F


;Restore low ram
        LDY #$0200
        LDX #savestate_buffer.low_ram
        LDA #$1DFF
        MVN $7E, $7F


	; LDA screen_scroll_x_position
	; STA savestate.screen_scroll_x_copy
	; LDA screen_scroll_y_position
	; STA savestate.screen_scroll_y_copy

;Set appropriate PPU registers, fix specific shit
	; LDA $0781
	; JSL VRAM_payload_handler
	; INC savestate.shit
	%conditional_ram_word(LDA, $077F)
	JSL set_PPU_registers


;Restore follower waypoint buffer
        LDY #follower_kong_waypoint_buffer
        LDX #savestate_buffer.follower_waypoint_buffer
        LDA #$00FF
        MVN $7E, $7F


;Restore banana tracking buffer
        LDY #level_banana_tracking_buffer
        LDX #savestate_buffer.banana_tracking_buffer
        LDA #$0215
        MVN $7E, $7F


;Restore sprite tracking buffer
        LDY #level_sprite_tracking_buffer
        LDX #savestate_buffer.sprite_tracking_buffer
        LDA #$03FF
        MVN $7E, $7F


;Restore camera buffer
        LDY #level_camera_buffer
        LDX #savestate_buffer.camera_buffer
        LDA #$07FF
        MVN $7E, $7F

	;LDA #$0040
	;JSL ass
	;JSL $B7F32C



	; LDA savestate.screen_scroll_x_copy
	; STA screen_scroll_x_position
	; LDA savestate.screen_scroll_y_copy
	; STA screen_scroll_y_position

	LDA #$0002
	STA savestate.copy_restore_routine
	JMP .done


; ass:
; 	PHA
; 	JSL $B7B86D
; 	LDA.w #$0004				;$B7F395
; 	STA.w $1989				;$B7F398
; 	CLC					;$B7F39B
; 	ADC.w $196D				;$B7F39C
; 	STA.w $196D				;$B7F39F
; 	PLA
; 	DEC
; 	BNE ass
; 	STZ.w $1985				;$B7F3A6
; 	STZ.w $1989				;$B7F3A9
; 	RTL