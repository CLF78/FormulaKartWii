.include "asm_setup.S"

.global DisableWallride

# Original instruction
DisableWallride:
lwz r0, 0x4(r3)

# Check if we are hitting a wall
andi. r4, r0, 0x60
beqlr

# If so unset the jump pad bit
rlwinm r0, r0, 0, 2, 0
stw r0, 0x4(r3)
blr
