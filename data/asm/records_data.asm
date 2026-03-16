records_world_text:
	dw .w1
	dw .w2
	dw .w3
	dw .w4
	dw .w5
	dw .w6
	dw .w7
	dw .w8


.w1:
	db "1", $FF

.w2:
	db "2", $FF

.w3:
	db "3", $FF

.w4:
	db "4", $FF

.w5:
	db "5", $FF

.w6:
	db "6", $FF

.w7:
	db "7", $FF

.w8:
	db "8", $FF


records_level_names:
	dw records_w1
	dw records_w2
	dw records_w3
	dw records_w4
	dw records_w5
	dw records_w6
	dw records_w7
	dw records_w8


records_w1:
	dw $0006
	dw .lakeside_limbo
	dw .doorstop_dash
	dw .tidal_trouble
	dw .skiddas_row
	dw .murky_mill
	dw .belchas_barn

.lakeside_limbo:
	db "Lakeside Limbo", $FF

.doorstop_dash:
	db "Doorstop Dash", $FF

.tidal_trouble:
	db "Tidal Trouble", $FF

.skiddas_row:
	db "Skidda's Row", $FF

.murky_mill:
	db "Murky Mill", $FF

.belchas_barn:
	db "Belcha's Barn", $FF


records_w2:
	dw $0006
	dw .barrel_shield_bustup
	dw .riverside_race
	dw .squeals_on_wheels
	dw .springin_spiders
	dw .bobbing_barrel_brawl
	dw .arichs_ambush

.barrel_shield_bustup:
	db "Barrel S. Bustup", $FF

.riverside_race:
	db "Riverside Race", $FF

.squeals_on_wheels:
	db "Squeals on Wheels", $FF

.springin_spiders:
	db "Springin' Spiders", $FF

.bobbing_barrel_brawl:
	db "Bobbing B. Brawl", $FF

.arichs_ambush:
	db "Arich's Ambush", $FF


records_w3:
	dw $0006
	dw .fireball_frenzy
	dw .demolition_drainpipe
	dw .ripsaw_rage
	dw .blazing_bazukas
	dw .lowg_labyrinth
	dw .kaos_karnage

.fireball_frenzy:
	db "Fireball Frenzy", $FF

.demolition_drainpipe:
	db "Demolition D. Pipe", $FF

.ripsaw_rage:
	db "Ripsaw Rage", $FF

.blazing_bazukas:
	db "Blazing Bazukas", $FF

.lowg_labyrinth:
	db "Low-G Labyrinth", $FF

.kaos_karnage:
	db "Kaos Karnage", $FF


records_w4:
	dw $0006
	dw .bazzas_blockade
	dw .rocket_barrel_ride
	dw .kreeping_klasps
	dw .tracker_barrel_trek
	dw .fish_food_frenzy
	dw .squirts_showdown

.bazzas_blockade:
	db "Bazza's Blockade", $FF

.rocket_barrel_ride:
	db "Rocket B. Ride", $FF

.kreeping_klasps:
	db "Kreeping Klasps", $FF

.tracker_barrel_trek:
	db "Tracker B. Trek", $FF

.fish_food_frenzy:
	db "Fish Food Frenzy", $FF

.squirts_showdown:
	db "Squirt's Showdown", $FF


records_w5:
	dw $0006
	dw .krevice_kreepers
	dw .tearaway_toboggan
	dw .barrel_drop_bounce
	dw .krackshot_kroc
	dw .lemguin_lunge
	dw .bleaks_house

.krevice_kreepers:
	db "Krevice Kreepers", $FF

.tearaway_toboggan:
	db "Tearaway Toboggan", $FF

.barrel_drop_bounce:
	db "Barrel D. Bounce", $FF

.krackshot_kroc:
	db "Krackshot Kroc", $FF

.lemguin_lunge:
	db "Lemguin Lunge", $FF

.bleaks_house:
	db "Bleak's House", $FF


records_w6:
	dw $0006
	dw .buzzer_barrage
	dw .kongfused_cliffs
	dw .floodlit_fish
	dw .pothole_panic
	dw .ropey_rumpus
	dw .barbos_barrier

.buzzer_barrage:
	db "Buzzer Barrage", $FF

.kongfused_cliffs:
	db "Kongfused Cliffs", $FF

.floodlit_fish:
	db "Floodlit Fish", $FF

.pothole_panic:
	db "Pothole Panic", $FF

.ropey_rumpus:
	db "Ropey Rumpus", $FF

.barbos_barrier:
	db "Barbos's Barrier", $FF


records_w7:
	dw $0006
	dw .konveyor_rope_klash
	dw .creepy_caverns
	dw .lightning_lookout
	dw .koindozer_klamber
	dw .poisonous_pipeline
	dw .kastle_kaos

