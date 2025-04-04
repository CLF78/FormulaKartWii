.include "asm_setup.S"

.global OffroadRampGlitchFix

# original instruction
OffroadRampGlitchFix:
stw     r0, 0x4(r3)

# Fix
lwz     r0, 0xc(r3)
rlwinm  r0, r0, 0, 0xc, 0xa
stw     r0, 0xc(r3)
blr