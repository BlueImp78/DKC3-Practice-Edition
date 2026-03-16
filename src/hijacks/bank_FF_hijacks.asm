hijack_dixie_life_icon_graphic	= $CE46D1
hijack_hud_numbers_graphic	= $FFE3C0 ;$FFE400



;Insert input display tiles
org hijack_dixie_life_icon_graphic
	db $18, $00, $3C, $00, $24, $18, $66, $18, $42, $3C, $C3, $3C, $81, $7E, $FF, $00
	db $00, $00, $00, $00, $18, $18, $18, $18, $3C, $3C, $3C, $3C, $7E, $7E, $00, $00
	db $E0, $00, $B8, $40, $8E, $70, $83, $7C, $83, $7C, $8E, $70, $B8, $40, $E0, $00
	db $00, $00, $40, $40, $70, $70, $7C, $7C, $7C, $7C, $70, $70, $40, $40, $00, $00
	db $00, $00, $00, $00, $FF, $00, $81, $7E, $81, $7E, $FF, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $7E, $7E, $7E, $7E, $00, $00, $00, $00, $00, $00
	db $3C, $00, $42, $3C, $81, $7E, $81, $7E, $81, $7E, $81, $7E, $42, $3C, $3C, $00
	db $00, $00, $3C, $3C, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $3C, $3C, $00, $00



;Insert 8x8 number tiles to use instead of 8x16
org hijack_hud_numbers_graphic
	incbin "data/gfx/sprites/hud_numbers.bin"