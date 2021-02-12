.include "asm_setup.S"

.global NoTeamInv

# Clear team bit (2)
NoTeamInv:
rlwinm r7, r7, 0, 31, 29

# Original instruction
stw r7, 0xB90(r31)
blr
