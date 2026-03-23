build_date:
	db "DKC3 PRAC ASSEMBLY DATE & TIME ", "!timestamp "

hack_version:
	dW $0101				;1.0.1


main_menu_selection_cap_values:
	dw $000B				;Worlds
	dw $0006				;Levels
	dw $0009				;Entrances
	dw $0004				;Kong order
	dw $0002				;Color
	dw $0023				;Songs


main_menu_level_cap_values:
	dw $0006				;World 1
	dw $0006				;World 2
	dw $0006				;World 3
	dw $0006				;World 4
	dw $0006				;World 5
	dw $0006				;World 6
	dw $0006				;World 7
	dw $0006				;World 8
	dw $0006				;Boating
	dw $000D				;Bear Houses
	dw $0006				;Crystal Caves





prac_menu_text:
	dw .prac_menu
	dw !null_pointer

.prac_menu:
	db "PRACTICE MENU", $00


world_text_table:
	dw .lake_orangatanga
	dw .kremwood_forest
	dw .mekanos
	dw .cotton_top_cove
	dw .k3
	dw .razor_ridge
	dw .kaos_kore
	dw .krematoa
	dw .boating
	dw .bear_houses
	dw .crystal_caves

.lake_orangatanga:
	db "LAKE ORANGATANGA", $00

.kremwood_forest:
	db "KREMWOOD FOREST", $00

.cotton_top_cove:
	db "COTTON-TOP COVE", $00

.mekanos:
	db "MEKANOS", $00

.k3:
	db "K3", $00

.razor_ridge:
	db "RAZOR RIDGE", $00

.kaos_kore:
	db "KAOS KORE", $00

.krematoa:
	db "KREMATOA", $00

.boating:
	db "BOATING", $00

.bear_houses:
	db "BEAR HOUSES", $00

.crystal_caves:
	db "CRYSTAL CAVES", $00


level_text_table:
	dw .lakeside_limbo
	dw .doorstop_dash
	dw .tidal_trouble
	dw .skiddas_row
	dw .murky_mill
	dw .belchas_barn

	dw .barrel_shield_bustup
	dw .riverside_race
	dw .squeals_on_wheels
	dw .springin_spiders
	dw .bobbing_barrel_brawl
	dw .arichs_ambush


	dw .fireball_frenzy
	dw .demolition_drainpipe
	dw .ripsaw_rage
	dw .blazing_bazukas
	dw .lowg_labyrinth
	dw .kaos_karnage


	dw .bazzas_blockade
	dw .rocket_barrel_ride
	dw .kreeping_klasps
	dw .tracker_barrel_trek
	dw .fish_food_frenzy
	dw .squirts_showdown


	dw .krevice_kreepers
	dw .tearaway_toboggan
	dw .barrel_drop_bounce
	dw .krackshot_kroc
	dw .lemguin_lunge
	dw .bleaks_house

	dw .buzzer_barrage
	dw .kongfused_cliffs
	dw .floodlit_fish
	dw .pothole_panic
	dw .ropey_rumpus
	dw .barbos_barrier

	dw .konveyor_rope_klash
	dw .creepy_caverns
	dw .lightning_lookout
	dw .koindozer_klamber
	dw .poisonous_pipeline
	dw .kastle_kaos

	dw .stampede_sprint
	dw .criss_kross_cliffs
	dw .tyrant_twin_tussle
	dw .swoopy_salvo
	dw .rocket_rush
	dw .knautilus

	dw .boat_1
	dw .boat_2
	dw .boat_3
	dw .boat_4
	dw .boat_5
	dw .boat_6

	dw .bazaar
	dw .blunder
	dw .bramble
	dw .barter
	dw .barnacle
	dw .brash
	dw .blue
	dw .bazooka
	dw .blizzard
	dw .benny
	dw .bjorn
	dw .baffle
	dw .boomer


	dw .4_inputs
	dw .5_inputs
	dw .6_inputs
	dw .7_inputs
	dw .8_inputs
	dw .9_inputs


 .lakeside_limbo:
	db "LAKESIDE LIMBO", $00

 .doorstop_dash:
	db "DOORSTOP DASH", $00

 .tidal_trouble:
	db "TIDAL TROUBLE", $00

 .skiddas_row:
	db "SKIDDA'S ROW", $00

 .murky_mill:
	db "MURKY MILL", $00

 .belchas_barn:
	db "BELCHA'S BARN", $00




.barrel_shield_bustup:
	db "BARREL S. BUST-UP", $00

.riverside_race:
	db "RIVERSIDE RACE", $00

.squeals_on_wheels:
	db "SQUEALS ON WHEELS", $00

.springin_spiders:
	db "SPRINGIN' SPIDERS", $00

.bobbing_barrel_brawl:
	db "BOBBING B. BRAWL", $00

.arichs_ambush:
	db "ARICH'S AMBUSH", $00



.fireball_frenzy:
	db "FIREBALL FRENZY", $00

.demolition_drainpipe:
	db "DEMOLITION D. PIPE", $00

.ripsaw_rage:
	db "RIPSAW RAGE", $00

.blazing_bazukas:
	db "BLAZING BAZUKAS", $00

.lowg_labyrinth:
	db "LOW-G LABYRINTH", $00

.kaos_karnage:
	db "KAOS KARNAGE", $00



.bazzas_blockade:
	db "BAZZA'S BLOCKADE", $00

.rocket_barrel_ride:
	db "ROCKET BARREL RIDE", $00

.kreeping_klasps:
	db "KREEPING KLASPS", $00

.tracker_barrel_trek:
	db "TRACKER B. TREK", $00

.fish_food_frenzy:
	db "FISH FOOD FRENZY", $00

.squirts_showdown:
	db "SQUIRT'S SHOWDOWN", $00



.krevice_kreepers:
	db "KREVICE KREEPERS", $00

