;**********************************************************************************************************
;*                                                          					          *
;*                  		   DONKEY KONG COUNTRY 3: PRACTICE EDITION        			  *
;*                                                          					          *
;*                       		    BY BLUEIMP, 2026            				  *
;*                                                          					          *
;**********************************************************************************************************

hirom

optimize dp always
optimize address mirrors



;INCLUDES
incsrc "src/macros.asm"
incsrc "src/constants.asm"
incsrc "src/mmio.asm"
incsrc "src/ram.asm"
incsrc "src/rom.asm"
incsrc "src/structs.asm"




;HIJACKS
incsrc "src/hijacks/bank_80_hijacks.asm"
incsrc "src/hijacks/bank_B2_hijacks.asm"
incsrc "src/hijacks/bank_B3_hijacks.asm"
incsrc "src/hijacks/bank_B4_hijacks.asm"
incsrc "src/hijacks/bank_B5_hijacks.asm"
incsrc "src/hijacks/bank_B6_hijacks.asm"
incsrc "src/hijacks/bank_B8_hijacks.asm"
incsrc "src/hijacks/bank_BB_hijacks.asm"
incsrc "src/hijacks/bank_BE_hijacks.asm"
incsrc "src/hijacks/bank_FD_hijacks.asm"
incsrc "src/hijacks/bank_FF_hijacks.asm"







;NEW CODE/DATA
org $BAD100
	incsrc "src/prac/general.asm"
	incsrc "src/prac/main_menu_init.asm"
	incsrc "src/prac/main_menu_nmi.asm"
	incsrc "src/prac/main_menu_logic.asm"
	incsrc "data/asm/main_menu_data.asm"

	incsrc "src/prac/records_init.asm"
	incsrc "src/prac/records_nmi.asm"
	incsrc "src/prac/records_logic.asm"
	incsrc "data/asm/records_data.asm"

	incsrc "src/prac/settings_init.asm"
	incsrc "src/prac/settings_nmi.asm"
	incsrc "src/prac/settings_logic.asm"
	incsrc "data/asm/settings_data.asm"

	incsrc "src/prac/fast_retry.asm"

	incsrc "src/prac/timer.asm"
	incsrc "src/prac/input_display.asm"


;PATCHES
	incsrc "src/patches/bank_80_patches.asm"
	incsrc "src/patches/bank_B2_patches.asm"
	incsrc "src/patches/bank_B4_patches.asm"
	incsrc "src/patches/bank_B5_patches.asm"
	incsrc "src/patches/bank_B8_patches.asm"
	incsrc "src/patches/bank_BE_patches.asm"


print "Bank BA End: ", pc




;New graphics (Replacing boss photos tiledata+tilemap)
org $EB19BB
main_menu_tiledata:
	incbin "data/gfx/bg/main_menu/main_menu_tiledata.bin"

main_menu_tilemap:
	incbin "data/gfx/bg/main_menu/main_menu_tilemap.bin"

settings_tiledata:
	incbin "data/gfx/bg/settings/settings_tiledata.bin"

settings_tilemap:
	incbin "data/gfx/bg/settings/settings_tilemap.bin"

records_tiledata:
	incbin "data/gfx/bg/records/records_tiledata.bin"

records_tilemap:
	incbin "data/gfx/bg/records/records_tilemap.bin"

kong_icons_tiledata:
	incbin "data/gfx/sprites/kong_icons.bin"

shit_text_tiledata:
	incbin "data/gfx/sprites/4bpp_text.bin"
.end

print "Bank EB End: ", pc

assert pc() <= $EB81FF






;New palettes (garbage data from here on)
org $FDE815
main_menu_sprite_text_purple_pall_full:
	incbin "data/gfx/sprites/sprite_text_purple_pal_full.bin"

main_menu_sprite_text_palettes:
	incbin "data/gfx/sprites/sprite_text_palettes.bin"

kong_icons_palette_p1:
	incbin "data/gfx/sprites/kong_icons_palette_p1.bin"

kong_icons_palette_p2:
	incbin "data/gfx/sprites/kong_icons_palette_p2.bin"

settings_palette:
	incbin "data/gfx/bg/settings/settings_palette.bin"

records_palette:
	incbin "data/gfx/bg/records/records_palette.bin"
.end


print "Bank FD End: ", pc





;TODO:
;Play correct version of bonus song depending on the level.


;BUGS:
;Cross-level/entrance savestate breaks.