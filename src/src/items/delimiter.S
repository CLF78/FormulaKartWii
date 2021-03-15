.include "asm_setup.S"

.extern ItemLimits
.global ItemLimitMod

# Choose the array based on game mode
ItemLimitMod:
lis r3, NormalItemLimitArray@h
ori r3, r3, NormalItemLimitArray@l-1

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
NormalItemLimitArray:
.byte 20, 20, 27, 12, 6, 4, 1, 27, 6, 9, 1, 1, 6, 6, 4
.align 2
