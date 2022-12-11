	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 16, 0	sdk_version 16, 0
	.globl	_haha                           ; -- Begin function haha
	.p2align	2
_haha:                                  ; @haha
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w8, #2
	str	w8, [sp, #12]
	mov	w8, #3
	str	w8, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_hehe                           ; -- Begin function hehe
	.p2align	2
_hehe:                                  ; @hehe
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #5
	stur	w8, [x29, #-4]
	mov	w8, #6
	str	w8, [sp, #8]
	bl	_haha
	bl	_hehe
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
