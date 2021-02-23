.include "asm_setup.S"

.extern GameMode
.global NoDrop

# Original instruction
NoDrop:
lbz r0, 0x29(r3)

# Don't do anything if game mode is item rain
lis r29, GameMode@ha
lbz r29, GameMode@l(r29)
cmpwi r29, 1
beqlr

# Get the player's item
lwz r29, 0x4(r3)

# Check for Shock
cmpwi r29, 8
beq doReplacement

# Check for POW
cmpwi r29, 0xD
bnelr+

doReplacement:
li r0, 1
blr
