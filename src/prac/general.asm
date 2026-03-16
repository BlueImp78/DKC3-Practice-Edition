read_controller:
	SEP #$20				; \
	LDA #$01				;  |
.wait:						;  |
	BIT CPU.ppu_status			;  |
	BNE .wait				;  |
	REP #$20				;  |
	LDA CPU.port_0_data_1			;  |
	TAX					;  |
	EOR player_1_held			;  |
	AND CPU.port_0_data_1			;  |
	STA player_1_pressed			;  |
	TXA					;  |
	STA player_1_held			;  |
	LDA #$0001				;  |
	STA CPU.enable_interrupts		;  |
	RTS					; /


copy_player_inputs:
	SEP #$20
	LDA #$01
.wait:
	BIT CPU.ppu_status
	BNE .wait
	REP #$20
	LDA CPU.port_0_data_1
	TAX
	EOR player_inputs_copy.p1_held
	AND CPU.port_0_data_1
	STA player_inputs_copy.p1_pressed
	TXA
	STA player_inputs_copy.p1_held
	RTL


;Replace with DMA later?
set_unused_OAM_offscreen:
	PHK					; \
	PLB					;  |
	LDX next_OAM_slot			;  |\ Check if oam is already full
	CPX #OAM_table+(sizeof(OAM)*128)	;  | |
	BEQ .oam_full				;  |/
	LDA #$F0FF				;  | Offscreen Y/X position
.next_slot					;  |\
	STA $00,x				;  | | Mark the slot screen
	INX					;  | |\ Increment to the next slot
	INX					;  | | |
	INX					;  | | |
	INX					;  | |/
	CPX #$0400				;  | | And check if we are at the last oam slot
	BNE .next_slot				;  |/
.oam_full					;  |
	RTS					; / Dead sprites nuked.


set_all_OAM_to_8x8:
	STZ OAM_attribute[$00].size
	STZ OAM_attribute[$02].size
	STZ OAM_attribute[$04].size
	STZ OAM_attribute[$06].size
	STZ OAM_attribute[$08].size
	STZ OAM_attribute[$0A].size
	STZ OAM_attribute[$0C].size
	STZ OAM_attribute[$0E].size
	STZ OAM_attribute[$10].size
	STZ OAM_attribute[$12].size
	STZ OAM_attribute[$14].size
	STZ OAM_attribute[$16].size
	STZ OAM_attribute[$18].size
	STZ OAM_attribute[$1A].size
	STZ OAM_attribute[$1C].size
	STZ OAM_attribute[$1E].size
	RTS


render_text:
	LDA temp_22				;Get text address
	TAY
	DEY
	LDX next_OAM_slot
	SEP #$20
.next_tile:
	INX                			;\ Move to next oam slot
	INX                			; |
	INX                			; |
	INX                			;/
	INY                			;> Move to next character in string
	INC temp_21				;> Move to next character column
	LDA $0000,y            			;\
	BMI .end_of_text        		;> If the character is $80-$FF then the string is done
	SEC                			;\
	SBC #$20            			;/ Offset character index from ascii to graphics
	BNE .no_space
	DEX
	DEX
	DEX
	DEX
	BRA .next_tile

.no_space:
	CLC
	ADC #$90
	STA OAM_relative[0].tile,x            	;> Store graphic id
	LDA records.del_mode_enabled
	BEQ .records_del_disabled
	LDA temp_26
	STA OAM_relative[0].property,x		;> Store tile properties
.get_x_pos:
	LDA temp_21				;> Get character base X position
	ASL                			;\ *8 because these are 8x8 tiles
	ASL                			; |
	ASL                			;/
	STA OAM_relative[0].x,x         	 ;> Store x position
.get_y_pos:
	LDA temp_20
	ASL                			;\ *8 because these are 8x8 tiles
	ASL                			; |
	ASL                			;/
	STA OAM_relative[0].y,x             	;> Store y position
	REP #$20
	LDA next_OAM_slot
	CLC
	ADC #$0004   				;>Set next free OAM address
	STA next_OAM_slot
	SEP #$20
	BRA .next_tile            		;> Move to the next character/tile

.end_of_text:
	REP #$20
	RTS

 .records_del_disabled:
 	LDA #$30
 	STA OAM_relative[0].property,x
 	BRA .get_x_pos



;Local copy to JSR to
draw_hud_graphic:
	LDY next_OAM_slot
	CLC
	ADC #$01D0
draw_hud_graphic_no_offset:
	ORA temp_3E
	STA $0002,y
	TXA
	ORA temp_1A
	STA $0000,y
	TYA
	CLC
	ADC #$0004
	STA next_OAM_slot
	TXA
	CLC
	ADC #$0008
	TAX
	RTS


get_song_id_from_table:
	LDA main_menu.selected_song
	ASL
	ASL
	TAX
	LDA.l song_id_table,x
	RTS



hex_to_decimal:
        STA temp_1A
        LSR
        ADC temp_1A
        ROR
        LSR
        LSR
        ADC temp_1A
        ROR
        ADC temp_1A
        ROR
        LSR
        AND #$3C
        STA temp_1B
        LSR
        ADC temp_1B
        ADC temp_1A
        RTL


;A = RAM Address
;X = Bytes to clear
clear_RAM_block:
	STA WRAM.address
	STX DMA[0].size
	LDA #.zero_fill
	STA DMA[0].source
	LDA #$8008
	STA DMA[0].settings
	SEP #$20
	LDA #bank(.zero_fill)
	STA DMA[0].source_bank
	LDA #bank(wram_base)
	STA WRAM.bank
	LDA #$01
	STA CPU.enable_DMA
	REP #$20
.oam_full:
	RTS

.zero_fill:
	db $00