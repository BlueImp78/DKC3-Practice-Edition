if !version == !us
hijack_paused_level_exit 	= $B3A6AB

elseif !version == !j0
hijack_paused_level_exit 	= $B3A6B2

elseif !version == !j1
hijack_paused_level_exit 	= $B3A6B2


endif


org hijack_paused_level_exit
	JSL main_menu_init