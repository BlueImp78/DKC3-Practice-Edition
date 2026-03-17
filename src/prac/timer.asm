update_timer_in_bonus_screen:
	INC active_frame_counter			;Hijacked instruction
	INC $F4						;Hijacked instruction
	BRA update_timer

update_timer_in_level:
	INC active_frame_counter			;Hijacked instruction
	INC $C2						;Hijacked instruction
	JSL handle_savestates				;Check for savestate here cuz convenient spot
update_timer:
	LDA global_frame_counter
	SEC
	SBC timer.previous_frame
	STA timer.real_frames
	DEC
	SED
	CLC
	ADC timer.lag_frames
; if !version != !us
; 	LDX level_number
; 	CPX #!level_bleaks_house
; 	BEQ .skip_lag

; endif
	STA timer.lag_frames
.skip_lag:
	LDA global_frame_counter
	STA timer.previous_frame

	SEP #$28
	; LDA timer.started
	; BEQ .return
	LDA timer.stopped
	BNE .return

	BIT game_state_flags
	BVS .return

	LDA timer.frames
	CLC
	ADC timer.real_frames
	STA timer.frames
	CMP #$60
	BCC .return

	SBC #$60
	STA timer.frames
	TDC
	ADC timer.seconds
	STA timer.seconds
	CMP #$60
	BCC .return

	SBC #$60
	STA timer.seconds
	TDC
	ADC timer.minutes
	STA timer.minutes
	CMP #$10
	BCC .no_cap
	LDA #$59
	STA timer.frames
	LDA #$59
	STA timer.seconds
	LDA #$09
.no_cap:
	STA timer.minutes
.return:
	REP #$28
	RTL



update_timer_hud:
	STA $40						;Hijacked instruction
	SEP #$20
	LDA timer.stopped
	BNE .skip_update
.update:
	LDA timer.frames
	STA timer_hud.frames
	LDA timer.seconds
	STA timer_hud.seconds
	LDA timer.minutes
	STA timer_hud.minutes

.skip_update:
	REP #$20
	LDA settings.show_timer
	CMP #$0002
	BEQ .check_top_left_disp
	JSR draw_timer_hud
.check_top_left_disp:
	LDA settings.input_display
	BEQ .skip_input_display
	JSR handle_input_display			;Also draw input display here cuz convenient spot
.skip_input_display:
	LDA settings.top_left_display
	BEQ .skip_top_left_display
	JSR draw_top_left_info
.skip_top_left_display:
if !version != !us
	LDA level_number
	CMP #!level_bleaks_house
	BEQ .check_bleak_skip
else
	LDA main_menu.selected_world
	XBA
	ORA main_menu.selected_level
	CMP #$090C
	BNE .skip_boomer_disp
	LDA main_menu.selected_entrance
	CMP #$0002
	BNE .skip_boomer_disp
	JSR get_boomer_skip_result
.skip_boomer_disp:
endif

.return:
	LDA $B6						;Hijacked instruction
	RTL

if !version != !us
.check_bleak_skip:
	JSR get_bleak_skip_result
	BRA .return
endif


draw_timer_hud:
	CMP #$0001
	BEQ .partial_check
.continue:
	LDX #$0900
	LDY #$3000
	%conditional_ram_word(LDA, $05E3)
	AND #$00FF
	CMP #$000A
	BNE .store_properties_default_x_pos		;Use palette slot 0 if not in a bear house
	LDX #$1A00
	LDY #$3600
	LDA #$00BA
	BRA .store_properties

.store_properties_default_x_pos:
	LDA #$00BC
.store_properties:
	STX temp_1A
	STY temp_3E
	TAX
	LDA timer_hud.minutes
	JSR draw_hud_graphic				;Draw digit

	LDY next_OAM_slot
	LDA #$01CE
	JSR draw_hud_graphic_no_offset			;Draw colon


	LDA timer_hud.seconds
	LSR
	LSR
	LSR
	LSR
	JSR draw_hud_graphic				;Draw digit


	LDA timer_hud.seconds
	AND #$000F
	JSR draw_hud_graphic				;Draw digit

	LDY next_OAM_slot
	LDA #$01CF
	JSR draw_hud_graphic_no_offset			;Draw period


	LDA timer_hud.frames
	LSR
	LSR
	LSR
	LSR
	JSR draw_hud_graphic                   		;Draw digit


	LDA timer_hud.frames
	AND #$000F
	JSR draw_hud_graphic                   		;Draw digit


