arrow_OAM_positions:
	dw $2F0D
	dw $3F0D
	dw $4F0D
	dw $5F0D
	dw $6F0D
	dw $7F0D
	dw $8F0D
	dw $9F0D
	dw $CE60

options_selection_text_pos:
	dw $1506
	dw $1508
	dw $150A
	dw $150C
	dw $150E
	dw $1510
	dw $1512
	dw $1514
	dw $1516


arrow_x_offsets:
	db $00
	db $08
	db $10
	db $18
	db $2A
	db $32
	db $3A
	db $42


settings_selection_text_table:
	dw game_mode_text 			;00 - Game Mode
	dw show_timer_text			;01 - Show Timer
	dw top_left_display_text		;02 - Top Left Display
	dw input_display_text			;03 - Input Display
	dw on_off_text				;04 - Mute BGM
	dw save_slots_text 			;05 - Records Slot
	dw player_start_text			;06 - Player Start
	dw rng_text				;07 - Keep RNG
	dw rng_seed_dummy			;08 - RNG Seed



game_mode_text:
	dw $0002
	dw .single
	dw .coop

.single:
	db "Single", $FF

.coop:
	db "Co-Op", $FF



show_timer_text:
	dw $0003
	dw .always
	dw .partial
	dw .off

.always:
	db "Always", $FF

.partial:
	db "Partial", $FF

.off:
	db "OFF", $FF



top_left_display_text:
	dw $0003
	dw input_display_text_off
	dw .lag_counter
	dw .rng_seed


.lag_counter:
	db "Lag", $FF

.rng_seed:
	db "RNG", $FF



rng_text:

	dw $0002
	dw .random
	dw .custom

.random:
	db "Random", $FF

.custom:
	db "Custom", $FF



input_display_text:
	dw $0004
	dw .off
	dw .left
	dw .middle
	dw .right


.off:
	db "OFF", $FF

.left:
	db "Left", $FF

.middle:
	db "Middle", $FF

.right:
	db "Right", $FF




on_off_text:
	dw $0002
	dw .off
	dw .on

.off:
	db "OFF", $FF

.on:
	db "ON", $FF



save_slots_text:
	dw $0005
	dw .slot_1
	dw .slot_2
	dw .slot_3
	dw .slot_4
	dw .slot_5

.slot_1:
	db "Slot 1", $FF

.slot_2:
	db "Slot 2", $FF

.slot_3:
	db "Slot 3", $FF

.slot_4:
	db "Slot 4", $FF

.slot_5:
	db "Slot 5", $FF



player_start_text:
	dw $0006
	dw .auto
	dw .kongs
	dw .ellie
	dw .enguarde
	dw .squawks
	dw .squitter

.auto:
	db "Auto", $FF

.kongs:
	db "Kong", $FF


.ellie:
	db "Ellie", $FF


.enguarde:
	db "Enguarde", $FF


.squawks:
	db "Squawks", $FF


.squitter:
	db "Squitter", $FF


rng_seed_dummy:
	dw $0000