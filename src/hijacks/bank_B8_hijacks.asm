if !version == !us
hijack_death_song_transition		= $B8811E
hijack_bonus_victory_song_transition	= $B88399
hijack_bonus_failure_song_transition	= $B88349
hijack_toboggan_bonus_victory_song	= $B883DC
hijack_kong_state_00	 		= $B8A37E
hijack_kong_damage_interaction		= $B8934A
hijack_toboggan_damage_interaction	= $B896A1
hijack_toboggan_wall_death_interaction	= $B89286
hijack_pit_death_interaction		= $B884F8
hijack_animal_damage_interaction	= $B89667
hijack_spawn_kongs_in_level		= $B89CD8
hijack_boss_coin_song_transition	= $B8F5BC
hijack_kong_state_71			= $B8F2C1
hijack_kong_state_73			= $B8F2E8
hijack_krool_ending_song_transition	= $B8F5C9
hijack_krool_ending_start		= $B8F615
;hijack_bonus_barrel_destination_set	= $B88AF2
hijack_boss_fadeout_frame		= $B8F627
hijack_kong_state_1F			= $B8AB8D



elseif !version == !j0
hijack_death_song_transition		= $B8811E
hijack_bonus_victory_song_transition	= $B88399
hijack_bonus_failure_song_transition	= $B88349
hijack_toboggan_bonus_victory_song	= $B883DC
hijack_kong_state_00	 		= $B8A39D
hijack_kong_damage_interaction		= $B89356
hijack_toboggan_damage_interaction	= $B896BD
hijack_toboggan_wall_death_interaction	= $B89292
hijack_pit_death_interaction		= $B884F8
hijack_animal_damage_interaction	= $B89683
hijack_spawn_kongs_in_level		= $B89CF7
hijack_boss_coin_song_transition	= $B8F62F
hijack_kong_state_71			= $B8F314
hijack_kong_state_73			= $B8F33E
hijack_krool_ending_song_transition	= $B8F63C
hijack_krool_ending_start		= $B8F688
;hijack_bonus_barrel_destination_set	= $B88AF9
hijack_boss_fadeout_frame		= $B8F69A
hijack_kong_state_1F			= $B8ABAC



elseif !version == !j1
hijack_death_song_transition		= $B8811E
hijack_bonus_victory_song_transition	= $B88399
hijack_bonus_failure_song_transition	= $B88349
hijack_toboggan_bonus_victory_song	= $B883DC
hijack_kong_state_00	 		= $B8A3BE
hijack_kong_damage_interaction		= $B89356
hijack_toboggan_damage_interaction	= $B896C5
hijack_toboggan_wall_death_interaction	= $B89292
hijack_pit_death_interaction		= $B884F8
hijack_animal_damage_interaction	= $B89683
hijack_spawn_kongs_in_level		= $B89D18
hijack_boss_coin_song_transition	= $B8F68B
hijack_kong_state_71			= $B8F369
hijack_kong_state_73			= $B8F393
hijack_krool_ending_song_transition	= $B8F698
hijack_krool_ending_start		= $B8F6E4
;hijack_bonus_barrel_destination_set	= $B88AF9
hijack_boss_fadeout_frame		= $B8F6F6
hijack_kong_state_1F			= $B8ABCD

endif



org hijack_death_song_transition
	NOP #7


org hijack_bonus_victory_song_transition
	JSL bonus_victory_song_transition_check


org hijack_bonus_failure_song_transition
	JSL bonus_failure_song_transition_check


org hijack_toboggan_bonus_victory_song
	JSL bonus_victory_song_transition_check


org hijack_kong_state_00
	JML fast_retry_kong_state


;Set fast retry state instead of state 0D
org hijack_kong_damage_interaction
	JSL set_fast_retry_state
	NOP
	NOP
	NOP
	RTL


org hijack_animal_damage_interaction
	JSL set_fast_retry_state_animal
	RTL


org hijack_toboggan_damage_interaction
	JSL set_fast_retry_state
	NOP
	NOP
	NOP
	RTL


;Thank god also affects the rocket rush barrel
org hijack_toboggan_wall_death_interaction
	JSL set_fast_retry_state
	NOP
	NOP
	NOP
	RTL


org hijack_pit_death_interaction
	LDX active_kong_sprite
	STZ sprite.current_graphic,x
	STZ fast_retry_type
	JSL set_fast_retry_state_short
	RTL


org hijack_spawn_kongs_in_level
	JSL entrance_setup_preserve_player_status


org hijack_boss_coin_song_transition
	;JSL check_if_beaten_best_time
	NOP
	NOP
	NOP
	NOP



;For Belcha and Arich
org hijack_kong_state_73
	JSL set_fast_retry_on_boss_fadeout



;For Squirt, Kaos and Barbos and K.Rool 2
org hijack_kong_state_71
	JSL set_fast_retry_on_boss_fadeout_2



org hijack_krool_ending_start
	LDA #$0083
	STA screen_fade_speed
	NOP
	NOP
	NOP
	LDA #$0006


org hijack_krool_ending_song_transition
	JSL check_if_beaten_best_time



; ;Clear flag so bonus will know we entered it from the level and not from the menu
; org hijack_bonus_barrel_destination_set
; 	JSL clear_entered_bonus_flag
; 	NOP


org hijack_boss_fadeout_frame
	JSL boss_check_if_beaten_best_time


org hijack_kong_state_1F
	JSL set_fast_retry_on_bonus_damage