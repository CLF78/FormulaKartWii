.include "asm_setup.S"

.global NoDrop

# Original instruction
NoDrop:
lbz r0, 0x29(r3)

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
