if !version == !us
hijack_bleak_coin_song_transition	= $B6C7A3
hijack_dk_coin_grab			= $B6A753
hijack_dk_coin_collected_check		= $B6A556
hijack_koin_handler_spawn		= $B6A065



elseif !version == !j0
hijack_bleak_coin_song_transition	= $B6C7DF
hijack_dk_coin_grab			= $B6A77B
hijack_dk_coin_collected_check		= $B6A570
hijack_koin_handler_spawn		= $B6A082



elseif !version == !j1
hijack_bleak_coin_song_transition	= $B6C7DF
hijack_dk_coin_grab			= $B6A77B
hijack_dk_coin_collected_check		= $B6A570
hijack_koin_handler_spawn		= $B6A082


endif



org hijack_bleak_coin_song_transition
	;JSL check_if_beaten_best_time
	NOP
	NOP
	NOP
	NOP


;Stop DK coin from counting as collected
org hijack_dk_coin_grab
	LDA #$0000



;Needed for DK Coin to not be stuck in dummy state 0 if we kill the Koin after reloading
org hijack_dk_coin_collected_check
	NOP #5



;Don't check for standalone coin spawn and always spawn Koin enemy instead
org hijack_koin_handler_spawn
	LDA #$0000