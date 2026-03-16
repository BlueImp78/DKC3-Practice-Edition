check_if_beaten_best_time:
	INC timer.stopped
	LDA main_menu.selected_entrance         ;Don't save times unless level is beaten from the start
	BNE .done
	JSR get_level_times_address
	TAX
	SEP #$20
	JSR .check_if_beaten_previous_time
	BCS .store_new_best_time
	REP #$20
.done:
	RTL


;Stores the time as a string so render text routine interprets it as such (unhinged)
.store_new_best_time:
	LDA timer_hud.minutes
	CLC
	ADC #$30
	STA $7E0000,x

;Write colon
	LDA #$3A
	STA $7E0001,x

;Write seconds (first digit)
	LDA timer_hud.seconds
	PHA
	JSR .extract_first_digit
	ADC #$30
	STA $7E0002,x

;Write seconds (second digit)
	PLA
	AND #$0F
	ADC #$30
	STA $7E0003,x

;Write dot
	LDA #$2E
	STA $7E0004,x

;Write frames (first digit)
	LDA timer_hud.frames
	PHA
	JSR .extract_first_digit
	ADC #$30
	STA $7E0005,x

;Write frames (second digit)
	PLA
	AND #$0F
	ADC #$30
	STA $7E0006,x

;Write an $FF to last byte so text renderer knows when to stop
	LDA #$FF
	STA $7E0007,x


;Save new time to SRAM
	REP #$20
	PHX
	LDA settings.records_slot
	ASL
	TAX
	LDA.l records_slot_sram_offsets,x
	STA temp_1C
	PLX

	PHB
	PEA bank(sram)<<8
	PLB
	PLB

	LDY #$0000
.loop:
	LDA $7E0000,x
	PHY
	PHA
	TXA
	SEC
	SBC #recorded_times
	CLC
	ADC temp_1C
	TAY
	PLA
	STA sram.best_times,y
	INX
	INX
	PLY
	INY
	INY
	CPY #$0008
	BNE .loop
	PLB

	JSL calculate_and_save_checksum

	LDY #$035E
	JSL spawn_sprite_from_index
	RTL



;Normally wouldn't need to load sram again but the game clears the buffer we use on level load
.check_if_beaten_previous_time:
	REP #$20
	PHX
	JSL load_data_from_sram
	PLX
	SEP #$20
	LDA $7E0000,x
	BNE ..time_exists
	LDA $7E0001,x
	BNE ..time_exists
	LDA $7E0002,x
	BNE ..time_exists
..beaten:
	SEC				        ;Save our time if we beat it, or if we didn't have one
	RTS


..time_exists:
	LDA timer_hud.minutes
	CLC
	ADC #$30
	CMP $7E0000,x
	BEQ ..check_seconds
	BCC ..beaten
	BRA ..done

..check_seconds:
	LDA $7E0003,x
	AND #$0F
	STA temp_1A			        ;Preserve second digit to add later
	LDA $7E0002,x
	AND #$0F
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC temp_1A
	CMP timer_hud.seconds
	BEQ ..check_frames
	BCS ..beaten
	BRA ..done

..check_frames:
	LDA $7E0006,x
	AND #$0F
	STA temp_1A			        ;Preserve second digit to add later
	LDA $7E0005,x
	AND #$0F
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC temp_1A
	CMP timer_hud.frames
	BEQ ..done
	BCS ..beaten
..done:
	CLC
	RTS


.extract_first_digit:
	AND #$F0
	LSR
	LSR
	LSR
	LSR
	RTS


get_level_times_address:
	LDA main_menu.entered_world_map
	BEQ .not_on_map
	%conditional_ram_word(LDA, parent_level_number)
	TAX
	LDA.l ass_table,x
	AND #$00FF
	STA temp_20
	BRA +

.not_on_map:
	LDA main_menu.selected_level
	STA temp_20
+
	BEQ .no_offset
	CMP #$0002
	BCS .mult
	LDA #$0008
	BRA .no_offset

.mult:
	SEP #$20
	LDA #$08
	STA CPU.multiply_A
	LDA temp_20
	STA CPU.multiply_B
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	REP #$20
	LDA CPU.multiply_result
.no_offset:
	STA temp_1A
	LDA main_menu.entered_world_map
	BEQ ..not_on_map
	%conditional_ram_word(LDA, current_world)
	CMP #$0003
	BEQ ++
	CMP #$0004
	BNE +
	DEC
+
	DEC
	BRA ++

..not_on_map:
	LDA main_menu.selected_world
++
	ASL
	TAX
	LDA.l records_world_adress_offsets,x	;Get base address
	CLC
	ADC temp_1A
.return:
	RTS