hijack_file_select_vram_payload = $FD210D


org hijack_file_select_vram_payload
	%vram_payload(tv_screen_tiledata, $A000, $2FA0, !big_data_compression)
	%vram_payload(tv_screen_tilemap, $FC00, $0700, !small_data_compression)
	%vram_payload(area_name_font, $0020, $0F00, !big_data_compression)
	%vram_payload(main_menu_tiledata, $5000, datasize(main_menu_tiledata), !no_compression)
	%vram_payload(main_menu_tilemap, $7400, datasize(main_menu_tilemap), !no_compression)
	%vram_payload(kong_icons_tiledata, $07A0, datasize(kong_icons_tiledata), !no_compression)
	%vram_payload(shit_text_tiledata, $0900, datasize(shit_text_tiledata), !no_compression)
	db $00