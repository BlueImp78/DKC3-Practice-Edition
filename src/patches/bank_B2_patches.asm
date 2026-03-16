
check_if_should_mute_song:
	LDA settings.mute_bgm
	BEQ .return
	PLA : PLB					;Pop JSL
	LDA #$0000					;And load ID to empty song
if !version == !us
	JML $B282BC
else
	JML $B282EF
endif

.return:
	LDA current_song				;Hijacked instruction
	ASL						;Hijacked instruction
	ASL						;Hijacked instruction
	RTL


;fuck
set_fast_retry_on_KSK_B2_fadeout:
	LDA screen_brightness
	BNE .return
	LDA fast_retry_type
	BEQ .return
	JML fast_retry_kong_state_init_level

.return:
	LDA #$0001					;Hijacked instruction
	BIT game_state_flags				;Hijacked instruction
	RTL



init_menu_on_npc_fadeout:
	LDA screen_brightness
	CMP #$8201
	BNE .return
	LDA main_menu.selected_world
	CMP #$0009
	BNE .return
	JML main_menu_init

.return:
	JSL process_current_movement			;Hijacked instruction
	RTL



init_menu_on_cave_fadeout:
	LDA screen_brightness
	CMP #$8201
	BNE .return
	LDA main_menu.selected_world
	CMP #$000A
	BNE .return
	JML main_menu_init

.return:
	LDA #$0012					;Hijacked instruction
	JSL process_alternate_movement			;Hijacked instruction
	RTL



map_kong_select_check:
	LDA #$007E					;Hijacked instruction
	STA $6C						;Hijacked instruction
	LDA main_menu.fade_started
	BEQ +
	LDA screen_brightness
	CMP #$8201
	BNE .return
	STZ main_menu.fade_started
	JML main_menu_init

+
	LDA player_active_pressed
	BIT #!input_select
	BEQ .return
	INC main_menu.fade_started
	STZ main_menu.entered_world_map
	LDA #$820F
	JSL set_screen_fade
.return:
	RTL


cap_banana_bird_count:
	%conditional_ram_word(LDX, banana_bird_count)	;Hijacked instruction
	CPX #$000F
	BCC .no_cap
	LDX #$000E
	%conditional_ram_word(STX, banana_bird_count)
.no_cap:
if !version == !us
	LDA $1C5F					;Hijacked instruction
else
	LDA $1CE7					;Hijacked instruction
endif
	RTL