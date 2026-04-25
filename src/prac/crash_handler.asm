
print pc
BRK_handler:
	REP #$20
	PHA
	SEP #$20
	PHB
	PHK
	PLB
	PLA
	STA BRK_data.reg_B
	LDA $03,s
	STA BRK_data.reg_P
	REP #$30
	PLA
	XBA
	STA BRK_data.reg_A
	TXA
	XBA
	STA BRK_data.reg_X
	TYA
	XBA
	STA BRK_data.reg_Y
	TDC
	XBA
	STA BRK_data.reg_D
	LDA #$0000
	TCD
	TSC
	CLC
	ADC #$0004
	XBA
	STA BRK_data.reg_S
	LDA NMI_pointer
	XBA
	STA BRK_data.NMI_ptr
	LDA game_mode_pointer
	XBA
	STA BRK_data.logic_ptr
	SEP #$20
	LDA $04,s
	STA BRK_data.PC
	LDA $03,s
	STA BRK_data.PC+$1
	LDA $02,s
	DEC
	DEC
	STA BRK_data.PC+$2
	LDY #$0000
	STZ BRK_data.stack_byte_count
.next_stack_byte:
	TSX
	CPX #stack
	BEQ .setup_PPU
	PLA
	STA.w BRK_data.stack_dump,y
	INC BRK_data.stack_byte_count
	INY
	BRA .next_stack_byte

.setup_PPU:
	JSL init_registers
	JSL clear_VRAM
	LDA #$0001
	STA PPU.layer_mode			;Set screen to mode 1
	LDA #$0005
	STA PPU.screens				;Enable layer 1/3 on main screen
	LDA #$0205
	STA PPU.layer_all_tiledata_base		;Set layer 1/3 tiledata to $5000/$2000
	STZ PPU.layer_1_2_tilemap_base
	LDA #$0074
	STA PPU.layer_3_4_tilemap_base		;Set layer 3 tilemap to $7400


;DMA Layer 3 ASCII text tiles
	LDA #$2100
	STA PPU.vram_address
	LDX.w #dialogue_font_tiledata>>16
	LDA #dialogue_font_tiledata
	LDY #$0650
	JSL DMA_to_VRAM


;DMA Layer 3 hex text tiles
	%dma_bg($2500, hex_text_tiledata)



;Setup bg3 text buffer
	TDC
	LDX #BRK_text
	LDY.w #BRK_text>>16
	JSR update_text_buffer
	JSR render_bg3_text
	JSR write_BRK_dump_to_vram


;Bluescreen and die
	REP #$20
	LDA #$7FFF
	SEP #$30
	LDX #$01
	STX PPU.cgram_address
	STA PPU.cgram_write
	XBA
	STA PPU.cgram_write
	STZ PPU.cgram_write
	STZ PPU.cgram_write
	DEX
	STX PPU.cgram_address
	STZ PPU.cgram_address
	STZ PPU.cgram_write
	LDA #$54
	STA PPU.cgram_write
	LDA #$0F
	STA PPU.screen				;Disable F-Blank + full brightness
..dead:
	JMP ..dead
	;STP




write_BRK_dump_to_vram:
	LDY #$0000
	LDA #BRK_data.PC
	LDX #$0003
	JSR .to_vram
	LDA #BRK_data.reg_B
	LDX #$0001
	JSR .to_vram
	LDA #BRK_data.reg_D
	LDX #$0002
	JSR .to_vram
	LDA #BRK_data.reg_A
	LDX #$0002
	JSR .to_vram
	LDA #BRK_data.reg_X
	LDX #$0002
	JSR .to_vram
	LDA #BRK_data.reg_Y
	LDX #$0002
	JSR .to_vram
	LDA #BRK_data.reg_P
	LDX #$0001
	JSR .to_vram
	LDA #BRK_data.reg_S
	LDX #$0002
	JSR .to_vram
	LDA #BRK_data.NMI_ptr
	LDX #$0002
	JSR .to_vram
	LDA #BRK_data.logic_ptr
	LDX #$0002
	JSR .to_vram
	; LDA #BRK_data.current_sprite
	; LDX #$0002
	; JSR .to_vram
	LDA #BRK_data.stack_dump
	LDX BRK_data.stack_byte_count
	JSR .stack_to_vram
	RTS




