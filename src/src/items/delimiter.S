.include "asm_setup.S"

.extern ItemLimits
.global ItemLimitMod

# Get the array
ItemLimitMod:
lis r3, ItemLimitArray@h
ori r3, r3, ItemLimitArray@l-1

# Setup loop
lis r4, ItemLimits@h
ori r4, r4, ItemLimits@l-0x74
li r5, 15
mtctr r5

# Do the loop!
loop:
lbzu r30, 0x1(r3)
stwu r30, 0x74(r4)
bdnz+ loop

# Original instruction
li r30, 0
blr

# Order = Green Shell, Red Shell, Banana, Mushroom, Star, Blue Shell, Lightning, Fake Box, Mega Mushroom, Bob-omb, Blooper, POW Block, Golden Mushroom, Bullet Bill, Thunder Cloud
ItemLimitArray:
.byte 20, 20, 27, 12, 7, 3, 1, 27, 7, 7, 1, 1, 7, 7, 3
.align 2
