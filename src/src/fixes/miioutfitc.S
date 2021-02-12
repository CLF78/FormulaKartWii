.include "asm_setup.S"

.extern _directWrite32, MiiC
.global MiiOutfitCFix

# This actually does not save space but i'm too lazy to port all the addresses

# Save LR
MiiOutfitCFix:
mflr r5

# Setup loop
lis r3, MiiC@h
ori r3, r3, MiiC@l-0x18
li r4, 3
mtctr r4

# Load male mii pointer and subtract 0x18 to it
loop:
lwzu r4, 0x18(r3)
subi r4, r4, 0x18
bl _directWrite32

# Do the same with the female mii
addi r3, r3, 4
lwz r4, 0(r3)
subi r4, r4, 0x18
bl _directWrite32

# Restore r3 and continue the loop
subi r3, r3, 4
bdnz+ loop

# Return
mtlr r5
blr
