bleak_kong_hurt_set_fade:
	LDA #$0005			;Hijacked instruction
	STA sprite.state,x		;Hijacked instruction
	LDA game_state_flags
	BIT #$4000
	BNE .return
	LDA #$0083
	STA screen_fade_speed
	LDA #$0001
	STA fast_retry_type
	INC timer.stopped
.return:
	RTL

set_fast_retry_on_bleak_fadeout:
	LDA screen_brightness
	BNE .return
	LDA fast_retry_type
	BEQ .return
	JML fast_retry_kong_state_init_level

.return:
if !version == !us
	LDA $1B6F			;Hijacked instruction
else
	LDA $1BF7			;Hijacked instruction
endif
	ASL				;Hijacked instruction
	RTL


;Fuck
set_fast_retry_on_bleak_fadeout_2:
	LDA screen_brightness
	BNE .tick_timer
	JML fast_retry_kong_state_init_level

.tick_timer:
if !version == !us
	LDA $1BCF
else
	LDA $1C57
endif
	BEQ .return
if !version == !us
	DEC $1BCF
else
	DEC $1C57
endif
	BNE .return
	LDA #$830F
	JSL set_screen_fade
	JSL check_if_beaten_best_time
.return:
	JML [$04F5]


if !version != !us
bleak_kong_hurt_reset_frame_counter:
	STZ active_frame_counter
	LDA #$0005
	STA sprite.state,x
	RTL
endif