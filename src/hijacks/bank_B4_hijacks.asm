if !version == !us
hijack_bird_cave_crystal_spawn	= $B4AFE0
hijack_wrinkly_true_ending_save	= $B49B10
preserve_map_kong_position	= $B4B391
hijack_bear_house_input_read	= $B48DC7
hijack_map_node_enter		= $B4B305



elseif !version == !j0
hijack_bird_cave_crystal_spawn	= $B4AED7
hijack_wrinkly_true_ending_save	= $B49B04
preserve_map_kong_position	= $B4B27C
hijack_bear_house_input_read	= $B48DB6
hijack_map_node_enter		= $B4B1ED



elseif !version == !j1
hijack_bird_cave_crystal_spawn	= $B4AED7
hijack_wrinkly_true_ending_save	= $B49B04
preserve_map_kong_position	= $B4B28A
hijack_bear_house_input_read	= $B48DB6
hijack_map_node_enter		= $B4B1FB ;get address


endif




org hijack_bird_cave_crystal_spawn
	BRA $05


;Don't save game + don't trigger final cutscene
org hijack_wrinkly_true_ending_save
	NOP #10


;Don't preserve if reloading level from a fast retry reload.
org preserve_map_kong_position
	JSL map_kong_pos_preserve_check
	NOP


;Needed because bear houses can stop reading your inputs
org hijack_bear_house_input_read
	JSL handle_bear_house_inputs
	NOP
	NOP


org hijack_map_node_enter
	JSL clear_timer_ram_on_map
	NOP
	NOP