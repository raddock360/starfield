;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module render
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sys_render_one_entity
	.globl _man_entity_forall
	.globl _cpct_getScreenPtr
	.globl _cpct_setPALColour
	.globl _cpct_setPalette
	.globl _cpct_setVideoMode
	.globl _palette
	.globl _sys_render_init
	.globl _sys_render_update
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/sys/render.c:14: void sys_render_one_entity (Entity_t* e) {
;	---------------------------------
; Function sys_render_one_entity
; ---------------------------------
_sys_render_one_entity::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/sys/render.c:15: if (e->prevptr != 0) 
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	hl, #0x0005
	add	hl,bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, d
	or	a,e
	jr	Z,00102$
;src/sys/render.c:16: *(e->prevptr) = 0;
	xor	a, a
	ld	(de), a
00102$:
;src/sys/render.c:18: if (!(e->type & e_type_dead)) {
	ld	a, (bc)
	rlca
	jr	C,00105$
;src/sys/render.c:19: u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e->x, e->y);
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	d, (hl)
	ld	l, c
	ld	h, b
	inc	hl
	ld	a, (hl)
	push	bc
	ld	e, a
	push	de
	ld	hl, #0xc000
	push	hl
	call	_cpct_getScreenPtr
	ex	de,hl
	pop	iy
	ld	a, 4 (iy)
	ld	(de), a
;src/sys/render.c:21: e->prevptr = pvmem;
	pop	hl
	push	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
00105$:
	ld	sp, ix
	pop	ix
	ret
;src/sys/render.c:42: void sys_render_init() {
;	---------------------------------
; Function sys_render_init
; ---------------------------------
_sys_render_init::
;src/sys/render.c:43: cpct_setVideoMode(0);
	ld	l, #0x00
	call	_cpct_setVideoMode
;src/sys/render.c:44: cpct_setBorder(HW_BLACK);
	ld	hl, #0x1410
	push	hl
	call	_cpct_setPALColour
;src/sys/render.c:45: cpct_setPalette(palette, 16);
	ld	hl, #0x0010
	push	hl
	ld	hl, #_palette
	push	hl
	call	_cpct_setPalette
	ret
_palette:
	.db #0x14	; 20
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x0b	; 11
;src/sys/render.c:53: void sys_render_update() {
;	---------------------------------
; Function sys_render_update
; ---------------------------------
_sys_render_update::
;src/sys/render.c:54: man_entity_forall (sys_render_one_entity);
	ld	hl, #_sys_render_one_entity
	push	hl
	call	_man_entity_forall
	pop	af
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