.tearaway_toboggan:
	db "TEARAWAY TOBOGGAN", $00

.barrel_drop_bounce:
	db "BARREL DROP BOUNCE", $00

.krackshot_kroc:
	db "KRACKSHOT KROCK", $00

.lemguin_lunge:
	db "LEMGUIN LUNGE", $00

.bleaks_house:
	db "BLEAK'S HOUSE", $00



.buzzer_barrage:
	db "BUZZER BARRAGE", $00

.kongfused_cliffs:
	db "KONGFUSED CLIFFS", $00

.floodlit_fish:
	db "FLOODLIT FISH", $00

.pothole_panic:
	db "POTHOLE PANIC", $00

.ropey_rumpus:
	db "ROPEY RUMPUS", $00

.barbos_barrier:
	db "BARBOS'S BARRIER", $00




.konveyor_rope_klash:
	db "KONVEYOR R. KLASH", $00

.creepy_caverns:
	db "CREEPY CAVERNS", $00

.lightning_lookout:
	db "LIGHTNING LOOKOUT", $00

.koindozer_klamber:
	db "KOINDOZER KLAMBER", $00

.poisonous_pipeline:
	db "POISONOUS PIPELINE", $00

.kastle_kaos:
	db "KASTLE KAOS", $00




.stampede_sprint:
	db "STAMPEDE SPRINT", $00

.criss_kross_cliffs:
	db "CRISS KROSS CLIFFS", $00

.tyrant_twin_tussle:
	db "TYRANT TWIN TUSSLE", $00

.swoopy_salvo:
	db "SWOOPY SALVO", $00

.rocket_rush:
	db "ROCKET RUSH", $00

.knautilus:
	db "KNAUTILUS", $00



.boat_1:
	db "GAME START", $00

.boat_2:
	db "W2 TO W3", $00

.boat_3:
	db "W4 TO W5", $00

.boat_4:
	db "W8 UNLOCK", $00

.boat_5:
	db "W7 TO W8", $00

.boat_6:
	db "103 CLEANUP", $00




.bazaar:
	db "BAZAAR", $00

.blunder:
	db "BLUNDER", $00

.bramble:
	db "BRAMBLE", $00

.barter:
	db "BARTER", $00

.barnacle:
	db "BARNACLE", $00

.brash:
	db "BRASH", $00

.blue:
	db "BLUE", $00

.bazooka:
	db "BAZOOKA", $00

.blizzard:
	db "BLIZZARD", $00

.benny:
	db "BENNY", $00

.bjorn:
	db "BJORN", $00

.baffle:
	db "BAFFLE", $00

.boomer:
	db "BOOMER", $00




.4_inputs:
	db "4 INPUTS", $00

.5_inputs:
	db "5 INPUTS", $00

.6_inputs:
	db "6 INPUTS", $00

.7_inputs:
	db "7 INPUTS", $00

.8_inputs:
	db "8 INPUTS", $00

.9_inputs:
	db "9 INPUTS", $00



entrance_text_table:
	dw .main					;00
	dw .halfway					;01
	dw .b1						;02
	dw .b2						;03
	dw .b3						;04
	dw .be1						;05
	dw .be2						;06
	dw .be3						;07
	dw .phase1					;08
	dw .phase2					;09
	dw .exit_room					;0A
	dw .visit_1					;0B
	dw .visit_2					;0C
	dw .visit_3					;0D
	dw .50_coins					;0F
	dw .51_coins					;10
	dw .52_coins					;11
	dw .53_coins					;12
	dw .54_coins					;13
	dw .55_coins					;14
	dw .55_coins					;15

.main:
	db "MAIN", $00

.halfway:
	db "HALFWAY", $00

.b1:
	db "BONUS 1", $00

.b2:
	db "BONUS 2", $00

.b3:
	db "BONUS 3", $00

.be1:
	db "BONUS 1 EXIT", $00

.be2:
	db "BONUS 2 EXIT", $00

.be3:
	db "BONUS 3 EXIT", $00

.phase1:
	db "PHASE 1", $00

.phase2:
	db "PHASE 2", $00

.exit_room:
	db "EXIT ROOM", $00

.visit_1:

	db "VISIT 1", $00
.visit_2:

	db "VISIT 2", $00
.visit_3:

	db "VISIT 3", $00

.50_coins:
	db "50 COINS", $00

.51_coins:
	db "51 COINS", $00

.52_coins:
	db "52 COINS", $00

.53_coins:
	db "53 COINS", $00

.54_coins:
	db "54 COINS", $00

.55_coins:
	db "55 COINS", $00



;Used for getting level entrance caps below and text stuff
world_offset_values_table:
	dw $0000
	dw $000C
	dw $0018
	dw $0024
	dw $0030
	dw $003C
	dw $0048
	dw $0054
	dw $0060
	dw $006C
	dw $0086


;How much to subtract from the base entrance cap. Always subtract max from boss levels except K.Rool 1
entrance_cap_table:

;Lake Orangatanga
	dw $0004        		;Lakeside Limbo          2 Bonuses
	dw $0004        		;Doorstop Dash       	 2 Bonuses
	dw $0004        		;Tidal Trouble	         2 Bonuses
	dw $0004        		;Skidda's Row	         2 Bonuses
	dw $0004        		;Murky Mill		 2 Bonuses
	dw $0009        		;Belcha's Barn
	dw !null_pointer

;Kremwood Forest
	dw $0004       			;Barrel Shield Bust-up   2 Bonuses
	dw $0004       			;Riverside Race       	 2 Bonuses
	dw $0004       			;Squeals on Wheels       2 Bonuses
	dw $0004       			;Springin' Spiders       2 Bonuses
	dw $0004       			;Bobbing Barrel Brawl    2 Bonuses
	dw $0009       			;Necky's Nuts
	dw !null_pointer

