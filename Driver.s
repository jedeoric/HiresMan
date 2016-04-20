;Hires manipulator (HIRESMAN)
;Select area then...
; Bit Scroll Left
; Bit Scroll Right

; Byte Scroll Left
; Byte Scroll Right
; Byte Scroll Up
; Byte Scroll Down

; Remove Inverse
; Remove Attributes

; Flip
; Mirror

; Clear
; Copy
; Cut
; Paste

; Fill
#define	ROM_HIRES	$EC33
#define	ROM_TEXT	$EC21
#define	ROM_GTORKB	$EB78
#define	ROM_PRTCHAR	$F5C1

#define	SOFTKEY_NONE	56
#define	SOFTKEY_CTRL	162
#define	SOFTKEY_FUNC	165

 .zero
*=$00

screen	.dsb 2	;00
TempW	.dsb 1  ;02
TempH   .dsb 1  ;03
TempR1	.dsb 1  ;04
TempR2	.dsb 1  ;05
TempX1	.dsb 1	;06
TempX2	.dsb 1	;07
TempY	.dsb 1  ;08
buffer	.dsb 2  ;09
TempC	.dsb 1	;0A

*=$BB
source	.dsb 2

 .text
*=$4000

InputDriver
	tsx
	stx StackPointer
InputDriver3
	jsr DisplayLegend
InputDriver2
	jsr InvertHighlightCursor
.(	
loop1	jsr ROM_GTORKB
	bpl loop1
	
	sta hmPressedBlackKey
	lda $0209
	sta hmPressedRedKey
	jsr InvertHighlightCursor
	
	ldx #24
	
loop2	lda hmPressedBlackKey
	cmp hmBlackKey,x
	bne skip2
	lda hmPressedRedKey
	cmp hmRedKey,x
	beq skip1
skip2	dex
	bpl loop2
	jmp InputDriver2
	
skip1	lda hmVectorLo,x
	sta vector1+1
	lda hmVectorHi,x
	sta vector1+2
vector1	jsr $dead
.)
	jmp InputDriver3

#include "Generic.s"

hmBlackKey
 .byt 8		;Left Crsr	Move Cursor Left
 .byt 9		;Right Crsr	Move Cursor Right
 .byt 10	;Down Crsr	Move Cursor Down
 .byt 11	;Up Crsr	Move Cursor Up
 
 .byt "Z"	;Z		Contract Cursor Width
 .byt "X"	;X		Expand Cursor Width
 .byt "'"	;'		Contract Cursor Height
 .byt "/"	;/		Expand Cursor Height
 
 .byt "W"	;Func W		Byte Scroll Left
 .byt "E"	;Func E		Byte Scroll Right
 .byt "S"	;Func S		Byte Scroll Down
 .byt "N"	;Func N		Byte Scroll Up
 .byt "L"	;Func L		Bit Scroll Left
 .byt "R"	;Func R		Bit Scroll Right
 
 .byt "M"	;Func M		Mirror
 .byt "F"	;Func F		Flip
 .byt 4		;Ctrl D		Dump to Printer

 .byt 23	;Ctrl W		Wipe Area
 .byt 24	;Ctrl X		Cut Area
 .byt 3		;Ctrl C		Copy Area
 .byt 22	;Ctrl V		Paste Area
 
 .byt "A"	;Func A		Remove Attributes
 .byt "I"	;Func I		Remove Inverse
 .byt "V"	;Func V		Invert area

 .byt 27	;Esc		Go to Files

hmRedKey
 .byt SOFTKEY_NONE
 .byt SOFTKEY_NONE
 .byt SOFTKEY_NONE
 .byt SOFTKEY_NONE

 .byt SOFTKEY_NONE
 .byt SOFTKEY_NONE
 .byt SOFTKEY_NONE
 .byt SOFTKEY_NONE
 
 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC

 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC
 .byt SOFTKEY_CTRL

 .byt SOFTKEY_CTRL
 .byt SOFTKEY_CTRL
 .byt SOFTKEY_CTRL
 .byt SOFTKEY_CTRL

 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC
 .byt SOFTKEY_FUNC

 .byt SOFTKEY_NONE

hmVectorLo
 .byt <MoveLeft		;Left Crsr	Move Cursor Left
 .byt <MoveRight	;Right Crsr	Move Cursor Right
 .byt <MoveDown		;Down Crsr	Move Cursor Down
 .byt <MoveUp		;Up Crsr	Move Cursor Up
 
 .byt <ContractWidth	;Z		Contract Cursor Width
 .byt <ExpandWidth	;X		Expand Cursor Width
 .byt <ContractHeight	;'		Contract Cursor Height
 .byt <ExpandHeight	;/		Expand Cursor Height
 
 .byt <ByteScrollLeft	;Func W		Byte Scroll Left
 .byt <ByteScrollRight	;Func E		Byte Scroll Right
 .byt <ByteScrollDown	;Func S		Byte Scroll Down
 .byt <ByteScrollUp	;Func N		Byte Scroll Up
 .byt <BitScrollLeft	;Func L		Bit Scroll Left
 .byt <BitScrollRight	;Func R		Bit Scroll Right
 
 .byt <MirrorArea	;Func M		Mirror
 .byt <FlipArea		;Func F		Flip
 .byt <Dump2Printer	;Ctrl D		Dump to Printer
 
 .byt <WipeArea		;Ctrl W		Wipe Area
 .byt <CutArea		;Ctrl X		Cut Area
 .byt <CopyArea		;Ctrl C		Copy Area
 .byt <PasteArea	;Ctrl V		Paste Area
 
 .byt <RemoveAttributes	;Func A		Remove Attributes
 .byt <RemoveInverse	;Func I		Remove Inverse
 .byt <InvertArea	;Func V		Invert area

 .byt <Quit2Files	;Esc		Go to Files

