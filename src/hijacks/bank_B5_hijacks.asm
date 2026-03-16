if !version == !us
hijack_bleak_state_0F			= $B59EAA
hijack_bleak_kong_set_hurt_state	= $B5F9E9
hijack_bleak_fight_cursor_main		= $B5A344
hijack_bleak_death_song_transition	= $B5F9CA


elseif !version == !j0
hijack_bleak_state_0F			= $B59E83
hijack_bleak_kong_set_hurt_state_J	= $B5FA03
hijack_bleak_fight_cursor_main		= $B5A32B


elseif !version == !j1
hijack_bleak_state_0F			= $B59E83
hijack_bleak_kong_set_hurt_state_J	= $B5FA03
hijack_bleak_fight_cursor_main		= $B5A32B

endif





if !version == !us
org hijack_bleak_kong_set_hurt_state
	JSL bleak_kong_hurt_set_fade
	NOP

org hijack_bleak_death_song_transition
	NOP
	NOP
	NOP
	NOP

endif



if !version != !us
org hijack_bleak_kong_set_hurt_state_J
	JSL bleak_kong_hurt_reset_frame_counter
endif





;Epic hijack target
org hijack_bleak_fight_cursor_main
	JSL set_fast_retry_on_bleak_fadeout


;Need another one cuz the cursor sprite is deleted when bleak dies
org hijack_bleak_state_0F
	JML set_fast_retry_on_bleak_fadeout_2