;Mekanos
	dw $0004        		;Fireball Frenzy         2 Bonuses
	dw $0004        		;Demolition Drainpipe    2 Bonuses
	dw $0004        		;Ripsaw Rage      	 2 Bonuses
	dw $0004        		;Blazing Bazukas         2 Bonuses
	dw $0004        		;Low-G Labyrinth         2 Bonuses
	dw $0009        		;Kaos Karnage
	dw !null_pointer

;Cotton-Top Cove
	dw $0003        		;Bazza's Blockade        2 Bonuses, Exit Room
	dw $0004        		;Rocket Barrel Ride	 2 Bonuses
	dw $0004        		;Kreeping Klasps	 2 Bonuses
	dw $0004        		;Tracker Barrel Tek      2 Bonuses
	dw $0003        		;Fish Food Frenzy        2 Bonuses, Exit Room
	dw $0009        		;Squirt's Showdown
	dw !null_pointer

;K3
	dw $0004        		;Krevice Kreepers        2 Bonuses
	dw $0004        		;Tearaway Toboggan       2 Bonuses
	dw $0004        		;Barrel Drop Bounce      2 Bonuses
	dw $0004        		;Krackshot Kroc     	 2 Bonuses
	dw $0004        		;Lemguin Lunge           2 Bonuses
	dw $0009        		;Bleak's House
	dw !null_pointer

;Razor Ridge
	dw $0004        		;Buzzer Barrage          2 Bonuses
	dw $0004        		;Kongfused Cliffs        2 Bonuses
	dw $0003        		;Floodlit Fish	         2 Bonuses, Exit Room
	dw $0004        		;Pot Hole Panic      	 2 Bonuses
	dw $0004        		;Ropey Rumpus     	 2 Bonuses
	dw $0009			;Barbos's Barrier
	dw !null_pointer

;Kaos Kore
	dw $0004        		;Konveyor Rope Klash     2 Bonuses
	dw $0004        		;Creepy Caverns          2 Bonuses
	dw $0004        		;Lightning Lookout	 2 Bonuses
	dw $0004        		;Koindozer Klamber     	 2 Bonuses
	dw $0004        		;Poisonous Pipeline  	 2 Bonuses
	dw $0008			;Kastle Kaos
	dw !null_pointer

;Krematoa
	dw $0002        		;Stampede Sprint         3 Bonuses
	dw $0004        		;Criss Kross Cliffs      2 Bonuses
	dw $0002        		;Tyrant Twin Tussle	 3 Bonuses
	dw $0002        		;Swoopy Salvo     	 3 Bonuses
	dw $0008        		;Rocket Rush
	dw $0009			;Knautilus
	dw !null_pointer

;Boating
	dw $0009
	dw $0009
	dw $0009
	dw $0009
	dw $0009
	dw $0009
	dw !null_pointer

;Bear Houses
	dw $0004			;Bazaar
	dw $0009			;Blunder
	dw $0009			;Bramble
	dw $0009			;Barter
	dw $0009			;Barnacle
	dw $0009			;Brash
	dw $0009			;Blue
	dw $0009			;Bazooka
	dw $0009			;Blizzard
	dw $0009			;Benny
	dw $0009			;Bjorn
	dw $0009			;Baffle
	dw $0007			;Boomer
	dw !null_pointer

;Crystal Caves
	dw $0009
	dw $0009
	dw $0009
	dw $0009
	dw $0009
	dw $0009
	dw !null_pointer


level_entrances_table:
	dw .lakeside_limbo_entrances
	dw .doorstop_dash_entrances
	dw .tidal_trouble_entrances
	dw .skiddas_row_entrances
	dw .murky_mill_entrances
	dw .belchas_barn_entrances


	dw .barrel_shield_bustup_entrances
	dw .riverside_race_entrances
	dw .squeals_on_wheels_entrances
	dw .springin_spiders_entrances
	dw .bobbing_barrel_brawl_entrances
	dw .arichs_ambush_entrances


	dw .fireball_frenzy_entrances
	dw .demolition_drainpipe_entrances
	dw .ripsaw_rage_entrances
	dw .blazing_bazukas_entrances
	dw .lowg_labyrinth_entrances
	dw .kaos_karnage_entrances


	dw .bazzas_blockade_entrances
	dw .rocket_barrel_ride_entrances
	dw .kreeping_klasps_entrances
	dw .tracker_barrel_trek_entrances
	dw .fish_food_frenzy_entrances
	dw .squirts_showdown_entrances


	dw .krevice_kreepers_entrances
	dw .tearaway_toboggan_entrances
	dw .barrel_drop_bounce_entrances
	dw .krackshot_kroc_entrances
	dw .lemguin_lunge_entrances
	dw .bleaks_house_entrances


	dw .buzzer_barrage_entrances
	dw .kongfused_cliffs_entrances
	dw .floodlit_fish_entrances
	dw .pothole_panic_entrances
	dw .ropey_rumpus_entrances
	dw .barbos_barrier_entrances


	dw .konveyor_rope_klash_entrances
	dw .creepy_caverns_entrances
	dw .lightning_lookout_entrances
	dw .koindozer_klamber_entrances
	dw .poisonous_pipeline_entrances
	dw .kastle_kaos_entrances


	dw .stampede_sprint_entrances
	dw .criss_kross_cliffs_entrances
	dw .tyrant_twin_tussle_entrances
	dw .swoopy_salvo_entrances
	dw .rocket_rush_entrances
	dw .knautilus_entrances


;Boating
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance


;Bear Houses
	dw .bazaar_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances
	dw .boomer_entrances


;Crystal Caves
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance
	dw .dummy_entrance



