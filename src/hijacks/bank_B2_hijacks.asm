if !version == !us
hijack_upload_song_data_routine		= $B282B5
hijack_npc_kong_main			= $B2BFAD
hijack_crystal_cave_kong_state_02	= $B2DD16
hijack_crystal_cave_kong_set_state_02	= $B2DCCB
hijack_crystal_cave_set_inputs		= $B2DF9A
hijack_player_krosshair_controller	= $B2F44F
hijack_map_kong_main			= $B2C08E
hijack_waterfall_water_cheat_check	= $B2C669



elseif !version == !j0
hijack_upload_song_data_routine		= $B282E8
hijack_npc_kong_main			= $B2BF07
hijack_crystal_cave_kong_state_02	= $B2DCA2
hijack_crystal_cave_kong_set_state_02	= $B2DC57
hijack_crystal_cave_set_inputs		= $B2DF26
hijack_player_krosshair_controller	= $B2F3EF
hijack_map_kong_main			= $B2BFE8
hijack_waterfall_water_cheat_check	= $B2C5F0



elseif !version == !j1
hijack_upload_song_data_routine		= $B282E8
hijack_npc_kong_main			= $B2BF11
hijack_crystal_cave_kong_state_02	= $B2DCAC
hijack_crystal_cave_kong_set_state_02	= $B2DC61
hijack_crystal_cave_set_inputs		= $B2DF38
hijack_player_krosshair_controller	= $B2F401
hijack_map_kong_main			= $B2BFF2
hijack_waterfall_water_cheat_check	= $B2C5FA


endif





org hijack_upload_song_data_routine
	JSL check_if_should_mute_song



org hijack_npc_kong_main
	JSL init_menu_on_npc_fadeout


org hijack_crystal_cave_kong_state_02
	JSL init_menu_on_cave_fadeout
	NOP
	NOP
	NOP


org hijack_crystal_cave_set_inputs
	JSL cap_banana_bird_count
	NOP
	NOP


;Don't leave cave even if already completed
org hijack_crystal_cave_kong_set_state_02
	NOP
	NOP


org hijack_player_krosshair_controller
	JSL set_fast_retry_on_KSK_B2_fadeout
	NOP
	NOP


org hijack_map_kong_main
	JSL map_kong_select_check
	NOP


org hijack_waterfall_water_cheat_check
	NOP #5