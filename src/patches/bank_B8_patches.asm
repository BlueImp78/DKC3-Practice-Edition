bonus_victory_song_transition_check:
	LDA main_menu.chosen_level_mirror
	CMP level_number
	BNE .transition
	RTL

.transition:
	LDA #$0003
	JSL transition_song
	RTL


bonus_failure_song_transition_check:
	LDA main_menu.entered_bonus
	BNE .return
	LDA #$0002
	JSL transition_song			;Hijacked instruction
.return:
	RTL



entrance_setup_preserve_player_status:
	LDX alternate_sprite			;Hijacked instruction
	STX current_sprite			;Hijacked instruction
	JSL preserve_previous_player_status
	LDA main_menu.entered_world_map
	BEQ .not_on_map
	JSL preserve_map_player_status
.not_on_map:
	LDA main_menu.entered_bonus
	BEQ .return
	JSL restore_menu_player_status		;If we entered a bonus from menu, don't preserve current status, restore menu's instead

;Also invoke the life icon here cuz convenient spot (input display won't be in vram in bonuses otherwise)
	LDA #$0001
if !version == !us
	STA $18D5
else
	STA $195B
endif
.return:
	RTL


set_fast_retry_on_boss_fadeout:
if !version == !us
	JSL process_terrain			;Hijacked instruction
else
	JSL process_anim_preserve_state		;Hijacked instruction
endif
	LDA screen_brightness
	BNE .return
	LDA main_menu.entered_world_map
	BNE .check_krool
.restart:
	LDA #$0001
	STA fast_retry_type
	JML fast_retry_kong_state_init_level

.return:
	RTL

.check_krool:
	LDA level_number
	CMP #!level_kastle_kaos
	BEQ .restart
	RTL


set_fast_retry_on_boss_fadeout_2:
	JSL process_anim_preserve_state		;Hijacked instruction
	LDA main_menu.entered_world_map
	BNE .return
	LDA screen_brightness
	BNE .return
	LDA #$0001
	STA fast_retry_type
	JML fast_retry_kong_state_init_level

.return:
	RTL



if !version != !us
set_fast_retry_on_bleak_death:
	LDA $05BD				;Hijacked instruction
	XBA					;Hijacked instruction
	PHA
	LDA level_number
	CMP #!level_bleaks_house
	BNE .return
	PLA
	PLA : PLB				;Pop JSL
	LDA #$0001
	STA fast_retry_type
	JML fast_retry_kong_state_init_level


.return:
	PLA
	RTL
endif



; clear_entered_bonus_flag:
; 	LDA sprite.general_purpose_4C,x		;Hijacked instruction
; 	STA.w sprite.general_purpose_62,y	;Hijacked instruction
; 	STZ main_menu.entered_bonus
; 	RTL



boss_check_if_beaten_best_time:
	JSL $B8837A				;Hijacked instruction
	JSL check_if_beaten_best_time
	RTL


set_fast_retry_on_bonus_damage:
	LDA main_menu.entered_bonus
	BEQ .return
	LDA #$0083
	STA screen_fade_speed
	LDA #$0002
	STA fast_retry_type
	LDX active_kong_sprite
	STZ sprite.state,x
	JML [$04F5]

.return:
	JSL $B8837A				;Hijacked instruction
	RTL