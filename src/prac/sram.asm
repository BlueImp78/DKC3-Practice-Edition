save_data_to_sram:
	PHB
	PEA bank(sram)<<8			       ;Set DB to SRAM
	PLB
	PLB

;Save calculated checksum
	LDA validate_sram_additive_checksum
	STA sram.additive_checksum
	LDA validate_sram_xor_checksum
	STA sram.xor_checksum

;Save main menu stuff
	LDA main_menu.selected_color
	STA sram.selected_color
	LDA main_menu.selected_song
	STA sram.selected_song

;Save settings
	LDX #$0014 			        ;Bytes to transfer
	LDY #$0000
.loop
	LDA settings.selection_base,y
	STA sram.settings_base,y
	INY
	INY
	DEX
	DEX
	BNE .loop


;Save best times
	LDA #$0005
	STA temp_1A
	STZ temp_1C
.loop2:
	LDA #sram.best_times
	CLC
	ADC temp_1C
	TAY

        LDX #recorded_times
        LDA #$0180-1
        MVN $B0, $7E
	DEC temp_1A
	BEQ .done

	LDA temp_1C
	CLC
	ADC #$0150
	STA temp_1C
	BRA .loop2

.done:
	PLB
	RTL




load_data_from_sram:
	PHB
	PEA bank(sram)<<8			;Set DB to SRAM
	PLB
	PLB

;Load color and song
	LDA sram.selected_color
	STA main_menu.selected_color
	LDA sram.selected_song
	STA main_menu.selected_song

;Load settings
	LDY #$0014 			        ;Bytes to transfer
	LDX #$0000
.loop:
	LDA sram.settings_base,x
	STA settings.selection_base,x 		;to WRAM
	INX
	INX
	DEY
	DEY
	BNE .loop


;Load best times
	LDA settings.records_slot
	ASL
	TAX
	LDA.l records_slot_sram_offsets,x
	CLC
	ADC #sram.best_times
	TAX
        LDY #recorded_times
        LDA #$0180-1
        MVN $7E, $B0
	PLB
	RTL


validate_sram:
%local(.additive_checksum, temp_20)
%local(.xor_checksum, temp_22)
	WDM

	JSR calculate_sram_checksum

	LDA sram.additive_checksum
	CMP .additive_checksum
	BNE .invalid_file

	LDA sram.xor_checksum
	CMP .xor_checksum
	BNE .invalid_file
	CLC
	RTL

.invalid_file:
	SEC
	RTL


calculate_sram_checksum:
	PHB
	PEA bank(sram)<<8			;Set DB to SRAM
	PLB
	PLB

	STZ validate_sram_additive_checksum
	STZ validate_sram_xor_checksum

	LDY #$0004
.calculate_additive:
	LDA sram,y
	CLC
	ADC validate_sram_additive_checksum
	STA validate_sram_additive_checksum
	INY
	INY
	CPY.w #sizeof(sram)
	BNE .calculate_additive

	LDY #$0004
.calculate_xor:
	LDA sram,y
	EOR validate_sram_xor_checksum
	STA validate_sram_xor_checksum
	INY
	INY
	CPY.w #sizeof(sram)
	BNE .calculate_xor

	PLB
	RTS


calculate_and_save_checksum:
	JSR calculate_sram_checksum
	LDA validate_sram_additive_checksum
	STA.l sram.additive_checksum
	LDA validate_sram_xor_checksum
	STA.l sram.xor_checksum
	RTL



set_default_file_status:
;Main menu
	LDA #$0013
	STA main_menu.selected_song
	STZ main_menu.selected_color

;Settings
	STZ settings.game_mode
	STZ settings.show_timer
	STZ settings.top_left_display
	STZ settings.input_display
	STZ settings.mute_bgm
	STZ settings.records_slot
	STZ settings.player_start
	STZ settings.rng
	STZ settings.rng_seed_1
	STZ settings.rng_seed_2

;Mark all times as not obtained
	LDX #$0000
.loop:
	LDA #$FFFF
	;STA.l recorded_times,x
	STA recorded_times,x
	TXA
	CLC
	ADC #$0008
	TAX
	CMP #$0180
	BCC .loop
	RTL