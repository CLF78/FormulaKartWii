.include "asm_setup.S"

.global ItemTrail

# Original instruction
ItemTrail:
lwz r30, 0x14(r6)

# Get current item
lwz r3, -0x28(r27)

# Check for Greens/Reds/Bananas/FIBs
cmpwi r3, 3
ble quantCheck

# Check for Bombs
cmpwi r3, 6
beq quantCheck

# Check for Blue Shells
cmpwi r3, 7
bnelr+

# Get current item amount
quantCheck:
lwz r4, -0x24(r27)

# Check if it's more than 1, if not return
cmpwi r4, 1
blelr+

# Check for bananas
cmpwi r3, 2
beq autoTrail

# Set type to circle
autoCircle:
li r30, 3
blr

# Set type to trail
autoTrail:
li r30, 2
blr
