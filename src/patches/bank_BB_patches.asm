banana_hud_skip_check:
	%conditional_ram_word(LDA, $075C)
	CMP #$0002
	BEQ .on_bonus
.return:
	PLA						;Pop initial JSR
	PLA : PLB					;Pop hijack's JSL
if !version == !us
	JML $BBADFB
else
	JML $BBAE0D
endif

.on_bonus:
	%conditional_ram_word(LDA, $075E)
	AND #$00FF
	CMP #$0003
	BCC .return					;If bonus is find the coin or bash the baddies, return
if !version == !us
	LDA $18CD					;Hijacked instruction
	CMP $18CB					;Hijacked instruction
else
	LDA $1953					;Hijacked instruction
	CMP $1951					;Hijacked instruction
endif
	RTL





;Abandon all hope ye who enter here
upload_new_kong_palettes:
%local(.palette_type_offset, temp_34)
%local(.address, temp_36)
%local(.bank, temp_38)
	PHB
	PHK
	PLB
	LDA.w #bank(dixie_normal_palette_offsets)
	STA .bank
	%conditional_ram_word(LDA, $0775)
	AND #$8000					;Check if dark level effect
	BEQ .normal_level
	JMP .dark_level

.normal_level:
	TDC
.set_type_offset:
	STA .palette_type_offset
	LDA main_menu.selected_color
	ASL
	TAX
	LDA $04EF					;Requested palette ID
	CMP #$0002
	BEQ .kiddy
	CMP #$0004
	BEQ .kiddy
	CMP #$0007
	BEQ .3rd_person_dixie
	CMP #$0008
	BEQ .3rd_person_kiddy
	CMP #$0009
	BEQ .map_kongs
	CMP #$000A
	BEQ .map_flags
.dixie:
	LDA #dixie_normal_palette_offsets
.done:
	CLC
	ADC .palette_type_offset
	STA .address
	TXY
	LDA [.address],y
	TAY
	PLB
	RTL

.kiddy:
	LDA #kiddy_normal_palette_offsets
	BRA .done


.3rd_person_dixie:
	LDA #dixie_3rd_person_palette_offsets-dixie_normal_palette_offsets
	STA .palette_type_offset

;Ugly ass hack to make this work for the 3rd person kong lol
	LDA main_menu.selected_color
	CMP #$0002
	BCC .dixie
	LDA #$0003
	STA $04EF
	LDA #dixie_palettes_base
	STA $04F1
	BRA .dixie

.3rd_person_kiddy:
	LDA #kiddy_3rd_person_palette_offsets-kiddy_normal_palette_offsets
	STA .palette_type_offset

;Ugly ass hack to make this work for the 3rd person kong lol
	LDA main_menu.selected_color
	CMP #$0002
	BCC .kiddy
	LDA #$0004
	STA $04EF
	LDA #kiddy_palettes_base
	STA $04F1
	BRA .kiddy


.map_kongs:
	LDA #map_kongs_palette_offsets-dixie_normal_palette_offsets
	STA .palette_type_offset

;Ugly ass hack to make this work for the map kongs lol
	LDA main_menu.selected_color
	CMP #$0002
	BCC .dixie
	;LDA #$0009
	;STA $04EF
	LDA #dixie_palettes_base
	STA $04F1
	BRA .dixie



.map_flags:

	LDA #map_flags_palette_offsets-dixie_normal_palette_offsets
	STA .palette_type_offset

;Ugly ass hack to make this work for the map kongs lol
	LDA main_menu.selected_color
	CMP #$0002
	BCC .dixie
	;LDA #$0009
	;STA $04EF
	LDA #dixie_palettes_base
	STA $04F1
	BRA .dixie




.dark_level:
	LDA main_menu.selected_color
	CMP #$0002					;If selected color is 2 or below then dont overwrite palette address
	BCC .no_overwrite
	LDA $04EF				 	;Requested palette ID
	ASL
	TAX
	LDA.l sprite_palette_table,x
	STA $04F1
	LDA.w #bank(sprite_palette_table)
	STA $04F3
.no_overwrite:
	LDA parent_level_number
	CMP #!level_floodlit_fish
	BEQ .inverted
	LDA #datasize(dixie_normal_palette_offsets)*2
	JMP .set_type_offset

.inverted:
	LDA #datasize(dixie_normal_palette_offsets)*4
	JMP .set_type_offset



dixie_normal_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw dixie_pal_3_active-dixie_palettes_base		;02, color 3
	dw dixie_pal_4_active-dixie_palettes_base		;03, color 4
	dw dixie_pal_5_active-dixie_palettes_base		;04, color 5
	dw dixie_pal_6_active-dixie_palettes_base		;05, color 6
	dw dixie_pal_7_active-dixie_palettes_base		;06, color 7
	dw dixie_pal_8_active-dixie_palettes_base		;07, color 8
	dw dixie_pal_9_active-dixie_palettes_base		;08, color 9
.end


kiddy_normal_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw kiddy_pal_3_active-kiddy_palettes_base		;02, color 3
	dw kiddy_pal_4_active-kiddy_palettes_base		;03, color 4
	dw kiddy_pal_5_active-kiddy_palettes_base		;04, color 5
	dw kiddy_pal_6_active-kiddy_palettes_base		;05, color 6
	dw kiddy_pal_7_active-kiddy_palettes_base		;06, color 7
	dw kiddy_pal_8_active-kiddy_palettes_base		;07, color 8
	dw kiddy_pal_9_active-kiddy_palettes_base		;08, color 9
.end