hmVectorHi
 .byt >MoveLeft		;Left Crsr	Move Cursor Left
 .byt >MoveRight	;Right Crsr	Move Cursor Right
 .byt >MoveDown		;Down Crsr	Move Cursor Down
 .byt >MoveUp		;Up Crsr	Move Cursor Up
 
 .byt >ContractWidth	;Z		Contract Cursor Width
 .byt >ExpandWidth	;X		Expand Cursor Width
 .byt >ContractHeight	;'		Contract Cursor Height
 .byt >ExpandHeight	;/		Expand Cursor Height
 
 .byt >ByteScrollLeft	;Func W		Byte Scroll Left
 .byt >ByteScrollRight	;Func E		Byte Scroll Right
 .byt >ByteScrollDown	;Func S		Byte Scroll Down
 .byt >ByteScrollUp	;Func N		Byte Scroll Up
 .byt >BitScrollLeft	;Func L		Bit Scroll Left
 .byt >BitScrollRight	;Func R		Bit Scroll Right
 
 .byt >MirrorArea	;Func M		Mirror
 .byt >FlipArea		;Func F		Flip
 .byt >Dump2Printer	;Ctrl D		Dump to Printer
 
 .byt >WipeArea		;Ctrl W		Wipe Area
 .byt >CutArea		;Ctrl X		Cut Area
 .byt >CopyArea		;Ctrl C		Copy Area
 .byt >PasteArea	;Ctrl V		Paste Area
 
 .byt >RemoveAttributes	;Func A		Remove Attributes
 .byt >RemoveInverse	;Func I		Remove Inverse
 .byt >InvertArea	;Func V		Invert area
 
 .byt >Quit2Files	;Esc		Go to Files
 

hmPressedBlackKey	.byt 0
hmPressedRedKey         .byt 0
CursorX                 .byt 0
CursorY                 .byt 0
CursorW                 .byt 1
CursorH                 .byt 1
BitCarry                .byt 0
RowCount                .byt 0
ScreenXIndex		.byt 0
LeftSideIndex		.byt 0
RightSideIndex          .byt 0
LeftSideByte            .byt 0
RightSideByte           .byt 0
UnmirroredByte          .byt 0
MirroredByte            .byt 0
BitCount                .byt 0
InverseFlag		.byt 0
CursorTableIndex	.byt 0
StackPointer		.byt 0

