if !version == !us
hijack_boss_continue_flag_Set		= $BB9B15
hijack_song_play_on_level_init		= $BBA20C
hijack_krackshot_bonus_win_song		= $BBD883
hijack_krackshot_bonus_fail_song	= $BBD892
hijack_flagpole_song_transition		= $BBC8CA
hijack_flagpole_fade_setup		= $BBC963
hijack_bonus_coin_set_collected		= $BBD54A
hijack_hud_draw_routine			= $BBB285
hijack_hud_something			= $BBADE9
hijack_banana_hud_draw			= $BBADF8
hijack_lives_icon_y_pos_set		= $BBB1A5
hijack_lives_hud_number_draw		= $BBB245
hijack_bonus_song_tempo_speedup		= $BBD8FE
hijack_bonus_song_tempo_speedup_2	= $BBD90D



elseif !version == !j0
hijack_boss_continue_flag_Set		= $BB9B15
hijack_song_play_on_level_init		= $BBA20C
hijack_krackshot_bonus_win_song		= $BBD887
hijack_krackshot_bonus_fail_song	= $BBD896
hijack_flagpole_song_transition		= $BBC8CA
hijack_flagpole_fade_setup		= $BBC963
hijack_level_exit_routine		= $BBA222
hijack_bonus_coin_set_collected		= $BBD54E
hijack_hud_draw_routine			= $BBB297
hijack_hud_something			= $BBADFB
hijack_banana_hud_draw			= $BBAE0A
hijack_lives_icon_y_pos_set		= $BBB1B7
hijack_lives_hud_number_draw		= $BBB257
hijack_bonus_song_tempo_speedup		= $BBD902
hijack_bonus_song_tempo_speedup_2	= $BBD911



elseif !version == !j1
hijack_boss_continue_flag_Set		= $BB9B15
hijack_song_play_on_level_init		= $BBA20C
hijack_krackshot_bonus_win_song		= $BBD887
hijack_krackshot_bonus_fail_song	= $BBD896
hijack_flagpole_song_transition		= $BBC8CA
hijack_flagpole_fade_setup		= $BBC963
hijack_level_exit_routine		= $BBA222
hijack_bonus_coin_set_collected		= $BBD54E
hijack_hud_draw_routine			= $BBB297
hijack_hud_something			= $BBADFB
hijack_banana_hud_draw			= $BBAE0A
hijack_lives_icon_y_pos_set		= $BBB1B7
hijack_lives_hud_number_draw		= $BBB257
hijack_bonus_song_tempo_speedup		= $BBD902
hijack_bonus_song_tempo_speedup_2	= $BBD911


endif





org hijack_boss_continue_flag_Set
	NOP
	NOP
	NOP


org hijack_song_play_on_level_init
	JSL check_if_should_reset_song



org hijack_flagpole_song_transition
	JSL check_if_beaten_best_time


org hijack_krackshot_bonus_fail_song
	JSL bonus_failure_song_transition_check


org hijack_krackshot_bonus_win_song
	JSL bonus_victory_song_transition_check


org hijack_flagpole_fade_setup
	JSL set_fast_retry_from_level_end


org hijack_bonus_coin_set_collected
	NOP
	NOP
	NOP



;Modified to handle single 8x8's instead + different VRAM address
org hijack_hud_draw_routine
	LDY next_OAM_slot
	CLC
	;ADC #$01CC
	ADC #$01D0
	ORA temp_3E
	STA $0002,y
	;ADC #$000A
	;STA $0006,y
	TXA
	ORA temp_1A
	STA $0000,y
	; CLC
	; ADC #$0800
	; STA $0004,y
	TYA
	CLC
	;ADC #$0008
	ADC #$0004
	STA next_OAM_slot
	TXA
	CLC
	ADC #$0008
	TAX
	RTS



;lol
org hijack_hud_something
	JSL update_timer_hud


org hijack_banana_hud_draw
	NOP
	NOP
	NOP


org hijack_lives_icon_y_pos_set
	LDA #$FF00


org hijack_lives_hud_number_draw
	RTS



org hijack_bonus_song_tempo_speedup
	NOP #7


org hijack_bonus_song_tempo_speedup_2
	NOP #7



if !version != !us
org hijack_level_exit_routine
	JSL set_fast_retry_on_bleak_death
endif