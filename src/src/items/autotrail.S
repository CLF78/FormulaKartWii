.include "asm_setup.S"

.extern RKNetItemHandler
.global ItemTrail

# Original instruction
ItemTrail:
lwz r30, 0x14(r6)

# Check if player is ONLINE_REAL_LOCAL
cmpwi r28, 1
beq onlinePlayer

# Get item amount
localPlayer:
lwz r4, -0x24(r27)
b itemChecks

# Get packet for playerId
onlinePlayer:
lis r3, RKNetItemHandler@ha
lwz r3, RKNetItemHandler@l(r3)
lbz r4, -0x9C(r27)
slwi r4, r4, 3
add r3, r3, r4

# Get the data we need
lbz r4, 0x17(r3)
srwi r4, r4, 6

# Check for Greens/Reds/Bananas/FIBs
itemChecks:
cmpwi r31, 3
ble quantCheck

# Check for Bombs
cmpwi r31, 6
beq quantCheck

# Check for Blue Shells
cmpwi r31, 7
bnelr+

# Check if it's more than 1, if not return
quantCheck:
cmpwi r4, 1
blelr+

# Check for bananas
cmpwi r31, 2
beq autoTrail

# Set type to circle
autoCircle:
li r30, 3
blr

# Set type to trail
autoTrail:
li r30, 2
blr