HiresYLOCL
 .byt <$A000
 .byt <$A000+40*1
 .byt <$A000+40*2
 .byt <$A000+40*3
 .byt <$A000+40*4
 .byt <$A000+40*5
 .byt <$A000+40*6
 .byt <$A000+40*7
 .byt <$A000+40*8
 .byt <$A000+40*9
 .byt <$A000+40*10
 .byt <$A000+40*11
 .byt <$A000+40*12
 .byt <$A000+40*13
 .byt <$A000+40*14
 .byt <$A000+40*15
 .byt <$A000+40*16
 .byt <$A000+40*17
 .byt <$A000+40*18
 .byt <$A000+40*19
 .byt <$A000+40*20
 .byt <$A000+40*21
 .byt <$A000+40*22
 .byt <$A000+40*23
 .byt <$A000+40*24
 .byt <$A000+40*25
 .byt <$A000+40*26
 .byt <$A000+40*27
 .byt <$A000+40*28
 .byt <$A000+40*29
 .byt <$A000+40*30
 .byt <$A000+40*31
 .byt <$A000+40*32
 .byt <$A000+40*33
 .byt <$A000+40*34
 .byt <$A000+40*35
 .byt <$A000+40*36
 .byt <$A000+40*37
 .byt <$A000+40*38
 .byt <$A000+40*39
 .byt <$A000+40*40
 .byt <$A000+40*41
 .byt <$A000+40*42
 .byt <$A000+40*43
 .byt <$A000+40*44
 .byt <$A000+40*45
 .byt <$A000+40*46
 .byt <$A000+40*47
 .byt <$A000+40*48
 .byt <$A000+40*49
 .byt <$A000+40*50
 .byt <$A000+40*51
 .byt <$A000+40*52
 .byt <$A000+40*53
 .byt <$A000+40*54
 .byt <$A000+40*55
 .byt <$A000+40*56
 .byt <$A000+40*57
 .byt <$A000+40*58
 .byt <$A000+40*59
 .byt <$A000+40*60
 .byt <$A000+40*61
 .byt <$A000+40*62
 .byt <$A000+40*63
 .byt <$A000+40*64
 .byt <$A000+40*65
 .byt <$A000+40*66
 .byt <$A000+40*67
 .byt <$A000+40*68
 .byt <$A000+40*69
 .byt <$A000+40*70
 .byt <$A000+40*71
 .byt <$A000+40*72
 .byt <$A000+40*73
 .byt <$A000+40*74
 .byt <$A000+40*75
 .byt <$A000+40*76
 .byt <$A000+40*77
 .byt <$A000+40*78
 .byt <$A000+40*79
 .byt <$A000+40*80
 .byt <$A000+40*81
 .byt <$A000+40*82
 .byt <$A000+40*83
 .byt <$A000+40*84
 .byt <$A000+40*85
 .byt <$A000+40*86
 .byt <$A000+40*87
 .byt <$A000+40*88
 .byt <$A000+40*89
 .byt <$A000+40*90
 .byt <$A000+40*91
 .byt <$A000+40*92
 .byt <$A000+40*93
 .byt <$A000+40*94
 .byt <$A000+40*95
 .byt <$A000+40*96
 .byt <$A000+40*97
 .byt <$A000+40*98
 .byt <$A000+40*99
 .byt <$A000+40*100
 .byt <$A000+40*101
 .byt <$A000+40*102
 .byt <$A000+40*103
 .byt <$A000+40*104
 .byt <$A000+40*105
 .byt <$A000+40*106
 .byt <$A000+40*107
 .byt <$A000+40*108
 .byt <$A000+40*109
 .byt <$A000+40*110
 .byt <$A000+40*111
 .byt <$A000+40*112
 .byt <$A000+40*113
 .byt <$A000+40*114
 .byt <$A000+40*115
 .byt <$A000+40*116
 .byt <$A000+40*117
 .byt <$A000+40*118
 .byt <$A000+40*119
 .byt <$A000+40*120
 .byt <$A000+40*121
 .byt <$A000+40*122
 .byt <$A000+40*123
 .byt <$A000+40*124
 .byt <$A000+40*125
 .byt <$A000+40*126
 .byt <$A000+40*127
 .byt <$A000+40*128
 .byt <$A000+40*129
 .byt <$A000+40*130
 .byt <$A000+40*131
 .byt <$A000+40*132
 .byt <$A000+40*133
 .byt <$A000+40*134
 .byt <$A000+40*135
 .byt <$A000+40*136
 .byt <$A000+40*137
 .byt <$A000+40*138
 .byt <$A000+40*139
 .byt <$A000+40*140
 .byt <$A000+40*141
 .byt <$A000+40*142
 .byt <$A000+40*143
 .byt <$A000+40*144
 .byt <$A000+40*145
 .byt <$A000+40*146
 .byt <$A000+40*147
 .byt <$A000+40*148
 .byt <$A000+40*149
 .byt <$A000+40*150
 .byt <$A000+40*151
 .byt <$A000+40*152
 .byt <$A000+40*153
 .byt <$A000+40*154
 .byt <$A000+40*155
 .byt <$A000+40*156
 .byt <$A000+40*157
 .byt <$A000+40*158
 .byt <$A000+40*159
 .byt <$A000+40*160
 .byt <$A000+40*161
 .byt <$A000+40*162
 .byt <$A000+40*163
 .byt <$A000+40*164
 .byt <$A000+40*165
 .byt <$A000+40*166
 .byt <$A000+40*167
 .byt <$A000+40*168
 .byt <$A000+40*169
 .byt <$A000+40*170
 .byt <$A000+40*171
 .byt <$A000+40*172
 .byt <$A000+40*173
 .byt <$A000+40*174
 .byt <$A000+40*175
 .byt <$A000+40*176
 .byt <$A000+40*177
 .byt <$A000+40*178
 .byt <$A000+40*179
 .byt <$A000+40*180
 .byt <$A000+40*181
 .byt <$A000+40*182
 .byt <$A000+40*183
 .byt <$A000+40*184
 .byt <$A000+40*185
 .byt <$A000+40*186
 .byt <$A000+40*187
 .byt <$A000+40*188
 .byt <$A000+40*189
 .byt <$A000+40*190
 .byt <$A000+40*191
 .byt <$A000+40*192
 .byt <$A000+40*193
 .byt <$A000+40*194
 .byt <$A000+40*195
 .byt <$A000+40*196
 .byt <$A000+40*197
 .byt <$A000+40*198
 .byt <$A000+40*199
