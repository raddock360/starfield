;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module entity
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cpct_memset
	.globl _m_next_free_entity
	.globl _m_entities
	.globl _man_entity_init
	.globl _man_entity_create
	.globl _man_entity_forall
	.globl _man_entity_destroy
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_m_entities::
	.ds 50
_m_next_free_entity::
	.ds 2
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
;src/man/entity.c:6: void man_entity_init(void) {
;	---------------------------------
; Function man_entity_init
; ---------------------------------
_man_entity_init::
;src/man/entity.c:7: cpct_memset(m_entities, 0, sizeof(m_entities));
	ld	hl, #0x0032
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_m_entities
	push	hl
	call	_cpct_memset
;src/man/entity.c:8: m_next_free_entity = m_entities;
	ld	hl, #_m_entities
	ld	(_m_next_free_entity), hl
	ret
;src/man/entity.c:11: Entity_t* man_entity_create(void) {
;	---------------------------------
; Function man_entity_create
; ---------------------------------
_man_entity_create::
;src/man/entity.c:12: Entity_t* e = m_next_free_entity;
	ld	bc, (_m_next_free_entity)
;src/man/entity.c:13: m_next_free_entity = e + 1;
	ld	hl, #0x0005
	add	hl,bc
	ld	(_m_next_free_entity), hl
;src/man/entity.c:14: e->type = e_type_default;
	ld	a, #0x7f
	ld	(bc), a
;src/man/entity.c:15: return e;
	ld	l, c
	ld	h, b
	ret
;src/man/entity.c:18: void man_entity_forall( void (*ptrfunc) (Entity_t*) ) {
;	---------------------------------
; Function man_entity_forall
; ---------------------------------
_man_entity_forall::
;src/man/entity.c:19: Entity_t * e = m_entities;
	ld	bc, #_m_entities+0
;src/man/entity.c:20: while( e->type != e_type_invalid ) {
00101$:
	ld	a, (bc)
	or	a, a
	ret	Z
;src/man/entity.c:21: ptrfunc( e );
	push	bc
	push	bc
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	call	___sdcc_call_hl
	pop	af
	pop	bc
;src/man/entity.c:22: ++e;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	jr	00101$
;src/man/entity.c:26: void man_entity_destroy(Entity_t* dead_e) {
;	---------------------------------
; Function man_entity_destroy
; ---------------------------------
_man_entity_destroy::
;src/man/entity.c:27: dead_e->type = e_type_invalid;
	pop	de
	pop	bc
	push	bc
	push	de
	xor	a, a
	ld	(bc), a
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