;Level number + entrance number, index for animal setup routine, pre-ASL'd index to text pointer table
;Animal indexes: 00 = None, 2 = Ellie, 4 = Enguarde, 6 = Squitter, 8 = Squawks (x2 if should be mounted instead)
.lakeside_limbo_entrances:
	dw !level_lakeside_limbo|$0000 	 		: db $00 : db $00	;Main level
	dw !level_lakeside_limbo|$0100			: db $00 : db $02	;Halfway
	dw !level_lakeside_limbo_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_lakeside_limbo_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_lakeside_limbo|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_lakeside_limbo|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.doorstop_dash_entrances:
	dw !level_doorstop_dash|$0000 	 		: db $00 : db $00	;Main level
	dw !level_doorstop_dash|$0100			: db $00 : db $02	;Halfway
	dw !level_doorstop_dash_bonus_1|$0000 		: db $00 : db $04	;Bonus 1
	dw !level_doorstop_dash_bonus_2|$0000  		: db $00 : db $06	;Bonus 2
	dw !level_doorstop_dash|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_doorstop_dash|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.tidal_trouble_entrances:
	dw !level_tidal_trouble|$0000 	 		: db $00 : db $00	;Main level
	dw !level_tidal_trouble|$0100			: db $00 : db $02	;Halfway
	dw !level_tidal_trouble_bonus_1|$0000  		: db $04 : db $04	;Bonus 1
	dw !level_tidal_trouble_bonus_2|$0000  		: db $00 : db $06	;Bonus 2
	dw !level_tidal_trouble|$0200 	 		: db $04 : db $0A	;Bonus 1 Exit
	dw !level_tidal_trouble|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.skiddas_row_entrances:
	dw !level_skiddas_row|$0000 	 		: db $00 : db $00	;Main level
	dw !level_skiddas_row|$0100			: db $00 : db $02	;Halfway
	dw !level_skiddas_row_bonus_1|$0000  		: db $00 : db $04	;Bonus 1
	dw !level_skiddas_row_bonus_2|$0000  		: db $00 : db $06	;Bonus 2
	dw !level_skiddas_row|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_skiddas_row|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.murky_mill_entrances:
	dw !level_murky_mill|$0000 	 		: db $00 : db $00	;Main level
	dw !level_murky_mill|$0100			: db $02 : db $02	;Halfway
	dw !level_murky_mill_bonus_1|$0000  		: db $02 : db $04	;Bonus 1
	dw !level_murky_mill_bonus_2|$0000  		: db $02 : db $06	;Bonus 2
	dw !level_murky_mill|$0200 	 		: db $02 : db $0A	;Bonus 1 Exit
	dw !level_murky_mill|$0300 	 		: db $02 : db $0C	;Bonus 2 Exit

.belchas_barn_entrances:
	dw !level_belchas_barn|$0000 	 		: db $00 : db $00	;Main level





.barrel_shield_bustup_entrances:
	dw !level_barrel_shield_bust_up|$0000 	 	: db $00 : db $00	;Main level
	dw !level_barrel_shield_bust_up|$0100		: db $00 : db $02	;Halfway
	dw !level_barrel_shield_bust_up_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_barrel_shield_bust_up_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_barrel_shield_bust_up|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_barrel_shield_bust_up|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.riverside_race_entrances:
	dw !level_riverside_race|$0000 	 		: db $00 : db $00	;Main level
	dw !level_riverside_race|$0100			: db $00 : db $02	;Halfway
	dw !level_riverside_race_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_riverside_race_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_riverside_race|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_riverside_race|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.squeals_on_wheels_entrances:
	dw !level_squeals_on_wheels|$0000 	 	: db $00 : db $00	;Main level
	dw !level_squeals_on_wheels|$0100		: db $00 : db $02	;Halfway
	dw !level_squeals_on_wheels_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_squeals_on_wheels_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_squeals_on_wheels|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_squeals_on_wheels|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit


.springin_spiders_entrances:
	dw !level_springin_spiders|$0000 	 	: db $00 : db $00	;Main level
	dw !level_springin_spiders|$0100		: db $00 : db $02	;Halfway
	dw !level_springin_spiders_bonus_1|$0000  	: db $06 : db $04	;Bonus 1
	dw !level_springin_spiders_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_springin_spiders|$0200 	 	: db $06 : db $0A	;Bonus 1 Exit
	dw !level_springin_spiders|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.bobbing_barrel_brawl_entrances:
	dw !level_bobbing_barrel_brawl|$0000 	 	: db $00 : db $00	;Main level
	dw !level_bobbing_barrel_brawl|$0100		: db $02 : db $02	;Halfway
	dw !level_bobbing_barrel_brawl_bonus_1|$0000  	: db $02 : db $04	;Bonus 1
	dw !level_bobbing_barrel_brawl_bonus_2|$0000  	: db $02 : db $06	;Bonus 2
	dw !level_bobbing_barrel_brawl|$0200 	 	: db $02 : db $0A	;Bonus 1 Exit
	dw !level_bobbing_barrel_brawl|$0300 	 	: db $02 : db $0C	;Bonus 2 Exit

.arichs_ambush_entrances:
	dw !level_arichs_ambush|$0000 	 		: db $00 : db $00	;Main level




