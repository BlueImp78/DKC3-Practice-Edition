start_select_always:
if !version != !us
	LDA level_number
	CMP #!level_bleaks_house
	BNE .allow
	LDX $1C41					;Get index of kong sprite
	LDA sprite.state,x
	CMP #$0009					;Check if kong is dead
	BNE .allow
.return:
	RTL

.allow:
endif
	PLA : PLB					;Pop JSL
	LDA #$0001
	%conditional_ram_word(STA, $075C)		;Flag that we're not in a bonus so we can start+select out of them too
	JML exit_level_start_select




;Normally you can't pause when a fade speed is set. If it does happens it means we got bleak skip.
if !version != !us
check_bleak_skip:
	LDA #$0040					;Hijacked instruction
	%conditional_ram_word(TSB, game_state_flags)	;Hijacked instruction
	LDA level_number
	CMP #!level_bleaks_house
	BNE .return
	LDX $1C41					;Get index of kong sprite
	LDA sprite.state,x
	CMP #$0009					;Check if kong is dead
	BNE .return
	LDA screen_fade_speed
	AND #$00FF
	BEQ .return
	JSL check_if_beaten_best_time
.return:
	RTL


endif