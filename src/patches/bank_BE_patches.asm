checkpoint_barrel_preserve_player_status:
	LDX current_sprite			;Hijacked instruction
	STZ sprite.type,x			;Hijacked instruction
	LDA #$0001
	%conditional_ram_word(STA, current_entrance)
	JSL preserve_previous_player_status
	RTL