HiresYLOCH
 .byt >$A000
 .byt >$A000+40*1
 .byt >$A000+40*2
 .byt >$A000+40*3
 .byt >$A000+40*4
 .byt >$A000+40*5
 .byt >$A000+40*6
 .byt >$A000+40*7
 .byt >$A000+40*8
 .byt >$A000+40*9
 .byt >$A000+40*10
 .byt >$A000+40*11
 .byt >$A000+40*12
 .byt >$A000+40*13
 .byt >$A000+40*14
 .byt >$A000+40*15
 .byt >$A000+40*16
 .byt >$A000+40*17
 .byt >$A000+40*18
 .byt >$A000+40*19
 .byt >$A000+40*20
 .byt >$A000+40*21
 .byt >$A000+40*22
 .byt >$A000+40*23
 .byt >$A000+40*24
 .byt >$A000+40*25
 .byt >$A000+40*26
 .byt >$A000+40*27
 .byt >$A000+40*28
 .byt >$A000+40*29
 .byt >$A000+40*30
 .byt >$A000+40*31
 .byt >$A000+40*32
 .byt >$A000+40*33
 .byt >$A000+40*34
 .byt >$A000+40*35
 .byt >$A000+40*36
 .byt >$A000+40*37
 .byt >$A000+40*38
 .byt >$A000+40*39
 .byt >$A000+40*40
 .byt >$A000+40*41
 .byt >$A000+40*42
 .byt >$A000+40*43
 .byt >$A000+40*44
 .byt >$A000+40*45
 .byt >$A000+40*46
 .byt >$A000+40*47
 .byt >$A000+40*48
 .byt >$A000+40*49
 .byt >$A000+40*50
 .byt >$A000+40*51
 .byt >$A000+40*52
 .byt >$A000+40*53
 .byt >$A000+40*54
 .byt >$A000+40*55
 .byt >$A000+40*56
 .byt >$A000+40*57
 .byt >$A000+40*58
 .byt >$A000+40*59
 .byt >$A000+40*60
 .byt >$A000+40*61
 .byt >$A000+40*62
 .byt >$A000+40*63
 .byt >$A000+40*64
 .byt >$A000+40*65
 .byt >$A000+40*66
 .byt >$A000+40*67
 .byt >$A000+40*68
 .byt >$A000+40*69
 .byt >$A000+40*70
 .byt >$A000+40*71
 .byt >$A000+40*72
 .byt >$A000+40*73
 .byt >$A000+40*74
 .byt >$A000+40*75
 .byt >$A000+40*76
 .byt >$A000+40*77
 .byt >$A000+40*78
 .byt >$A000+40*79
 .byt >$A000+40*80
 .byt >$A000+40*81
 .byt >$A000+40*82
 .byt >$A000+40*83
 .byt >$A000+40*84
 .byt >$A000+40*85
 .byt >$A000+40*86
 .byt >$A000+40*87
 .byt >$A000+40*88
 .byt >$A000+40*89
 .byt >$A000+40*90
 .byt >$A000+40*91
 .byt >$A000+40*92
 .byt >$A000+40*93
 .byt >$A000+40*94
 .byt >$A000+40*95
 .byt >$A000+40*96
 .byt >$A000+40*97
 .byt >$A000+40*98
 .byt >$A000+40*99
 .byt >$A000+40*100
 .byt >$A000+40*101
 .byt >$A000+40*102
 .byt >$A000+40*103
 .byt >$A000+40*104
 .byt >$A000+40*105
 .byt >$A000+40*106
 .byt >$A000+40*107
 .byt >$A000+40*108
 .byt >$A000+40*109
 .byt >$A000+40*110
 .byt >$A000+40*111
 .byt >$A000+40*112
 .byt >$A000+40*113
 .byt >$A000+40*114
 .byt >$A000+40*115
 .byt >$A000+40*116
 .byt >$A000+40*117
 .byt >$A000+40*118
 .byt >$A000+40*119
 .byt >$A000+40*120
 .byt >$A000+40*121
 .byt >$A000+40*122
 .byt >$A000+40*123
 .byt >$A000+40*124
 .byt >$A000+40*125
 .byt >$A000+40*126
 .byt >$A000+40*127
 .byt >$A000+40*128
 .byt >$A000+40*129
 .byt >$A000+40*130
 .byt >$A000+40*131
 .byt >$A000+40*132
 .byt >$A000+40*133
 .byt >$A000+40*134
 .byt >$A000+40*135
 .byt >$A000+40*136
 .byt >$A000+40*137
 .byt >$A000+40*138
 .byt >$A000+40*139
 .byt >$A000+40*140
 .byt >$A000+40*141
 .byt >$A000+40*142
 .byt >$A000+40*143
 .byt >$A000+40*144
 .byt >$A000+40*145
 .byt >$A000+40*146
 .byt >$A000+40*147
 .byt >$A000+40*148
 .byt >$A000+40*149
 .byt >$A000+40*150
 .byt >$A000+40*151
 .byt >$A000+40*152
 .byt >$A000+40*153
 .byt >$A000+40*154
 .byt >$A000+40*155
 .byt >$A000+40*156
 .byt >$A000+40*157
 .byt >$A000+40*158
 .byt >$A000+40*159
 .byt >$A000+40*160
 .byt >$A000+40*161
 .byt >$A000+40*162
 .byt >$A000+40*163
 .byt >$A000+40*164
 .byt >$A000+40*165
 .byt >$A000+40*166
 .byt >$A000+40*167
 .byt >$A000+40*168
 .byt >$A000+40*169
 .byt >$A000+40*170
 .byt >$A000+40*171
 .byt >$A000+40*172
 .byt >$A000+40*173
 .byt >$A000+40*174
 .byt >$A000+40*175
 .byt >$A000+40*176
 .byt >$A000+40*177
 .byt >$A000+40*178
 .byt >$A000+40*179
 .byt >$A000+40*180
 .byt >$A000+40*181
 .byt >$A000+40*182
 .byt >$A000+40*183
 .byt >$A000+40*184
 .byt >$A000+40*185
 .byt >$A000+40*186
 .byt >$A000+40*187
 .byt >$A000+40*188
 .byt >$A000+40*189
 .byt >$A000+40*190
 .byt >$A000+40*191
 .byt >$A000+40*192
 .byt >$A000+40*193
 .byt >$A000+40*194
 .byt >$A000+40*195
 .byt >$A000+40*196
 .byt >$A000+40*197
 .byt >$A000+40*198
 .byt >$A000+40*199



DisplayLegend
	ldx #119
