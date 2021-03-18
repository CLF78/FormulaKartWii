.include "asm_setup.S"

.global ImperviousTCFunc


# Copied and edited from the original game, cba
ImperviousTCFunc:

# Load playerPointers and assume 1
lwz r4, 0(r3)
li r3, 1

# Load playerSub1c -> bitfield3
lwz r4, 0x4(r4)
lwz r4, 0xc(r4)

# Game's original compare
rlwinm r0, r4, 0x0, 0xc, 0xc
rlwimi. r0, r4, 0x0, 0x11, 0x12
bnelr

# Check passed!
li r3, 0
blr
