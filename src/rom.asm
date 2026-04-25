include




if !version == !us
;BANK 80
NMI_return			= $808332
init_registers 			= $8081C5
init_registers_global		= $808258
clear_VRAM			= $80825E
clear_VRAM_global		= $808282
generic_level_NMI		= $808348
set_and_wait_for_NMI		= $80839D
set_and_wait_for_NMI_2		= $8083C3
set_screen_fade			= $808501
handle_screen_fade		= $808508
DMA_to_VRAM			= $8087E0
set_all_OAM_offscreen_global	= $808983
set_unused_OAM_offscreen_global	= $80898C
exit_level_start_select		= $808BAF
prepare_OAM_DMA_channel_global	= $808C3F
song_id_table			= $80C38F
clear_wram_tables		= $808CB0
get_RNG				= $808C60


;BANK B2
upload_SPC_engine		= $B28000
play_song			= $B28009
play_song_with_transition	= $B2800C
transition_song			= $B2800F
queue_sound_effect		= $B28012


;BANK B4
init_level			= $B4B37B
init_npc_or_cave_screen		= $B4807B
init_world_map_flags		= $B4BC2B



;Bank B9
process_current_movement	= $B9E000
process_alternate_movement	= $B9E003
process_terrain			= $B9E006
set_anim_handle_kiddy		= $B9A009
process_anim_preserve_state	= $B9A00C


;BANK BB
decompress_big_data		= $BB862F
decompress_small_data		= $BB8A6F
set_PPU_registers 		= $BB8CC4
VRAM_payload_handler		= $BB8CF6
DMA_palette			= $BB8E15
disable_screen			= $BB9B42
enable_timestop			= $BBB9DD
spawn_sprite_from_index		= $BB8F34



;BANK BF
queue_sound_effect_BF		= $BFF006



;BANK D2 (DATA)
tv_screen_tiledata		= $D2FF14



;BANK E8 (DATA)
tv_screen_tilemap		= $E88052



;BANK FC (DATA)
area_name_font			= $FC0000
dialogue_font_tiledata		= $FC14A0


;BANK FD (DATA)
sprite_palette_table		= $FD3201
tv_screen_bg_palette		= $FD8381
dixie_palettes_base		= $FD341B
kiddy_palettes_base		= $FD34CF





elseif !version == !j0
;BANK 80
NMI_return			= $808321
init_registers 			= $8081C5
init_registers_global		= $808258
clear_VRAM			= $80825E
clear_VRAM_global		= $808282
generic_level_NMI		= $808337
set_and_wait_for_NMI		= $80838C
set_and_wait_for_NMI_2		= $8083B2
set_screen_fade			= $8084F0
handle_screen_fade		= $8084F7
DMA_to_VRAM			= $8087CF
set_all_OAM_offscreen_global	= $808972
set_unused_OAM_offscreen_global	= $80897B
exit_level_start_select		= $808B9E
prepare_OAM_DMA_channel_global	= $808C2E
song_id_table			= $80C353
clear_wram_tables		= $808C9F
get_RNG				= $808C4F


;BANK B2
upload_SPC_engine		= $B28000
play_song			= $B28009
play_song_with_transition	= $B2800C
transition_song			= $B2800F
queue_sound_effect		= $B28012


;BANK B4
init_level			= $B4B266
init_npc_or_cave_screen		= $B48081
init_world_map_flags		= $B4BB2A



;Bank B9
process_current_movement	= $B9E000
process_alternate_movement	= $B9E003
process_terrain			= $B9E006
set_anim_handle_kiddy		= $B9A009
process_anim_preserve_state	= $B9A00C


;BANK BB
decompress_big_data		= $BB862F
decompress_small_data		= $BB8A6F
set_PPU_registers 		= $BB8CC4
VRAM_payload_handler		= $BB8CF6
DMA_palette			= $BB8E15
disable_screen			= $BB9B42
enable_timestop			= $BBB9EF
spawn_sprite_from_index		= $BB8F61



;BANK BF
queue_sound_effect_BF		= $BFF006



;BANK D2 (DATA)
tv_screen_tiledata		= $D2FF14



;BANK E8 (DATA)
tv_screen_tilemap		= $E88052



;BANK FC (DATA)
area_name_font			= $FC0000
dialogue_font_tiledata		= $FC14A0


;BANK FD (DATA)
sprite_palette_table		= $FD31B4
tv_screen_bg_palette		= $FD8334
dixie_palettes_base		= $FD33CE
kiddy_palettes_base		= $FD3482





elseif !version == !j1
;BANK 80
NMI_return			= $808321
init_registers 			= $8081C5
init_registers_global		= $808258
clear_VRAM			= $80825E
clear_VRAM_global		= $808282
generic_level_NMI		= $808337
set_and_wait_for_NMI		= $80838C
set_and_wait_for_NMI_2		= $8083B2
set_screen_fade			= $8084F0
handle_screen_fade		= $8084F7
DMA_to_VRAM			= $8087CF
set_all_OAM_offscreen_global	= $808972
set_unused_OAM_offscreen_global	= $80897B
exit_level_start_select		= $808B9E
prepare_OAM_DMA_channel_global	= $808C2E
song_id_table			= $80C375
clear_wram_tables		= $808C9F
get_RNG				= $808C4F


;BANK B2
upload_SPC_engine		= $B28000
play_song			= $B28009
play_song_with_transition	= $B2800C
transition_song			= $B2800F
queue_sound_effect		= $B28012


;BANK B4
init_level			= $B4B274
init_npc_or_cave_screen		= $B48081
init_world_map_flags		= $B4BB38



;Bank B9
process_current_movement	= $B9E000
process_alternate_movement	= $B9E003
process_terrain			= $B9E006
set_anim_handle_kiddy		= $B9A009
process_anim_preserve_state	= $B9A00C


;BANK BB
decompress_big_data		= $BB862F
decompress_small_data		= $BB8A6F
set_PPU_registers 		= $BB8CC4
VRAM_payload_handler		= $BB8CF6
DMA_palette			= $BB8E15
disable_screen			= $BB9B42
enable_timestop			= $BBB9EF
spawn_sprite_from_index		= $BB8F34



;BANK BF
queue_sound_effect_BF		= $BFF006



;BANK D2 (DATA)
tv_screen_tiledata		= $D2FF14



;BANK E8 (DATA)
tv_screen_tilemap		= $E88052



;BANK FC (DATA)
area_name_font			= $FC0000
dialogue_font_tiledata		= $FC14A0


;BANK FD (DATA)
sprite_palette_table		= $FD31B4
tv_screen_bg_palette		= $FD8334
dixie_palettes_base		= $FD33CE
kiddy_palettes_base		= $FD3482


endif