.(
loop1	lda hmLegend,x
	sta $BFE0-120,x
	dex
	bpl loop1
.)	
	;Now plot values
	ldy #5
	lda CursorX
	jsr Plot2DD
	
	ldy #13
	lda CursorY
	jsr Plot3DD
	
	ldy #23
	lda CursorW
	jsr Plot2DD
	
	ldy #33
	lda CursorH
	jsr Plot3DD
	
	lda CursorW
	ldx CursorH
	ldy #00
	
	jsr Mult16Bit
	stx fecpdInputLo
	stx SelectedAreaSizeLo
	sty fecpdInputHi
	sty SelectedAreaSizeHi
	
	;Wipe the decimal field before displaying it again
	ldy #3
	lda #8
.(
loop1	sta $BFE0-120+40+13,y
	dey
	bpl loop1
.)
	ldy #40+13
	sty ScreenXIndex
	ldy #<$BFE0-120
	sty screen
	ldy #>$BFE0-120
	sty screen+1

	jsr PlotDecimal
	
	ldy #40+34
	lda BufferW
	jsr Plot2DD
	
	ldy #40+37
	lda BufferH
	jsr Plot3DD
	
	rts
	

	
hmLegend
;      0123456789012345678901234567890123456789
 .byt "XPos:00 YPos:000 Width:00 Height:000    "
 .byt "      Memory:             Buffer: 00x000"
 .byt "Ready                                   "

InvertTLCursorFlag
 .byt 1		;0 W>1 H>1
 .byt 1		;1 W=1 H>1
 .byt 1		;2 W>1 H=1
 .byt 1		;3 W=1 H=1
 
InvertTRCursorFlag
 .byt 1		;0 W>1 H>1
 .byt 0		;1 W=1 H>1
 .byt 1		;2 W>1 H=1
 .byt 0		;3 W=1 H=1
InvertBLCursorFlag
 .byt 1		;0 W>1 H>1
 .byt 1		;1 W=1 H>1
 .byt 0		;2 W>1 H=1
 .byt 0		;3 W=1 H=1
InvertBRCursorFlag
 .byt 1		;0 W>1 H>1
 .byt 0		;1 W=1 H>1
 .byt 0		;2 W>1 H=1
 .byt 0		;3 W=1 H=1

InvertHighlightCursor
	;With no rules the cursor may dissapear alltogether
	lda #00
	ldx CursorW
	cpx #1
.(
	bne skip1
	ora #01
skip1	ldx CursorH
	cpx #1
	bne skip2
	ora #02
skip2	tax
	stx CursorTableIndex
	lda InvertTLCursorFlag,x
	beq skip3
	jsr InvertTLCursor
	
skip3	ldx CursorTableIndex
	lda InvertTRCursorFlag,x
	beq skip4
	jsr InvertTRCursor
	
skip4	ldx CursorTableIndex
	lda InvertBLCursorFlag,x
	beq skip5
	jsr InvertBLCursor
	
skip5	ldx CursorTableIndex
	lda InvertBRCursorFlag,x
	beq skip6
	jsr InvertBRCursor

skip6	rts
.)

InvertTLCursor
	ldy CursorY
	jsr FetchRowLoc
	ldy CursorX
	
	lda (screen),y
	eor #128
	sta (screen),y
	
	rts
	
InvertTRCursor
	ldy CursorY
	jsr FetchRowLoc
	jsr FetchCursorRightside
	tay
	
	lda (screen),y
	eor #128
	sta (screen),y
	
	rts
	
InvertBLCursor
	lda CursorY
	clc
	adc CursorH
	sec
	sbc #1
	tay
	jsr FetchRowLoc
	ldy CursorX
	
	lda (screen),y
	eor #128
	sta (screen),y

	rts

InvertBRCursor
	lda CursorY
	clc
	adc CursorH
	sec
	sbc #1
	tay
	jsr FetchRowLoc
	jsr FetchCursorRightside
	tay
	
	lda (screen),y
	eor #128
	sta (screen),y
	
	rts


;CursorX Xpos (0-39)
;CursorY Ypos (0-199)
;CursorW Width (0-39)
;CursorH Height (0-199)
;
BitScrollLeft	;Ignore attribute bytes
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	jsr FetchCursorRightside
	tax
	lda CursorW
	sta TempW
	lda #00
	sta BitCarry
	
loop1	jsr FetchByte
	jsr CheckBitmap
	bcc skip1
	jsr ExtractInverseFlag
	
	asl BitCarry
	and #63
	rol
	cmp #64
	ror BitCarry
	ora #64
	
	jsr InsertInverseFlag
	jsr StoreByte
	
skip1	dex
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts
	
BitScrollRight
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta TempW
	lda #00
	sta BitCarry
	
loop1	jsr FetchByte
	jsr CheckBitmap
	bcc skip1
	jsr ExtractInverseFlag
	
	and #63
	asl BitCarry
	bcc skip2
	ora #64
skip2	lsr
	ror BitCarry
	ora #64
	
	jsr InsertInverseFlag
	jsr StoreByte
	
skip1	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts
	
ByteScrollLeft
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta TempW
	
loop1	jsr FetchByteLoc
	sty vector1+1
	ldy #01
	lda (screen),y
	dey
	sta (screen),y
vector1	ldy #00

	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	;Clear rightmost column
	ldy CursorY
	sty TempY
	lda CursorH
	sta TempH
