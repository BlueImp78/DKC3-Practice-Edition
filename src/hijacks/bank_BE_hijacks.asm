if !version == !us
hijack_checkpoint_barrel_entrance_setup	= $BEDC54
hijack_checkpoint_barrel_break		= $BEDC83


elseif !version == !j0
hijack_checkpoint_barrel_entrance_setup	= $BEDC6E
hijack_checkpoint_barrel_break		= $BEDC9D


elseif !version == !j1
hijack_checkpoint_barrel_entrance_setup	= $BEDC6E
hijack_checkpoint_barrel_break		= $BEDC9D

endif



;Stop barrel from messing up fast retry
org hijack_checkpoint_barrel_entrance_setup
	NOP
	NOP
	NOP
	NOP


org hijack_checkpoint_barrel_break
	JSL checkpoint_barrel_preserve_player_status