.konveyor_rope_klash:
	db "Konveyor R. Klash", $FF

.creepy_caverns:
	db "Creepy Caverns", $FF

.lightning_lookout:
	db "Lightning L.", $FF

.koindozer_klamber:
	db "Koindozer Klamber", $FF

.poisonous_pipeline:
	db "Poisonous Pipeline", $FF

.kastle_kaos:
	db "Kastle Kaos", $FF


records_w8:
	dw $0006
	dw .stampede_sprint
	dw .criss_kross_cliffs
	dw .tyrant_twin_tussle
	dw .swoopy_salvo
	dw .rocket_rush
	dw .knautilus

.stampede_sprint:
	db "Stampede Sprint", $FF

.criss_kross_cliffs:
	db "Criss Kross Cliffs", $FF

.tyrant_twin_tussle:
	db "Tyrant Twin Tussle", $FF

.swoopy_salvo:
	db "Swoopy Salvo", $FF

.rocket_rush:
	db "Rocket Rush", $FF

.knautilus:
	db "Knautilus", $FF


placeholder_text:
	db "-:--.--", $FF





records_world_adress_offsets:
	dw $FA00				;Lake Orangatanga
	dw $FA30				;Kremwood Forest
	dw $FA60				;Cotton-Top Cove
	dw $FA90				;Mekanos
	dw $FAC0 				;K3
	dw $FAF0				;Razor Ridge
	dw $FB20 				;Kaos Kore
	dw $FB50 				;Krematoa


;For checking best times when entered level from map, indexed with parent level number
ass_table:
	db $00					;00
	db $00					;01
	db $00					;02
	db $00					;03
	db $00					;04
	db $00					;05
	db $00					;06
	db $00					;07
	db $00					;08
	db $00					;09
	db $00					;0A
	db $00					;0B
	db $00					;0C
	db $00					;0D
	db $00					;0E
	db $00					;0F
	db $00					;10
	db $00					;11
	db $00					;12
	db $00					;13
	db $00					;14
	db $00					;15
	db $00					;16
	db $00					;17
	db $00					;18
	db $00					;19
	db $00					;1A
	db $00					;1B
	db $00					;1C
	db $05					;1D Belcha's Barn
	db $05					;1E Arich's Ambush
	db $05					;1F Squirt's Showdown
	db $05					;20 Kaos Karnage
	db $05					;21 Bleak's House
	db $05					;22 Barbos's Barrier
	db $05					;23 Kastle Kaos
	db $00					;24 Knautilus
	db $00					;25 Lakeside Limbo
	db $02					;26 Kreeping Klasps
	db $02					;27 Tidal Trouble
	db $01					;28 Doorstop Dash
	db $02					;29 Squeals on Wheels
	db $04					;2A Murky Mill
	db $03					;2B Skidda's Row
	db $04					;2C Lembuin Lunge
	db $01					;2D Tearaway Toboggan
	db $02					;2E Ripsaw Rage
	db $03					;2F Springin' Spiders
	db $00					;30 Barrel Shield Bust-Up
	db $03					;31 Swoopy Salvo
	db $01					;32 Riverside Race
	db $02					;33 Lightning Lookout
	db $04					;34 Bobbing Barrel Brawl
	db $00					;35 Bazza's Blockade
	db $04					;36 Fish Food Frenzy
	db $02					;37 Floodlit Fish
	db $01					;38 Rocket Barrel Ride
	db $03					;39 Tracker Barrel Trek
	db $02					;3A Barrel Drop Bounce
	db $00					;3B Fireball Frenzy
	db $03					;3C Blazing Bazukas
	db $03					;3D Krackshot Krock
	db $04					;3E Low-G Labyrinth
	db $04					;3F Poisonous Pipeline
	db $01					;40 Demolition Drainpipe
	db $00					;41 Krevice Kreepers
	db $01					;42 Kong-Fused Cliffs
	db $04					;43 Ropey Rumpus
	db $00					;44 Buzzer Barrage
	db $03					;45 Pothole Panic
	db $01					;46 Creepy Caverns
	db $03					;47 Koindozer Klamber
	db $00					;48 Konveyor Rope Klash
	db $00					;49 Stampede Sprint
	db $01					;4A Criss Kross Cliffs
	db $02					;4B Tyrant Twin Tussle
	db $04					;4C Rocket Rush


records_slot_sram_offsets:
	dw $0000				;Slot 1
	dw $01A0				;Slot 2
	dw $0320				;Slot 3
	dw $04A0				;Slot 4
	dw $0620				;Slot 5


records_text_color_table:
	dw $001F
	dw $084A