.(	
loop1	ldy TempY
	jsr FetchRowLoc
	
	lda CursorX
	clc
	adc CursorW
	sec
	sbc #1
	tay
	
	lda #64
	sta (screen),y
	
	inc TempY
	dec TempH
	bne loop1
.)
	rts

ByteScrollRight
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	jsr FetchCursorRightside
	tax
	dex
	lda CursorW
	sta TempW
	dec TempW
	
loop1	jsr FetchByteLoc
	sty vector1+1
	ldy #00
	lda (screen),y
	iny
	sta (screen),y
vector1	ldy #00
	
	dex
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	;Clear leftmost column
	ldy CursorY
	sty TempY
	lda CursorH
	sta TempH
.(	
loop1	ldy TempY
	jsr FetchRowLoc
	
	lda CursorX
	tay
	
	lda #64
	sta (screen),y
	
	inc TempY
	dec TempH
	bne loop1
.)
	rts

	
ByteScrollDown
	lda CursorH
	sta TempH
	dec TempH
	
	lda CursorY
	clc
	adc CursorH
	sec
	sbc #2
	sta TempY
	
.(	
loop2	ldy TempY
	jsr FetchRowLoc
	
	lda CursorX
	sta TempR1
	clc
	adc #40
	sta TempR2
	
	ldx CursorW
loop1	ldy TempR1
	lda (screen),y
	ldy TempR2
	sta (screen),y
	inc TempR1
	inc TempR2
	dex
	bne loop1
	
	dec TempY
	dec TempH
	bne loop2
.)
	;Clear top row
	ldy CursorY
	jsr FetchRowLoc
	ldy CursorX
	lda CursorW
	sta TempW
.(	
	lda #64
loop1	sta (screen),y
	iny
	dec TempW
	bne loop1
.)
	rts
	
ByteScrollUp
	lda CursorH
	sta TempH
	lda CursorY
	sta TempY
.(	
loop2	lda CursorX
	sta TempR1
	clc
	adc #40
	sta TempR2
	
	ldy TempY
	jsr FetchRowLoc
	ldx CursorW
	
loop1	ldy TempR2
	lda (screen),y
	ldy TempR1
	sta (screen),y
	inc TempR1
	inc TempR2
	dex
	bne loop1
	
	inc TempY
	dec TempH
	bne loop2
.)	
	;Clear bottom row
	lda CursorY
	clc
	adc CursorH
	sec
	sbc #1
	tay
	jsr FetchRowLoc
	ldy CursorX
	ldx CursorW
	lda #64
.(
loop1	sta (screen),y
	iny
	dex
	bne loop1
.)
	rts
	


RemoveInverse
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta TempW
	
loop1	jsr FetchByte
	and #127
	jsr StoreByte
	
	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts

RemoveAttributes
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta TempW
	
loop1	jsr FetchByte
	jsr ExtractInverseFlag
	and #127
	cmp #64
	bcs skip2
	lda #64
skip2
	jsr InsertInverseFlag
	jsr StoreByte
	
	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts

FlipArea
	jsr CopyArea
	lda CursorY
	clc
	adc CursorH
	sec
	sbc #1
	sta TempY
	tay
	jsr FetchRowLoc
	lda #<HIRESBuffer
	sta buffer
	lda #>HIRESBuffer
	sta buffer+1
	
	lda CursorH
	sta TempH
.(	
loop2	ldy CursorX
	sty TempX2
	ldy #00
	sty TempX1
	ldx CursorW
	
loop1	ldy TempX1
	lda (buffer),y
	ldy TempX2
	sta (screen),y
	inc TempX1
	inc TempX2
	dex
	bne loop1
	
	lda buffer
	clc
	adc CursorW
	sta buffer
	lda buffer+1
	adc #00
	sta buffer+1
	
	lda screen
	sec
	sbc #40
	sta screen
	lda screen+1
	sbc #00
	sta screen+1
	
	dec TempH
	bne loop2
.)	
	rts

MirrorArea
	jsr CopyArea

	lda #<HIRESBuffer
	sta buffer
	lda #>HIRESBuffer
	sta buffer+1
	
	ldy CursorY
	jsr FetchRowLoc
	
	lda CursorH
	sta TempH
.(	
loop2	lda CursorW
	sec
	sbc #1
	sta TempX1
	lda CursorX
	sta TempX2
	ldx CursorW
	
loop1	ldy TempX1
	lda (buffer),y
	jsr MirrorByte
	bcc Attribute
	ora #64
	ldy TempX2
	sta (screen),y
	
Attribute
	dec TempX1
	inc TempX2
	
	dex
	bne loop1
	
	lda buffer
	clc
	adc CursorW
	sta buffer
	lda buffer+1
	adc #00
	sta buffer+1
	
	lda screen
	clc
	adc #40
	sta screen
	lda screen+1
	adc #00
	sta screen+1
	
	dec TempH
	bne loop2
.)	
	rts

MirrorByte
	jsr CheckBitmap
.(
	bcc skip1
	and #63
	sta UnmirroredByte
	
	lda #00
	sta MirroredByte
	lda #06
	sta BitCount
	
loop1	lsr UnmirroredByte
	rol MirroredByte
	dec BitCount
	bne loop1
	
	lda MirroredByte
	sec
skip1	rts
.)

	
WipeArea
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta TempW
	
