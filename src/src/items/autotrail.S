.include "asm_setup.S"

.global ItemTrail

# Original instruction
ItemTrail:
lwz r30, 0x14(r6)

# Get current item
lwz r3, -0x28(r27)

# Check for Bombs
cmpwi r3, 6
beq quantCheck

# Check for Blue Shells
cmpwi r3, 7

# No need to check for Shells/Bananas/FIBs, as those were converted to the triple item directly.
bnelr+

# Get current item amount
quantCheck:
lwz r3, -0x24(r27)

# Check if it's more than 1. If not, return
cmpwi r3, 1
blelr+

# Set trail type to circle
doAutoTrail:
li r30, 3
blr
