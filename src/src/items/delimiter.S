.include "asm_setup.S"

.extern ItemLimits
# .extern LaunchFunc
.global ItemLimitMod

# Get the array
ItemLimitMod:
lis r3, ItemLimitArray@h
ori r3, r3, ItemLimitArray@l-1

# Get the other array
lis r4, ItemLimits@h
ori r4, r4, ItemLimits@l-0x74

# Get yet another array
# lis r5, ItemLaunchModRequired@h
# ori r5, r5, ItemLaunchModRequired@l-1

# Load LaunchFunc address
# lis r6, LaunchFunc@h
# ori r6, r6, LaunchFunc@l

# Setup loop
li r7, 15
mtctr r7

# -1 for PTMF
# li r7, -1

# Store item limit
loop:
lbzu r30, 0x1(r3)
stwu r30, 0x74(r4)

# Check if we should replace the launch function
# lbzu r30, 0x1(r5)
# cmpwi r30, 1
# bne+ loopend

# Store LaunchFunc to PTMF if so
# stw r6, 0x1C(r4)
# stw r7, 0x18(r4)

# End loop
# loopend:
bdnz+ loop

# Original instruction
li r30, 0
blr

# Order = Green Shell, Red Shell, Banana, Mushroom, Star, Blue Shell, Lightning, Fake Box, Mega Mushroom, Bob-omb, Blooper, POW Block, Golden Mushroom, Bullet Bill, Thunder Cloud
ItemLimitArray:
.byte 20, 20, 27, 12, 7, 4, 1, 27, 7, 7, 7, 1, 7, 7, 4
.align 2

# Same order as above
# ItemLaunchModRequired:
# .byte 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0
# .align 2