.return:
	RTS


.partial_check:
	LDA game_state_flags
	BIT #$0040
	BNE .continue
	LDA screen_brightness
	CMP #$000F
	BNE .continue
	LDA timer.stopped
	BNE .continue
	RTS


draw_top_left_info_wrapper:
	JSR draw_top_left_info
	RTL

draw_top_left_info:
	LDX #$0900
	LDY #$3000
	%conditional_ram_word(LDA, $05E3)
	AND #$00FF
	CMP #$000A
	BNE .store_properties_default_x_pos		;Use palette slot 0 if not in a bear house
	LDX #$1A00
	LDY #$3600
	LDA #$0010
	BRA .store_properties

.store_properties_default_x_pos:
	LDA #$0008
.store_properties:
	STX temp_1A
	STY temp_3E
	TAX
	LDA settings.top_left_display
	CMP #$0002
	BEQ .draw_rng
	LDA timer.lag_frames
	CMP #$0999
	BCC .no_cap
	LDA #$0009
	JSR draw_hud_graphic				;Draw digit
	LDA #$0009
	JSR draw_hud_graphic				;Draw digit
	LDA #$0009
	BRA .last


.no_cap:
	XBA
	AND #$00FF
	JSR draw_hud_graphic				;Draw digit


	LDA timer.lag_frames
	LSR
	LSR
	LSR
	LSR
	AND #$000F
	JSR draw_hud_graphic				;Draw digit


	LDA timer.lag_frames
	AND #$000F
.last:
	JSR draw_hud_graphic				;Draw digit
.done:
	RTS



.draw_rng:
;RNG Result
	LDA rng_result+$1
	LSR
	LSR
	LSR
	LSR
	AND #$000F
	JSR draw_hud_graphic
	LDA rng_result+$1
	AND #$000F
	JSR draw_hud_graphic

	LDA rng_result
	LSR
	LSR
	LSR
	LSR
	AND #$000F
	JSR draw_hud_graphic
	LDA rng_result
	AND #$000F
	JSR draw_hud_graphic


;RNG Seed
	LDX #$0008
	LDY #$1200
	%conditional_ram_word(LDA, $05E3)
	AND #$00FF
	CMP #$000A
	BNE ..store_y_pos
	LDX #$0010
	LDY #$2300
..store_y_pos:
	STY temp_1A
	LDA rng_seed+$1
	LSR
	LSR
	LSR
	LSR
	AND #$000F
	JSR draw_hud_graphic
	LDA rng_seed+$1
	AND #$000F
	JSR draw_hud_graphic

	LDA rng_seed
	LSR
	LSR
	LSR
	LSR
	AND #$000F
	JSR draw_hud_graphic
	LDA rng_seed
	AND #$000F
	JSR draw_hud_graphic
	RTS



clear_timer_ram:
	STZ timer.stopped
	STZ timer.frames
	STZ timer.seconds
	STZ timer.minutes
	STZ timer.lag_frames
	STZ timer.real_frames
	STZ timer.frames_mirror
	STZ timer.seconds_mirror
	STZ timer.minutes_mirror
	STZ timer_hud.frames
	STZ timer_hud.seconds
	STZ timer_hud.minutes
	STZ timer.bleak_or_boomer_frame
	LDA global_frame_counter
	STA timer.previous_frame
	RTL


preserve_timer_values:
	LDA timer.frames
        STA timer.frames_mirror
        LDA timer.seconds
        STA timer.seconds_mirror
        LDA timer.minutes
        STA timer.minutes_mirror
	RTS


