.include "asm_setup.S"

.global NoBloom

# Select post-effects to remove
NoBloom:
li		r5, 0x30
rlwinm	r5, r5, 0, 16, 31
andc	r4, r4, r5
li		r5, 0x0
blr
