include

function bank_word(addr) = ((addr&$FFFF)<<8)|(addr>>16)
function fake(addr) = addr
function sound(channel, effect) = channel<<8|effect


macro offset(label, offset)
	?tmp:
	pushpc
	org ?tmp+<offset>
	<label>:
	pullpc
endmacro


macro return(label)
	PEA <label>-1
endmacro


macro pea_use_dbr(label)
	?dummy:
	PEA.w (<:?dummy<<8)|<:<label>
endmacro


macro pea_shift_dbr(label)
	PEA.w <label>>>8
endmacro


macro pea_mask_dbr(label)
	PEA.w <label>>>8&$FF00
endmacro


macro pea_engine_dbr()
	PEA.w $8080
endmacro



macro pea_mirror_dbr()
	?dummy:
	PEA.w (<:?dummy<<8|$4000)|$80
endmacro


macro local(name, scratch)
	pushpc
		org <scratch>
			<name>:
	pullpc
endmacro


macro vram_payload(data_address, vram_address, data_size, compression_type)
	dl bank_word((<data_address>&$3FFFFF)|(<compression_type><<22))
	dw <vram_address>
	dw <data_size>
endmacro


macro dma_to_vram(vram_address, data_address)
	LDA #<vram_address>
	STA PPU.vram_address
	LDX.w #<data_address>>>16
	LDA #<data_address>
	LDY #datasize(<data_address>)
	JSL DMA_to_VRAM
endmacro


macro dma_bg(tile_vram_addr, tile_addr, ...)
	LDA #<tile_vram_addr>
	STA PPU.vram_address
	LDX.w #<tile_addr>>>16
	LDA #<tile_addr>
	LDY #datasize(<tile_addr>)
	JSL DMA_to_VRAM

if sizeof(...) > 0
	LDA #<...[0]>				;<map_vram_addr>
	STA PPU.vram_address
	LDX.w #<...[1]> >>16			;<map_addr>>>16
	LDA #<...[1]>				;<map_addr>
	LDY #datasize(<...[1]>)			;datasize(<map_addr>)
	JSL DMA_to_VRAM
endif

if sizeof(...) > 2
 	LDY #<...[2]>				;<pal_cg_addr>
 	LDA #<...[3]>				;<pal_addr>
 	LDX #datasize(<...[3]>)			;datasize(<pal_addr>)
 	JSL DMA_palette
 endif
endmacro



;Rare is an evil company and decided to shift RAM addresses forward in J versions
macro conditional_ram_byte(instruction, address)
if !version == !us
	 <instruction>.b <address>
else
	<instruction>.b <address>+$6
endif
endmacro


macro conditional_ram_word(instruction, address)
if !version == !us
	 <instruction>.w <address>
else
	<instruction>.w <address>+$6
endif
endmacro


macro conditional_ram_word_idx(instruction, address, idx)
if !version == !us
	 <instruction>.w <address>, <idx>
else
	<instruction>.w <address>+$6,<idx>
endif
endmacro


macro conditional_ram_long(instruction, address)
if !version == !us
	 <instruction>.l <address>
else
	<instruction>.l <address>+$6
endif
endmacro