restore_timer_values:
	SEP #$28
        LDA timer.frames_mirror
	DEC						;Bandaid fix
        STA timer.frames
        LDA timer.seconds_mirror
        STA timer.seconds
        LDA timer.minutes_mirror
        STA timer.minutes
	LDA timer.frames
	STA timer_hud.frames
	LDA timer.seconds
	STA timer_hud.seconds
	LDA timer.minutes
	STA timer_hud.minutes
	LDA global_frame_counter
	STA timer.previous_frame
	REP #$28
	RTS


if !version == !us
get_boomer_skip_result:
	LDA timer.bleak_or_boomer_frame
	BMI .return
	BNE .draw_result
	LDA player_inputs_copy.p1_pressed
	BIT #!input_B
	BEQ .return
	LDA active_frame_counter
	CMP #$0073
	BCC .early
	BEQ .perfect
	CMP #$0074
	BCS .late
.return:
	RTS

.early:
	LDA #$3600
	STA timer.bleak_or_boomer_frame_oam
	LDA #$0073
	SEC
	SBC active_frame_counter
	BRA .check_cap

.perfect:
	LDA #$FFFF
	STA timer.bleak_or_boomer_frame
	BRA .return

.late:
	LDA #$3200
	STA timer.bleak_or_boomer_frame_oam
	LDA active_frame_counter
	SEC
	SBC #$0073
.check_cap:
	CMP #$0064
	BCC ..no_cap
	LDA #$0099
	STA timer.bleak_or_boomer_frame
	BRA .return

..no_cap:
	SEP #$20
	JSL hex_to_decimal
	STA timer.bleak_or_boomer_frame
	REP #$20
	BRA .return




.draw_result:
	LDA timer.bleak_or_boomer_frame_oam
	STA temp_3E
	LDA #$A800
	STA temp_1A
	LDY next_OAM_slot


;First digit
	LDX #$005A
	LDA timer.bleak_or_boomer_frame
	AND #$00FF
	LSR
	LSR
	LSR
	LSR
	REP #$20
	JSR draw_hud_graphic


;Second digit
	LDX #$0063
	SEP #$20
	LDA timer.bleak_or_boomer_frame
	AND #$0F
	REP #$20
	JSR draw_hud_graphic
	RTS
endif










if !version != !us
get_bleak_skip_result:
	LDX $1C41					;Get index of kong sprite
	LDA sprite.state,x
	CMP #$0009					;Check if kong is dead
	BNE .return
	JSL copy_player_inputs
	LDA timer.bleak_or_boomer_frame
	BMI .return
	BNE .draw_result
	LDA player_inputs_copy.p1_pressed
	BIT #!input_start
	BEQ .return
	LDA active_frame_counter
	CMP #$0069
	BCC .early
	BEQ .perfect
	CMP #$006A
	BCS .late
.return:
	RTS

.early:
	LDA #$3000
	STA timer.bleak_or_boomer_frame_oam
	LDA #$0069
	SEC
	SBC active_frame_counter
	BRA .check_cap

.perfect:
	LDA #$FFFF
	STA timer.bleak_or_boomer_frame
	BRA .return

.late:
	LDA #$3800
	STA timer.bleak_or_boomer_frame_oam
	LDA active_frame_counter
	SEC
	SBC #$0069
.check_cap:
	CMP #$0064
	BCC ..no_cap
	LDA #$0099
	STA timer.bleak_or_boomer_frame
	BRA .return

..no_cap:
	SEP #$20
	JSL hex_to_decimal
	STA timer.bleak_or_boomer_frame
	REP #$20
	BRA .return


.draw_result:
	LDA timer.bleak_or_boomer_frame_oam
	STA temp_3E
	LDA #$0900
	STA temp_1A


;First digit
	LDX #$0070
	LDA timer.bleak_or_boomer_frame
	AND #$00FF
	LSR
	LSR
	LSR
	LSR
	REP #$20
	JSR draw_hud_graphic


;Second digit
	LDX #$0070+$9
	SEP #$20
	LDA timer.bleak_or_boomer_frame
	AND #$0F
	REP #$20
	JSR draw_hud_graphic
	RTS

endif