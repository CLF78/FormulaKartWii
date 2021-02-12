.include "asm_setup.S"

.global MegaSizeMod, FOVFix

###################
# Size Multiplier #
###################

# Original instruction
MegaSizeMod:
lfs f0, 0x184(r4)

# Load the left part of our custom float in f1
lis r5, 0x3FC0
stw r5, 0x184(r3)
lfs f1, 0x184(r3)

# Multiply
fmuls f0, f1, f0
blr

###########
# FOV Fix #
###########

# Original instruction
FOVFix:
lwz r4, 0x0(r28)

# Check if real player (maybe)
lwz r29, 0x24(r4)
cmpwi r29, 0
beqlr

# Check if player is in a Mega
lwz r3, 0x4(r4)
lwz r3, 0xC(r3)
rlwinm. r3, r3, 0, 16, 16
beqlr

# Store new FOV
lis r0, 0x4170
stw r0, 0x120(r29)
blr