.fireball_frenzy_entrances:
	dw !level_fireball_frenzy|$0000 	 	: db $00 : db $00	;Main level
	dw !level_fireball_frenzy|$0100			: db $00 : db $02	;Halfway
	dw !level_fireball_frenzy_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_fireball_frenzy_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_fireball_frenzy|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_fireball_frenzy|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.demolition_drainpipe_entrances:
	dw !level_demolition_drainpipe|$0000 	 	: db $00 : db $00	;Main level
	dw !level_demolition_drainpipe|$0100		: db $00 : db $02	;Halfway
	dw !level_demolition_drainpipe_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_demolition_drainpipe_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_demolition_drainpipe|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_demolition_drainpipe|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.ripsaw_rage_entrances:
	dw !level_ripsaw_rage|$0000 	 		: db $00 : db $00	;Main level
	dw !level_ripsaw_rage|$0100			: db $00 : db $02	;Halfway
	dw !level_ripsaw_rage_bonus_1|$0000  		: db $00 : db $04	;Bonus 1
	dw !level_ripsaw_rage_bonus_2|$0000  		: db $00 : db $06	;Bonus 2
	dw !level_ripsaw_rage|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_ripsaw_rage|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.blazing_bazukas_entrances:
	dw !level_blazing_bazukas|$0000 	 	: db $00 : db $00	;Main level
	dw !level_blazing_bazukas|$0100			: db $00 : db $02	;Halfway
	dw !level_blazing_bazukas_bonus_1|$0000  	: db $08 : db $04	;Bonus 1
	dw !level_blazing_bazukas_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_blazing_bazukas|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_blazing_bazukas|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.lowg_labyrinth_entrances:
	dw !level_low_g_labyrinth|$0000 	 	: db $00 : db $00	;Main level
	dw !level_low_g_labyrinth|$0100			: db $00 : db $02	;Halfway
	dw !level_low_g_labyrinth_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_low_g_labyrinth_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_low_g_labyrinth|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_low_g_labyrinth|$0300 	 	: db $06 : db $0C	;Bonus 2 Exit

.kaos_karnage_entrances:
	dw !level_kaos_karnage|$0000 	 		: db $00 : db $00	;Main level




.bazzas_blockade_entrances:
	dw !level_bazzas_blockade|$0000 	 	: db $00 : db $00	;Main level
	dw !level_bazzas_blockade|$0100			: db $00 : db $02	;Halfway
	dw !level_bazzas_blockade_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_bazzas_blockade_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_bazzas_blockade|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_bazzas_blockade|$0300 	 	: db $04 : db $0C	;Bonus 2 Exit
	dw !level_bazzas_blockade_exit_room|$0000 	: db $00 : db $14	;Exit Room

.rocket_barrel_ride_entrances:
	dw !level_rocket_barrel_ride|$0000 	 	: db $00 : db $00	;Main level
	dw !level_rocket_barrel_ride|$0100		: db $00 : db $02	;Halfway
	dw !level_rocket_barrel_ride_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_rocket_barrel_ride_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_rocket_barrel_ride|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_rocket_barrel_ride|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.kreeping_klasps_entrances:
	dw !level_kreeping_klasps|$0000 	 	: db $00 : db $00	;Main level
	dw !level_kreeping_klasps|$0100			: db $00 : db $02	;Halfway
	dw !level_kreeping_klasps_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_kreeping_klasps_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_kreeping_klasps|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_kreeping_klasps|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.tracker_barrel_trek_entrances:
	dw !level_tracker_barel_trek|$0000 	 	: db $00 : db $00	;Main level
	dw !level_tracker_barel_trek|$0100		: db $00 : db $02	;Halfway
	dw !level_tracker_barel_trek_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_tracker_barel_trek_bonus_2|$0000  	: db $02 : db $06	;Bonus 2
	dw !level_tracker_barel_trek|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_tracker_barel_trek|$0300 	 	: db $02 : db $0C	;Bonus 2 Exit

.fish_food_frenzy_entrances:
	dw !level_fish_food_frenzy|$0000 	 	: db $00 : db $00	;Main level
	dw !level_fish_food_frenzy|$0100		: db $00 : db $02	;Halfway
	dw !level_fish_food_frenzy_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_fish_food_frenzy_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_fish_food_frenzy|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_fish_food_frenzy|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit
	dw !level_fish_food_frenzy_exit_room|$0000  	: db $00 : db $14	;Exit Room

.squirts_showdown_entrances:
	dw !level_squirts_showdown|$0000 	 	: db $00 : db $00	;Main level




.krevice_kreepers_entrances:
	dw !level_krevice_kreepers|$0000 	 	: db $00 : db $00	;Main level
	dw !level_krevice_kreepers|$0100		: db $00 : db $02	;Halfway
	dw !level_krevice_kreepers_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_krevice_kreepers_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_krevice_kreepers|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_krevice_kreepers|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.tearaway_toboggan_entrances:
	dw !level_tearaway_toboggan|$0000 	 	: db $00 : db $00	;Main level
	dw !level_tearaway_toboggan|$0100		: db $00 : db $02	;Halfway
	dw !level_tearaway_toboggan_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_tearaway_toboggan_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_tearaway_toboggan|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_tearaway_toboggan|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.barrel_drop_bounce_entrances:
	dw !level_barrel_drop_bounce|$0000 	 	: db $00 : db $00	;Main level
	dw !level_barrel_drop_bounce|$0100		: db $00 : db $02	;Halfway
	dw !level_barrel_drop_bounce_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_barrel_drop_bounce_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_barrel_drop_bounce|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_barrel_drop_bounce|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.krackshot_kroc_entrances:
	dw !level_krackshot_krock|$0000 	 	: db $00 : db $00	;Main level
	dw !level_krackshot_krock|$0100			: db $08 : db $02	;Halfway
	dw !level_krackshot_krock_bonus_1|$0000  	: db $08 : db $04	;Bonus 1
	dw !level_krackshot_krock_bonus_2|$0000  	: db $08 : db $06	;Bonus 2
	dw !level_krackshot_krock|$0200 	 	: db $08 : db $0A	;Bonus 1 Exit
	dw !level_krackshot_krock|$0300 	 	: db $08 : db $0C	;Bonus 2 Exit

