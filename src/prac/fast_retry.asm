
set_fast_retry_state:
	STZ fast_retry_type
	LDA #$0EA1
	LDY #$0015
	%conditional_ram_word(CPX, #dixie_sprite_slot)
	BEQ .set_graphic
	LDA #$16C1
	LDY #$0016
.set_graphic:
	STA sprite.current_graphic,x
	TYA
	JSL queue_sound_effect_BF
set_fast_retry_state_short:
	LDX active_kong_sprite
	LDA level_number
	CMP #!level_bleaks_house
	BNE .normal_kong
if !version == !us
	LDX $1BB9
else
	LDX $1C41
endif
	LDA #$0005
	STA sprite.state,x
	BRA .set_fade

.normal_kong:
	STZ sprite.state,x
	LDA #$0017				;Stop non-kong sprites, camera and follower kong
	LDY #$00F0
	JSL enable_timestop
.set_fade:
	LDA #$0083
	STA screen_fade_speed
	INC timer.stopped
	RTL



set_fast_retry_state_animal:
	PHK
	PLB
	LDA current_animal_type
	SEC
	SBC #!animal_sprite_type_range_start
	TAX
	LDA .sound_and_graphic_ids,x
	TAY
	LDA .sound_and_graphic_ids+2,x
	STZ fast_retry_type
	LDX active_kong_sprite
	BRA set_fast_retry_state_set_graphic

.sound_and_graphic_ids:
	dw $000C : dw $1D0B			;Ellie
	dw $000D : dw $1E73			;Enguarde
	dw $0012 : dw $1F04			;Squawks
	dw $0010 : dw $1F8B			;Squitter


set_fast_retry_from_level_end:
	LDA main_menu.entered_world_map
	BEQ .fast_retry
	JSL $B8807E
	RTL

.fast_retry:
	LDA #$0001
	STA fast_retry_type
	JMP set_fast_retry_state_short




fast_retry_kong_state:
	LDA screen_brightness
	BEQ .init_level
	JML [$04F5]

.init_level:
	LDA fast_retry_type
	ASL
	STZ fast_retry_type
	TAX
	JSR (fast_retry_setup,x)
	STZ timer.lag_frames
	STZ timer.stopped
	%conditional_ram_word(STZ, $05C1)		;Stop game from sometimes overriding animal type
	%conditional_ram_word(STZ, $0605)		;Clear inventory square slots that have been assigned
	%conditional_ram_word(STZ, inventory_flags)
	LDA level_number
	JML init_level


fast_retry_setup:
	dw .normal
	dw .pressed_L
	dw .pressed_R

;Copy of pressed_R but keep here just in case it needs to do more in the future
.normal:
	JSL restore_previous_player_status
	RTS

.pressed_L:
	JSL restore_menu_player_status
	RTS


.pressed_R:
	JSL restore_previous_player_status
	RTS







check_fast_retry_LR_input:
	STA $C2				;Hijacked instruction
	LDA player_active_pressed
	BIT #!input_L
	BNE .set_type_1
	BIT #!input_R
	BNE .set_type_2
	LDA $C4				;Hijacked instruction
	RTL

.set_type_1:
	LDA #$0001
	BRA .done

.set_type_2:
	LDA #$0002
.done:
	STA fast_retry_type
	LDA #$0040
	%conditional_ram_word(TRB, game_state_flags)
	LDX active_kong_sprite
	JMP set_fast_retry_state_short



check_if_should_reset_song:
	PHA
	XBA
	AND #$00FF
	CMP current_song
	BNE .play_song
	PLA
	RTL

.play_song:
	PLA
	JSL play_song_with_transition
	RTL








preserve_menu_player_status:
	%conditional_ram_word(LDA, game_state_flags)
	STA menu_player_status.game_state_flags
	STA previous_player_status.game_state_flags

	LDA active_kong_sprite
	STA menu_player_status.active_kong_sprite
	STA previous_player_status.active_kong_sprite

	%conditional_ram_word(LDA, current_kong)
	STA menu_player_status.current_kong
	STA previous_player_status.current_kong

	%conditional_ram_word(LDA, kong_letter_flags)
	STA menu_player_status.kong_letter_flags
	STA previous_player_status.kong_letter_flags

	LDA current_animal_type
	STA menu_player_status.current_animal_type
	STA previous_player_status.current_animal_type

	LDA current_mount
	STA menu_player_status.current_mount
	STA previous_player_status.current_mount

	LDA main_menu.chosen_entrance
	STA previous_player_status.current_entrance
	%conditional_ram_word(STA, current_entrance)

	LDA main_menu.chosen_level_mirror
	STA previous_player_status.current_level

	LDA settings.rng
	BEQ .done
	LDA rng_result
	STA menu_player_status.rng_seed_1
	LDA rng_seed
	STA menu_player_status.rng_seed_2
.done:
	RTL


restore_menu_player_status:
	LDA menu_player_status.game_state_flags
	%conditional_ram_word(STA, game_state_flags)

	LDA menu_player_status.active_kong_sprite
	STA active_kong_sprite

	LDA menu_player_status.current_kong
	%conditional_ram_word(STA, current_kong)

	LDA menu_player_status.kong_letter_flags
	%conditional_ram_word(STA, kong_letter_flags)

	LDA menu_player_status.current_animal_type
	STA current_animal_type

	LDA menu_player_status.current_mount
	STA current_mount

	LDA main_menu.chosen_entrance
	%conditional_ram_word(STA, current_entrance)


	LDA main_menu.chosen_level_mirror
	STA level_number

	STZ parry_index

	LDA settings.rng
	BEQ .done
	LDA menu_player_status.rng_seed_1
	STA rng_result
	LDA menu_player_status.rng_seed_2
	STA rng_seed
.done:
	JSL clear_timer_ram
	RTL


preserve_previous_player_status:
	%conditional_ram_word(LDA, game_state_flags)
	STA previous_player_status.game_state_flags

	LDA active_kong_sprite
	STA previous_player_status.active_kong_sprite

	%conditional_ram_word(LDA, current_kong)
	STA previous_player_status.current_kong

	%conditional_ram_word(LDA, kong_letter_flags)
	STA previous_player_status.kong_letter_flags

	LDA current_animal_type
	STA previous_player_status.current_animal_type

	LDA current_mount
	STA previous_player_status.current_mount

	LDA level_number
	STA previous_player_status.current_level

	%conditional_ram_word(LDA, current_entrance)
	STA previous_player_status.current_entrance

	JSR preserve_timer_values
	RTL


restore_previous_player_status:
	LDA previous_player_status.game_state_flags
	%conditional_ram_word(STA, game_state_flags)

	LDA previous_player_status.active_kong_sprite
	STA active_kong_sprite

	LDA previous_player_status.current_kong
	%conditional_ram_word(STA, current_kong)

	LDA previous_player_status.kong_letter_flags
	%conditional_ram_word(STA, kong_letter_flags)

	LDA previous_player_status.current_animal_type
	STA current_animal_type

	LDA previous_player_status.current_mount
	STA current_mount

	LDA previous_player_status.current_level
	STA level_number

	LDA previous_player_status.current_entrance
	%conditional_ram_word(STA, current_entrance)

	STZ parry_index

	JSR restore_timer_values
	RTL


preserve_map_player_status:
	%conditional_ram_word(LDA, game_state_flags)
	STA menu_player_status.game_state_flags

	LDA active_kong_sprite
	STA menu_player_status.active_kong_sprite


	%conditional_ram_word(LDA, current_kong)
	STA menu_player_status.current_kong


	%conditional_ram_word(LDA, kong_letter_flags)
	STA menu_player_status.kong_letter_flags

	LDA current_animal_type
	STA menu_player_status.current_animal_type

	LDA current_mount
	STA menu_player_status.current_mount


	%conditional_ram_word(LDA, current_entrance)
	STA main_menu.chosen_entrance


	LDA level_number
	STA main_menu.chosen_level_mirror

	STZ parry_index

	%conditional_ram_word(LDA, current_entrance)
	BNE +
	JSL clear_timer_ram
	RTL

+
	STZ timer.stopped
	RTL