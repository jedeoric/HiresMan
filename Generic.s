;Generic and math Routines

fecpdInputLo	.byt 0
fecpdInputHi	.byt 0
Digits
 .dsb 5,0
;Input
;A value
;X multiplier
;Output
;A Value
;Corrupts
;AX
Mult8Bit
.(
	sta vector1+1
	txa

	beq skip1
	
	lda #00
	clc
vector1	adc #00
	dex
	bne vector1
skip1
.)
	rts


;Input
;A multiplier
;X Value Low
;Y Value High
;Output
;X Value Low
;Y Value High
;Corrupts
;AXY
Mult16Bit
.(
	stx vector1+1
	sty vector2+1
	ldx #00
	stx vector3+1
	stx vector4+1
	
	tax
	beq skip1
	clc
	
vector3	lda #00
vector1	adc #00
	sta vector3+1
vector4	lda #00
vector2	adc #00
	sta vector4+1
	
	dex
	bne vector3
	
skip1	ldx vector3+1
	ldy vector4+1
.)	
	rts

;Input
;fecpdInputLo
;fecpdInputHi
;Output (Text)
;Examples
;"65535"
;"226"
PlotDecimal
;joop2	nop
;	jmp joop2

	ldy #3
.(
loop2	ldx #47

loop1	inx
	
	lda fecpdInputLo
	sec
	sbc NoughtsTableLo,y
	sta fecpdInputLo
	lda fecpdInputHi
	sbc NoughtsTableHi,y
	sta fecpdInputHi
	
	bcs loop1

	lda fecpdInputLo
	adc NoughtsTableLo,y
	sta fecpdInputLo
	lda fecpdInputHi
	adc NoughtsTableHi,y
	sta fecpdInputHi
	
	txa
	sta Digits+1,y
	
	dey
	bpl loop2
.)	
	lda fecpdInputLo
	ora #48
	sta Digits
	
	;Look from left for 0
	ldx #04
.(
loop1	lda Digits,x
	cmp #48
	bne skip1
	dex
	bpl loop1
	inx
loop2
skip1
	;Display the digits starting at X
	lda Digits,x
	ldy ScreenXIndex
	sta (screen),y
	inc ScreenXIndex
	iny
	dex
	bpl loop2
.)
	rts


NoughtsTableLo
 .byt <10
 .byt <100
 .byt <1000
 .byt <10000
NoughtsTableHi
 .byt >10
 .byt >100
 .byt >1000
 .byt >10000

CLS
	ldx #00
	lda #32
.(
loop1	sta $BB80,x
	sta $BC80,x
	sta $BD80,x
	sta $BE80,x
	sta $BEE0,x
	dex
	bne loop1
.)
	rts

FlushInput
	jsr ROM_GTORKB
	bmi FlushInput
	rts
	
WaitOnKey
	;Flush keys
	jsr FlushInput
	
	;Wait on key
.(	
loop1	jsr ROM_GTORKB
	bpl loop1
.)
	rts

Plot3DD	ldx #47
	sec
.(
loop1	inx
	sbc #100
	bcs loop1
.)
	adc #100
	pha
	txa
	sta $BFE0-120,y
	iny
	pla


Plot2DD	ldx #47
	sec
.(
loop1	inx
	sbc #10
	bcs loop1
.)
	adc #10
	pha
	txa
	sta $BFE0-120,y
	iny
	pla
Plot1DD
	clc
	adc #48
	sta $BFE0-120,y
	iny
	rts