dixie_dark_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw dixie_pal_3_active_dark-dixie_palettes_base		;02, color 3
	dw dixie_pal_4_active_dark-dixie_palettes_base		;03, color 4
	dw dixie_pal_5_active_dark-dixie_palettes_base		;04, color 5
	dw dixie_pal_6_active_dark-dixie_palettes_base		;05, color 6
	dw dixie_pal_7_active_dark-dixie_palettes_base		;06, color 7
	dw dixie_pal_8_active_dark-dixie_palettes_base		;07, color 8
	dw dixie_pal_9_active_dark-dixie_palettes_base		;08, color 9
.end


kiddy_dark_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw kiddy_pal_3_active_dark-kiddy_palettes_base		;02, color 3
	dw kiddy_pal_4_active_dark-kiddy_palettes_base		;03, color 4
	dw kiddy_pal_5_active_dark-kiddy_palettes_base		;04, color 5
	dw kiddy_pal_6_active_dark-kiddy_palettes_base		;05, color 6
	dw kiddy_pal_7_active_dark-kiddy_palettes_base		;06, color 7
	dw kiddy_pal_8_active_dark-kiddy_palettes_base		;07, color 8
	dw kiddy_pal_9_active_dark-kiddy_palettes_base		;08, color 9
.end


dixie_inverted_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw dixie_pal_3_active_inverted-dixie_palettes_base	;02, color 3
	dw dixie_pal_4_active_inverted-dixie_palettes_base	;03, color 4
	dw dixie_pal_5_active_inverted-dixie_palettes_base	;04, color 5
	dw dixie_pal_6_active_inverted-dixie_palettes_base	;05, color 6
	dw dixie_pal_7_active_inverted-dixie_palettes_base	;06, color 7
	dw dixie_pal_8_active_inverted-dixie_palettes_base	;07, color 8
	dw dixie_pal_9_active_inverted-dixie_palettes_base	;08, color 9
.end


kiddy_inverted_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw kiddy_pal_3_active_inverted-kiddy_palettes_base	;02, color 3
	dw kiddy_pal_4_active_inverted-kiddy_palettes_base	;03, color 4
	dw kiddy_pal_5_active_inverted-kiddy_palettes_base	;04, color 5
	dw kiddy_pal_6_active_inverted-kiddy_palettes_base	;05, color 6
	dw kiddy_pal_7_active_inverted-kiddy_palettes_base	;06, color 7
	dw kiddy_pal_8_active_inverted-kiddy_palettes_base	;07, color 8
	dw kiddy_pal_9_active_inverted-kiddy_palettes_base	;08, color 9
.end

dixie_3rd_person_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw dixie_pal_3_3rd_person-dixie_palettes_base		;02, color 3
	dw dixie_pal_4_3rd_person-dixie_palettes_base		;03, color 4
	dw dixie_pal_5_3rd_person-dixie_palettes_base		;04, color 5
	dw dixie_pal_6_3rd_person-dixie_palettes_base		;05, color 6
	dw dixie_pal_7_3rd_person-dixie_palettes_base		;06, color 7
	dw dixie_pal_8_3rd_person-dixie_palettes_base		;07, color 8
	dw dixie_pal_9_3rd_person-dixie_palettes_base		;08, color 9
.end


kiddy_3rd_person_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw kiddy_pal_3_3rd_person-kiddy_palettes_base		;02, color 3
	dw kiddy_pal_4_3rd_person-kiddy_palettes_base		;03, color 4
	dw kiddy_pal_5_3rd_person-kiddy_palettes_base		;04, color 5
	dw kiddy_pal_6_3rd_person-kiddy_palettes_base		;05, color 6
	dw kiddy_pal_7_3rd_person-kiddy_palettes_base		;06, color 7
	dw kiddy_pal_8_3rd_person-kiddy_palettes_base		;07, color 8
	dw kiddy_pal_9_3rd_person-kiddy_palettes_base		;08, color 9
.end


map_kongs_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw map_kongs_pal_3-dixie_palettes_base			;02, color 3
	dw map_kongs_pal_4-dixie_palettes_base			;03, color 4
	dw map_kongs_pal_5-dixie_palettes_base			;04, color 5
	dw map_kongs_pal_6-dixie_palettes_base			;05, color 6
	dw map_kongs_pal_7-dixie_palettes_base			;06, color 7
	dw map_kongs_pal_8-dixie_palettes_base			;07, color 8
	dw map_kongs_pal_9-dixie_palettes_base			;08, color 9
.end

map_flags_palette_offsets:
	dw $0000						;00, color 1
	dw $003C						;01, color 2
	dw map_flags_pal_3-dixie_palettes_base			;02, color 3
	dw map_flags_pal_4-dixie_palettes_base			;03, color 4
	dw map_flags_pal_5-dixie_palettes_base			;04, color 5
	dw map_flags_pal_6-dixie_palettes_base			;05, color 6
	dw map_flags_pal_7-dixie_palettes_base			;06, color 7
	dw map_flags_pal_8-dixie_palettes_base			;07, color 8
	dw map_flags_pal_9-dixie_palettes_base			;08, color 9
.end





fuck1:
	LDA temp_40
	LDY main_menu.selected_color
	CPY #$0002
	BCS .skip_lsr
.lsr:
	LSR
.return:
	ADC $04F1
	STA $04F1
	RTL

.skip_lsr:
	LDY $04EF
	CPY #$0009
	BEQ .clc
	CPY #$000A
	BEQ .clc
	BRA .lsr

.clc:
	CLC
	BRA .return