loop1	jsr FetchByte
	lda #64
	jsr StoreByte
	
	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts

InvertArea
	ldy CursorY
	lda CursorH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta TempW
	
loop1	jsr FetchByte
	jsr CheckBitmap
	bcc skip1
	eor #63
	jsr StoreByte
	
skip1	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts

CopyArea
	lda #<HIRESBuffer
	sta buffer
	lda #>HIRESBuffer
	sta buffer+1
	
	ldy CursorY
	lda CursorH
	sta BufferH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta BufferW
	sta TempW
	
loop1	jsr FetchByte
	sty vector1+1
	ldy #00
	sta (buffer),y
	inc buffer
	bne vector1
	inc buffer+1
vector1	ldy #00
	
	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts

CutArea
	lda #<HIRESBuffer
	sta buffer
	lda #>HIRESBuffer
	sta buffer+1
	
	ldy CursorY
	lda CursorH
	sta BufferH
	sta TempH
.(	
loop2	ldx CursorX
	lda CursorW
	sta BufferW
	sta TempW
	
loop1	jsr FetchByte
	sty vector1+1
	ldy #00
	sta (buffer),y
	inc buffer
	bne vector1
	inc buffer+1
vector1	ldy #00
	lda #64
	jsr StoreByte
	
	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts

PasteArea
	lda #<HIRESBuffer
	sta buffer
	lda #>HIRESBuffer
	sta buffer+1
	
	ldy CursorY
	lda BufferH
	sta TempH
.(	
loop2	ldx CursorX
	lda BufferW
	sta TempW
	
loop1	jsr FetchByteLoc
	sty vector1+1
	ldy #00
	lda (buffer),y
	sta (screen),y
	inc buffer
	bne vector1
	inc buffer+1
vector1	ldy #00
	
	inx
	dec TempW
	bne loop1
	
	iny
	dec TempH
	bne loop2
.)
	rts

FetchByte
	jsr FetchByteLoc
.(
	sty vector1+1
	ldy #00
	lda (screen),y
vector1	ldy #00
.)
	rts
	
FetchByteLoc
	txa
	clc
	adc HiresYLOCL,y
	sta screen
	lda HiresYLOCH,y
	adc #00
	sta screen+1
	rts

FetchRowLoc
	lda HiresYLOCL,y
	sta screen
	lda HiresYLOCH,y
	sta screen+1
	rts

;Sec if bitmap
CheckBitmap
	pha
	and #127
	cmp #64
	pla
	rts


ExtractInverseFlag
	pha
	and #128
	sta InverseFlag
	pla
	rts
	
InsertInverseFlag
	and #127
	ora InverseFlag
	rts

StoreByte
.(
	sty vector1+1
	ldy #00
	sta (screen),y
vector1	ldy #00
.)
	rts

	
	
FetchCursorRightside
	lda CursorX
	clc
	adc CursorW
	sec
	sbc #1
	rts

	
	
	
HIRESBuffer
 .dsb 40*200,64
BufferW		.byt 0
BufferH		.byt 0

MoveLeft
	lda CursorX
.(
	beq skip1
	dec CursorX
	jmp DisplayLegend
skip1	rts
.)
MoveRight
	lda CursorX
	clc
	adc CursorW
	cmp #40
.(
	bcs skip1
	inc CursorX
	jmp DisplayLegend
skip1	rts
.)

MoveUp
	lda CursorY
.(
	beq skip1
	dec CursorY
	jmp DisplayLegend
skip1	rts
.)

MoveDown
	lda CursorY
	clc
	adc CursorH
	cmp #200
.(
	bcs skip1
	inc CursorY
	jmp DisplayLegend
skip1	rts
.)

ExpandWidth
.(
	lda CursorX
	clc
	adc CursorW
	cmp #40
	bcs skip1
	inc CursorW
	jmp DisplayLegend
skip1	rts
.)
ContractWidth
.(
	lda CursorW
	cmp #1
	beq skip1
	dec CursorW
	jmp DisplayLegend
skip1	rts
.)

ExpandHeight
.(
	lda CursorY
	clc
	adc CursorH
	cmp #200
	bcs skip1
	inc CursorH
	jmp DisplayLegend
skip1	rts
.)

ContractHeight
.(
	lda CursorH
	cmp #1
	beq skip1
	dec CursorH
	jmp DisplayLegend
skip1	rts
.)

 
 
Quit2Files	;Esc		Go to Files
	ldx StackPointer
	txs
	rts
	
RotateArea
	rts
;	;Must be square
;	lda CursorW
;	asl
;.(
;	sta vector1+1
;	asl
;vector1	adc #00
;	cmp CursorH
;	bne MustBeSquare
;
;	;Remove Attributes and inverse
;	jsr RemoveAttributes
;	jsr RemoveInverse
;	
;	jsr CopyArea
;	lda #<HIRESBuffer
;	sta buffer
;	lda #>HIRESBuffer
;	sta buffer+1
;	
;	;Calculate CursorX
;	lda CursorX
;	asl
;	sta vector2+1
;	asl
;vector2	adc #00
;	sta TempX
;	
;	;
;	lda CursorH
;	sta TempH
;	ldy CursorY
;	
;loop2	lda CursorH
;	sta TempW
;	ldx TempX
;	
;loop1	jsr FetchBitFromBuffer
;	jsr StoreBitToScreen
;	
;	inx
;	dec TempW
;	bne loop1
;	
;	iny
;	dec TempH
;	bne loop2
;.)
;	rts
;
;;Y==X
;;X==Y
;FetchBitFromBuffer
;	stx ???
;	sty ???
;	lda CursorW
;	ldy #00
;	jsr Mult16Bit
;	txa
;	adc 

d2pStartLo	.byt 0
d2pStartHi      .byt 0
LabelIndex	.byt 0
d2pLabelLo      .byt 0
d2pLabelHi      .byt 0
d2pLabelHeight	.byt 0
d2pLengthLo     .byt 0
d2pLengthHi     .byt 0
d2pRowWidth     .byt 0

GetConfirmation
.(
loop1	jsr ROM_GTORKB
	bmi loop1
loop2	jsr ROM_GTORKB
	bpl loop2
.)
	cmp #"Y"
.(
	beq skip1
	clc
skip1	rts
.)
TextVectorLo
 .byt <WarnPrinterText
TextVectorHi
 .byt >WarnPrinterText

WarnPrinterText
;      0123456789012345678901234567890123456789
 .byt "Ensure Printer is switched on before    "
 .byt "proceeding!                             "
 .byt "Are you sure you wish to continue Y/N","?"+128


DisplayTextMessage
	lda TextVectorLo,x
	sta source
	lda TextVectorHi,x
	sta source+1
	ldy #00
.(
loop1	lda (source),y
	pha
	and #127
	sta $BFE0-120,y
	iny
	pla
	bpl loop1
.)
	rts
	

Dump2Printer
	ldx #0	;TM_WARNPRINTER
	ldy #0
	jsr DisplayTextMessage
	jsr GetConfirmation
.(
	bcs skip1
	jmp DisplayLegend
skip1
.)
	jsr CopyArea
	jsr DisplayLegend	;Ensure size is updated
	lda #<HIRESBuffer
	sta d2pStartLo
	lda #>HIRESBuffer
	sta d2pStartHi
	
	lda SelectedAreaSizeLo
	sta d2pLengthLo
	lda SelectedAreaSizeHi
	sta d2pLengthHi
.(
	;If CursorW <17 then RowWidth==CursorW else use 16
	lda CursorW
	cmp #17
	bcc skip1
	lda #16
skip1	sta d2pRowWidth
.)
	lda #0
	sta d2pLabelHeight
	lda #<SelectedAreaText
	sta d2pLabelLo
	lda #>SelectedAreaText
	sta d2pLabelHi
	jmp DumpArea

SelectedAreaSizeLo	.byt 0
SelectedAreaSizeHi	.byt 0

SelectedAreaText
 .byt "SelectedAre","a"+128

DumpArea
	;
	lda d2pStartLo
	sta source
	lda d2pStartHi
	sta source+1
	lda #00
	sta LabelIndex
	lda #01
	sta TempH
.(	
loop2
	dec TempH
	bne skip1
	lda d2pLabelHeight
	sta TempH

	;Print Label with index in hex
	lda d2pLabelLo

	sta vector1+1
	lda d2pLabelHi
	sta vector1+2

	ldy #00
vector1	lda $dead,y
	iny
	pha
	and #127
	jsr ROM_PRTCHAR
	pla
	bpl vector1
	
	lda LabelIndex
	jsr Convert2DisplayableText
	jsr ROM_PRTCHAR
	txa
	jsr ROM_PRTCHAR
	
	inc LabelIndex
	
	;Send Carriage Return and Line Feed
	jsr NextLine

skip1	lda #" "
	jsr ROM_PRTCHAR
	lda #"."
	jsr ROM_PRTCHAR
	lda #"b"
	jsr ROM_PRTCHAR
	lda #"y"
	jsr ROM_PRTCHAR
	lda #"t"
	jsr ROM_PRTCHAR
	lda #" "
	jsr ROM_PRTCHAR
	
	lda d2pRowWidth
	sta TempC
	
loop1	lda #"$"
	jsr ROM_PRTCHAR
	ldy #00
	lda (source),y
	
	
	;Convert to displayable hex
	jsr Convert2DisplayableText

	jsr ROM_PRTCHAR
	txa
	jsr ROM_PRTCHAR
	
	inc source
	bne skip3
	inc source+1
skip3
	lda d2pLengthLo
	sec
	sbc #1
	sta d2pLengthLo
	lda d2pLengthHi
	sbc #00
	sta d2pLengthHi
	ora d2pLengthLo
	beq skip5
	bcc skip5
	
	dec TempC
	beq skip4
	
	lda #","
	jsr ROM_PRTCHAR
	
	jmp loop1
skip4
	;Proceed to next .byt row statement
	jsr NextLine
	
	jmp loop2
skip5
	jsr NextLine
	jsr NextLine
	rts
.)
	
Convert2DisplayableText
	pha
	and #15
	cmp #10
.(
	bcc skip1
	adc #6
skip1	adc #48
	tax
	pla
	lsr
	lsr
	lsr
	lsr
	cmp #10
	bcc skip2
	adc #6
skip2	adc #48
.)
	rts

NextLine
	lda #13
	jsr ROM_PRTCHAR
	lda #10
	jmp ROM_PRTCHAR
EndOfMemory
