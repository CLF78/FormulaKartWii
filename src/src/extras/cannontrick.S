.include "asm_setup.S"

.global TrickableCannon

# Original instruction (Apply cannon bit)
TrickableCannon:
ori r0, r0, 0x10

# Apply can trick bit
oris r0, r0, 0x4000
blr