.lemguin_lunge_entrances:
	dw !level_lemguin_lunge|$0000 	 		: db $00 : db $00	;Main level
	dw !level_lemguin_lunge|$0100			: db $00 : db $02	;Halfway
	dw !level_lemguin_lunge_bonus_1|$0000  		: db $00 : db $04	;Bonus 1
	dw !level_lemguin_lunge_bonus_2|$0000  		: db $00 : db $06	;Bonus 2
	dw !level_lemguin_lunge|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_lemguin_lunge|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.bleaks_house_entrances:
	dw !level_bleaks_house|$0000 	 		: db $00 : db $00	;Main level




.buzzer_barrage_entrances:
	dw !level_buzzer_barrage|$0000 	 		: db $00 : db $00	;Main level
	dw !level_buzzer_barrage|$0100			: db $06 : db $02	;Halfway
	dw !level_buzzer_barrage_bonus_1|$0000  	: db $06 : db $04	;Bonus 1
	dw !level_buzzer_barrage_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_buzzer_barrage|$0200 	 		: db $06 : db $0A	;Bonus 1 Exit
	dw !level_buzzer_barrage|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.kongfused_cliffs_entrances:
	dw !level_kongfused_cliffs|$0000 	 	: db $00 : db $00	;Main level
	dw !level_kongfused_cliffs|$0100		: db $00 : db $02	;Halfway
	dw !level_kongfused_cliffs_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_kongfused_cliffs_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_kongfused_cliffs|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_kongfused_cliffs|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.floodlit_fish_entrances:
	dw !level_floodlit_fish|$0000 	 		: db $00 : db $00	;Main level
	dw !level_floodlit_fish|$0100			: db $04 : db $02	;Halfway
	dw !level_floodlit_fish_bonus_1|$0000  		: db $04 : db $04	;Bonus 1
	dw !level_floodlit_fish_bonus_2|$0000  		: db $04 : db $06	;Bonus 2
	dw !level_floodlit_fish|$0200 	 		: db $04 : db $0A	;Bonus 1 Exit
	dw !level_floodlit_fish|$0300 	 		: db $04 : db $0C	;Bonus 2 Exit
	dw !level_floodlit_fish_exit_room|$0000		: db $00 : db $14	;Exit Room

.pothole_panic_entrances:
	dw !level_pothole_panic|$0000 	 		: db $00 : db $00	;Main level
	dw !level_pothole_panic|$0100			: db $00 : db $02	;Halfway
	dw !level_pothole_panic_bonus_1|$0000  		: db $00 : db $04	;Bonus 1
	dw !level_pothole_panic_bonus_2|$0000  		: db $08 : db $06	;Bonus 2
	dw !level_pothole_panic|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_pothole_panic|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.ropey_rumpus_entrances:
	dw !level_ropey_rumpus|$0000 	 		: db $00 : db $00	;Main level
	dw !level_ropey_rumpus|$0100			: db $00 : db $02	;Halfway
	dw !level_ropey_rumpus_bonus_1|$0000  		: db $00 : db $04	;Bonus 1
	dw !level_ropey_rumpus_bonus_2|$0000  		: db $00 : db $06	;Bonus 2
	dw !level_ropey_rumpus|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_ropey_rumpus|$0300 	 		: db $00 : db $0C	;Bonus 2 Exit

.barbos_barrier_entrances:
	dw !level_barbos_barrier|$0000 	 		: db $00 : db $00	;Main level






.konveyor_rope_klash_entrances:
	dw !level_konveyor_rope_klash|$0000 	 	: db $00 : db $00	;Main level
	dw !level_konveyor_rope_klash|$0100		: db $00 : db $02	;Halfway
	dw !level_konveyor_rope_klash_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_konveyor_rope_klash_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_konveyor_rope_klash|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_konveyor_rope_klash|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.creepy_caverns_entrances:
	dw !level_creepy_caverns|$0000 	 		: db $00 : db $00	;Main level
	dw !level_creepy_caverns|$0100			: db $00 : db $02	;Halfway
	dw !level_creepy_caverns_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_creepy_caverns_bonus_2|$0000  	: db $08 : db $06	;Bonus 2
	dw !level_creepy_caverns|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_creepy_caverns|$0300 	 		: db $08 : db $0C	;Bonus 2 Exit

.lightning_lookout_entrances:
	dw !level_lightning_lookout|$0000 	 	: db $00 : db $00	;Main level
	dw !level_lightning_lookout|$0100		: db $00 : db $02	;Halfway
	dw !level_lightning_lookout_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_lightning_lookout_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_lightning_lookout|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_lightning_lookout|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.koindozer_klamber_entrances:
	dw !level_koindozer_klamber|$0000 	 	: db $00 : db $00	;Main level
	dw !level_koindozer_klamber|$0100		: db $00 : db $02	;Halfway
	dw !level_koindozer_klamber_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_koindozer_klamber_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_koindozer_klamber|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_koindozer_klamber|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.poisonous_pipeline_entrances:
	dw !level_poisonous_pipeline|$0000 	 	: db $00 : db $00	;Main level
	dw !level_poisonous_pipeline|$0100		: db $00 : db $02	;Halfway
	dw !level_poisonous_pipeline_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_poisonous_pipeline_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_poisonous_pipeline|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_poisonous_pipeline|$0300 	 	: db $04 : db $0C	;Bonus 2 Exit

.kastle_kaos_entrances:
	dw !level_kastle_kaos|$0000 	 		: db $00 : db $10	;Main level
	dw !level_kastle_kaos|$0100			: db $00 : db $12	;Halfway




.stampede_sprint_entrances:
	dw !level_stampede_sprint|$0000 	 	: db $00 : db $00	;Main level
	dw !level_stampede_sprint|$0100			: db $00 : db $02	;Halfway
	dw !level_stampede_sprint_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_stampede_sprint_bonus_2|$0000  	: db $88 : db $06	;Bonus 2
	dw !level_stampede_sprint_bonus_3|$0000  	: db $02 : db $08	;Bonus 3
	dw !level_stampede_sprint|$0200 	 	: db $88 : db $0A	;Bonus 1 Exit
	dw !level_stampede_sprint|$0200 	 	: db $88 : db $0C	;Bonus 2 Exit
	dw !level_stampede_sprint|$0300 	 	: db $02 : db $0E	;Bonus 3 Exit

