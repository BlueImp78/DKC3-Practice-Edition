if !version == !us
BRK_native_start		= $00FFE6
hijack_start_select_check 	= $808BA4
hijack_pause_handler		= $808AFD
hijack_gameplay_frame_count_inc	= $808353
hijack_bonus_screen		= $808379
hijack_wrinkly_save_routine	= $80AF0C



elseif !version == !j0
BRK_native_start		= $00FFE6
hijack_start_select_check 	= $808B93
hijack_pause_handler		= $808AEC
hijack_gameplay_frame_count_inc	= $808342
hijack_bonus_screen		= $808368
hijack_pause_flag_set		= $808ACB
hijack_wrinkly_save_routine	= $80AD87



elseif !version == !j1
BRK_native_start		= $00FFE6
hijack_start_select_check 	= $808B93
hijack_pause_handler		= $808AEC
hijack_gameplay_frame_count_inc	= $808342
hijack_bonus_screen		= $808368
hijack_pause_flag_set		= $808ACB
hijack_wrinkly_save_routine	= $80ADA9


endif



hijack_boot_code 		= $8080C4
hijack_unused_NMI_handler 	= $80CB6E	;An unused copy of NMI handler in US, junk unused space in J




org BRK_native_start
	dw BRK_handler



org hijack_boot_code

RESET_START:
	LDA #$01
	STA CPU.rom_speed
	JML .fast_rom_hop

.fast_rom_hop:
	SEI					; \ Disable interrupts
	CLC					;  |
	XCE					;  | Disable emulation mode
	STZ CPU.enable_HDMA			;  | Disable HDMA
	REP #$38				;  | 16-Bit A/X/Y, clear decimal flag
	LDX #stack				;  | Reset stack
	TXS					;  |
	JSR init_registers			;  | Initialize all registers
	JSR clear_VRAM				;  | Nuke VRAM
	STZ DMA[0].size				;  | Set DMA size to zero, (64KB)
	LDA #.zero_fill				;  | Set DMA source address to zero byte in ROM
	STA DMA[0].source			;  |
	LDA #$8008				;  | Set DMA destination to $2180, fixed transfer, write once
	STA DMA[0].settings			;  |
	STZ WRAM.address			;  | DMA destination address to $0000 in WRAM
	SEP #$20				;  | 8-Bit A
	LDA #bank(.zero_fill)			;  | Set DMA source bank to zero byte in ROM
	STA DMA[0].source_bank			;  |
	STZ WRAM.bank				;  | Set DMA destination bank to $7E (WRAM)
	LDA #$01				;  | Enable DMA
	STA CPU.enable_DMA			;  |
	LDA #bank(wram_base_high)		;  | Set DMA destination bank to $7F (WRAM)
	STA WRAM.bank				;  |
	STA CPU.enable_DMA			;  | Enable DMA to full clear WRAM
	REP #$20				;  | 16-Bit A
	JSL upload_SPC_engine			;  |
	JSL set_all_OAM_offscreen_global	;  |
	LDA #$3127				;  |
	STA $02					;  | Init RNG
	STA $04					;  |
if !version == !us				;  |
	LDA #$1D93				;  |
	STA $0541				;  | Do this or some sprite rendering bullshit routine will crash
else						;  |
	LDA #$1D1E				;  |
	STA $0547				;  | Same for J
endif						;  |
        JML main_menu_init			; /


.zero_fill:
	db $00					;>






org hijack_unused_NMI_handler
	main_menu_NMI_hop:
		JML main_menu_NMI

	records_NMI_hop:
		JML records_NMI

	settings_NMI_hop:
		JML settings_NMI


;Include some code here cuz convenient spot to save space in BA. Nothing but junk data ahead in this bank.
	incsrc "src/patches/bank_80_patches.asm"
	incsrc "src/patches/bank_B2_patches.asm"
	incsrc "src/patches/bank_B4_patches.asm"
	incsrc "src/patches/bank_B5_patches.asm"
	incsrc "src/patches/bank_B8_patches.asm"
	incsrc "src/patches/bank_BB_patches.asm"
	incsrc "src/patches/bank_BE_patches.asm"


	incsrc "src/prac/savestate.asm"
	incsrc "src/prac/sram.asm"
	incsrc "src/prac/best_times.asm"
	incsrc "src/prac/crash_handler.asm"




	print "Bank 80 End: ", pc



org hijack_start_select_check
	JSL start_select_always
	NOP
	NOP


org hijack_pause_handler
	JSL check_fast_retry_LR_input


org hijack_gameplay_frame_count_inc
	JSL update_timer_in_level


org hijack_bonus_screen
	JSL update_timer_in_bonus_screen



org hijack_wrinkly_save_routine
	NOP
	NOP
	NOP



if !version != !us
org hijack_pause_flag_set
	JSL check_bleak_skip
	NOP
	NOP
endif