;X = bytes to write
.to_vram:
	PHA
	LDA BRK_dump_vram_addresses,y
	STA PPU.vram_address
	PLA
	STX temp_32
	TAX
..next_byte:
	SEP #$20
	LDA $00,x
	JSR .hex_byte_to_string
	REP #$20
	LDA temp_34
	STA PPU.vram_write
	LDA temp_36
	STA PPU.vram_write
	INX
	LDA temp_32
	DEC
	STA temp_32
	BNE ..next_byte
	INY
	INY
	RTS



.stack_to_vram:
	STX temp_32
	TAX
	LDA BRK_dump_vram_addresses,y
	STA temp_38
..next_byte:
	STA PPU.vram_address
	SEP #$20
	LDA $00,x
	JSR .hex_byte_to_string
	REP #$20
	LDA #$2024
	STA PPU.vram_write
	LDA temp_34
	STA PPU.vram_write
	LDA temp_36
	STA PPU.vram_write
	INX
	LDA temp_32
	DEC
	BEQ ..done
	CMP #$0064
	BCS ..done
	STA temp_32
	LDA temp_38
	CLC
	ADC #$0004
	STA temp_38
	BRA ..next_byte

..done:
	RTS



.hex_byte_to_string:
	PHA
	AND #$F0
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC #$A0
	STA temp_34
	LDA #$20
	STA temp_35
	PLA
	AND #$0F
	CLC
	ADC #$A0
	STA temp_36
	LDA #$20
	STA temp_37
	RTS



BRK_dump_vram_addresses:
	dw $7465				;PC
	dw $7471				;B
	dw $747B				;D
	dw $7485				;A
	dw $7491				;X
	dw $749B				;Y
	dw $74a5				;P
	dw $74B1				;S
	dw $752A				;NMI
	dw $7538				;LOGIC
	;dw $74FC				;SPR
	dw $7680				;STACK DUMP


BRK_text:
	db $00
	db "   An exception has occured."
	db $00
	db $00
	db "PC: $        B: $      D: $"
	db $00
	db " A: $        X: $      Y: $"
	db $00
	db " P: $        S: $"
	db $00
	db $00
	db $00
	db $00
	db "    NMI: $      LOGIC: $"
	db $00
	db $00
	db $00
	db "If you believe this was not a"
	db $00
	db "vanilla crash, please submit a"
	db $00
	db "a bug report."
	db $00
	db $00
	db $00
	db $00
	db "          STACK DUMP:"
	db $FF





;A = Text VRAM offset
;X = Text address
;Y = Text bank

update_text_buffer:
%local(.text_address, temp_32)
%local(.text_bank, temp_34)
%local(.current_line_offset, temp_36)
	STX .text_address
	STY .text_bank
	STZ .current_line_offset
	PHB
	PEA.w wram_base>>8
	PLB
	PLB
	STA.w brk_vram_text_buffer.xy_offset
	TDC
	TAX
	TAY
	;LDX #$0000
	;LDY #$0000
	SEP #$20
.next_char:
	LDA [.text_address],y
	BEQ .new_line
	BMI .done
	CMP #$20
	BNE .no_space
	TDC
.no_space:
	STA.w brk_vram_text_buffer.text,x
	INX
	LDA #$20
	STA.w brk_vram_text_buffer.text,x
	INX
	INY
	BRA .next_char

.new_line:
	REP #$20
	LDX #$0000
	LDA .current_line_offset
	CLC
	ADC #$0040
	STA .current_line_offset
	TXA
	ADC .current_line_offset
	TAX
	INY
	SEP #$20
	BRA .next_char

.done:
	STX.w brk_vram_text_buffer.size
	PLB
	REP #$20
	RTS



render_bg3_text:
	PHB
	LDA #$7400
	CLC
	ADC.l brk_vram_text_buffer.xy_offset|wram_base
	STA PPU.vram_address
	SEP #$20
	LDA #$01
	STA DMA[0].settings
	LDA #$18
	STA DMA[0].destination
	LDX.w #brk_vram_text_buffer.text
	STX DMA[0].source
	LDA.b #wram_base>>16
	STA DMA[0].source_bank
	PHA
	PLB
	LDX.w brk_vram_text_buffer.size
	PLB
	STX DMA[0].size
	LDA #$01
	STA CPU.enable_DMA
	REP #$20
	RTS