.criss_kross_cliffs_entrances:
	dw !level_criss_kross_cliffs|$0000 	 	: db $00 : db $00	;Main level
	dw !level_criss_kross_cliffs|$0100		: db $00 : db $02	;Halfway
	dw !level_criss_kross_cliffs_bonus_1|$0000  	: db $00 : db $04	;Bonus 1
	dw !level_criss_kross_cliffs_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_criss_kross_cliffs|$0200 	 	: db $00 : db $0A	;Bonus 1 Exit
	dw !level_criss_kross_cliffs|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit

.tyrant_twin_tussle_entrances:
	dw !level_tyrant_twin_tussle|$0000 	 	: db $00 : db $00	;Main level
	dw !level_tyrant_twin_tussle|$0100		: db $00 : db $02	;Halfway
	dw !level_tyrant_twin_tussle_bonus_1|$0000  	: db $08 : db $04	;Bonus 1
	dw !level_tyrant_twin_tussle_bonus_2|$0000  	: db $00 : db $06	;Bonus 2
	dw !level_tyrant_twin_tussle_bonus_3|$0000  	: db $00 : db $08	;Bonus 3
	dw !level_tyrant_twin_tussle|$0200 	 	: db $08 : db $0A	;Bonus 1 Exit
	dw !level_tyrant_twin_tussle|$0300 	 	: db $00 : db $0C	;Bonus 2 Exit
	dw !level_tyrant_twin_tussle|$0400 	 	: db $00 : db $0E	;Bonus 3 Exit

.swoopy_salvo_entrances:
	dw !level_swoopy_salvo|$0000 	 		: db $00 : db $00	;Main level
	dw !level_swoopy_salvo|$0000			: db $00 : db $02	;Halfway
	dw !level_swoopy_salvo_bonus_1|$0000  		: db $06 : db $04	;Bonus 1
	dw !level_swoopy_salvo_bonus_2|$0000  		: db $06 : db $06	;Bonus 2
	dw !level_swoopy_salvo_bonus_3|$0000  		: db $00 : db $08	;Bonus 3
	dw !level_swoopy_salvo|$0200 	 		: db $00 : db $0A	;Bonus 1 Exit
	dw !level_swoopy_salvo|$0300 	 		: db $06 : db $0C	;Bonus 2 Exit
	dw !level_swoopy_salvo|$0400 	 		: db $00 : db $0E	;Bonus 3 Exit

.rocket_rush_entrances:
	dw !level_rocket_rush|$0000 	 		: db $00 : db $00	;Main level
	dw !level_rocket_rush|$0100			: db $00 : db $02	;Halfway


.knautilus_entrances:
	dw !level_knautilus|$0000 	 		: db $00 : db $00	;Main level




;Dialogue/item flags to set, bear coin count
.bazaar_entrances:
	dw !null_pointer|$0000 	 			: db $00 : db $1C	;50 Coins
	dw !null_pointer|$0000 	 			: db $00 : db $1E	;51 Coins
	dw !null_pointer|$0000 	 			: db $00 : db $20	;52 Coins
	dw !null_pointer|$0000 	 			: db $00 : db $22	;53 Coins
	dw !null_pointer|$0000 	 			: db $00 : db $24	;54 Coins
	dw !null_pointer|$0000 	 			: db $00 : db $26	;55 Coins


.boomer_entrances:
	dw !null_pointer|$0000 	 			: db $00 : db $16	;Visit 1
	dw !null_pointer|$0000 	 			: db $00 : db $18	;Visit 2
	dw !null_pointer|$0000 	 			: db $00 : db $1A	;Visit 3


.dummy_entrance:
	dw !null_pointer|$0000 	 			: db $00 : db $00	;Main level




;Bear coin count, bonus coin count, gear count, boomer explosive count...
;...player item flags, bear dialogue/item availability flags.

;Item bits:
;	01 = Patch
; 	02 = Ski
; 	04 = Shell
; 	08 = Mirror
; 	10 = Present
; 	20 = Cannonball
; 	40 = Flower
; 	80 = Wrench

bear_setup_table:
	dw .bazaar
	dw .blunder
	dw .bramble
	dw .barter
	dw .barnacle
	dw .brash
	dw .blue
	dw .bazooka
	dw .blizzard
	dw .benny
	dw .bjorn
	dw .baffle
	dw .boomer


.bazaar:
	db $32, $00, $00, $00, $00 : dw $000C		;50 Bear Coins
	db $33, $00, $00, $00, $00 : dw $000C		;51 Bear Coins
	db $34, $00, $00, $00, $00 : dw $000C		;52 Bear Coins
	db $35, $00, $00, $00, $00 : dw $000C		;53 Bear Coins
	db $36, $00, $00, $00, $00 : dw $000C		;54 Bear Coins
	db $37, $00, $00, $00, $00 : dw $000C		;55 Bear Coins


.blunder:
	db $00, $00, $00, $00, $01 : dw $0000		;Visit 1

.bramble:
	db $00, $00, $00, $00, $40 : dw $0000		;Visit 1

.barter:
	db $00, $00, $00, $00, $08 : dw $0080		;Visit 1

.barnacle:
	db $00, $00, $00, $00, $04 : dw $0000		;Visit 1

.brash:
	db $00, $00, $00, $00, $00 : dw $0000		;Visit 1

.blue:
	db $00, $00, $00, $00, $10 : dw $0020		;Visit 1

.bazooka:
	db $00, $00, $00, $00, $20 : dw $0000		;Visit 1

.blizzard:
	db $00, $00, $00, $00, $00 : dw $0010		;Visit 1

.benny:
	db $00, $00, $00, $00, $00 : dw $0000		;Visit 1

.bjorn:
	db $00, $00, $00, $00, $80 : dw $0000		;Visit 1

.baffle:
	db $00, $00, $00, $00, $00 : dw $0000		;Visit 1

.boomer:
	db $00, $4A, $00, $00, $00 : dw $0000		;Visit 1
	db $00, $2E, $00, $04, $00 : dw $8200		;Visit 2
	db $00, $20, $05, $04, $00 : dw $8000		;Visit 3




;World number, current vehicle, map node number, returning node number, items in posession, slot 1 item, slot 2 item...
;... $05FB flags, $05FD flags, funky's rentals flags...
;... docked vehicle X/Y positions.
;... specific bs setup routine

;Item bits:
;	01 = Patch
; 	02 = Ski
; 	04 = Shell
; 	08 = Mirror
; 	10 = Present
; 	20 = Cannonball
; 	40 = Flower
; 	80 = Wrench

world_map_setup_table:
	dw .game_start
	dw .w2_to_w3
	dw .w4_to_w5
	dw .w8_unlock
	dw .w7_to_w8
	dw .103_cleanup

.game_start:
	db !world_northern_kremisphere, !vehicle_motorboat, $00, $00, $00, $00, $00
	dw $0000, $0000, $0400
	dw $0000, $0000
	dw set_game_start_map_stuff

.w2_to_w3:
	db !world_northern_kremisphere, !vehicle_motorboat, $05, $05, $01, $01, $00
	dw $0407, $8832, $8400
	dw $0286, $02DF
	dw set_w2_to_w3_map_stuff

.w4_to_w5:
	db !world_northern_kremisphere, !vehicle_hovercraft, $07, $07, $02, $02, $00
	dw $0407, $8832, $8C00
	dw $01CC, $0200
	dw set_w4_to_w5_map_stuff

.w8_unlock:
	db !world_northern_kremisphere, !vehicle_turbo_ski, $07, $07, $10, $10, $00
	dw $0407, $8832, $9C40
	dw $01D0, $0200
	dw set_w8_unlock_map_stuff

.w7_to_w8:
	db !world_kaos_kore, !vehicle_turbo_ski, $09, $0D, $24, $04, $20
	dw $0407, $8832, $9C40
	dw $0290, $0148
	dw set_w7_to_w8_map_stuff

.103_cleanup:
	db !world_krematoa, !vehicle_turbo_ski, $08, $0E, $24, $04, $20
	dw $0407, $8932, $9C40
	dw $02AA, $0220
	dw set_103_cleanup_map_stuff



crystal_cave_bird_counts:
	db $00, $01, $04, $07, $0B, $0E



color_numbers_table:
	dw .one
	dw .two

.one:
	db "1", $00

.two:
	db "2", $00



song_text_table:
	dw .main_theme
	dw .select
	dw .caves
	dw .water
	dw .mountains
	dw .jungle
	dw .factory
	dw .mill
	dw .riverbank
	dw .snow
	dw .pier
	dw .trees
	dw .pipes
	dw .waterfall
	dw .boss
	dw .krool
	dw .bonus
	dw .fanfare
	dw .funky
	dw .wrinkly_1
	dw .wrinkly_2
	dw .wrinkly_3
	dw .swanky_1
	dw .swanky_2
	dw .bear_in
	dw .main_map
	dw .submap
	dw .krematoa
	dw .race
	dw .crystal
	dw .rocket
	dw .album
	dw .gameover
	dw .xmas
	dw .mama_bird



.main_theme:
	db "MAIN THEME", $00

.select:
	db "SELECT", $00

.caves:
	db "CAVES", $00

.water:
	db "WATER", $00

.mountains:
	db "MOUNTAINS", $00

.jungle:
	db "JUNGLE", $00

.factory:
	db "FACTORY", $00

.mill:
	db "MILL", $00

.riverbank:
	db "RIVERBANK", $00

.snow:
	db "SNOW", $00

.pier:
	db "PIER", $00

.trees:
	db "TREES", $00

.pipes:
	db "PIPES", $00

.waterfall:
	db "WATERFALL", $00

.boss:
	db "BOSS", $00

.krool:
	db "K.ROOL", $00

.bonus:
	db "BONUS", $00

.fanfare:
	db "FANFARE", $00

.funky:
	db "FUNKY", $00

.wrinkly_1:
	db "WRINKLY 1", $00

.wrinkly_2:
	db "WRINKLY 2", $00

.wrinkly_3:
	db "WRINKLY 3", $00

.swanky_1:
	db "SWANKY 1", $00

.swanky_2:
	db "SWANKY 2", $00

.bear_in:
	db "BEAR IN", $00

.main_map:
	db "MAIN MAP", $00

.submap:
	db "SUBMAP", $00

.krematoa:
	db "KREMATOA", $00

.race:
	db "RACE", $00

.crystal:
	db "CRYSTAL", $00

.rocket:
	db "ROCKET", $00

.album:
	db "ALBUM", $00

.gameover:
	db "GAMEOVER", $00

.xmas:
	db "XMAS", $00

.mama_bird:
	db "MAMA BIRD", $00




font_tile_offsets:
	db $26, $28, $2A, $2B, $2C, $2D, $1A, $2F
	db $30, $31, $32, $26, $22, $1E, $29, $03
	db $07, $0B, $0F, $13, $17, $1B, $1F, $23
	db $27, $33, $34, $35, $36, $37, $2E, $38
	db $00, $04, $08, $0C, $10, $14, $18, $1C
	db $20, $24, $01, $05, $09, $0D, $11, $15
	db $19, $1D, $21, $25, $02, $06, $0A, $0E
	db $12, $16
