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
lwz r4, -0x24(r27)
b itemChecks

# Get packet for playerId
onlinePlayer:
lis r3, RKNetItemHandler@ha
lwz r3, RKNetItemHandler@l(r3)
lbz r4, 0x10(r27)
slwi r4, r4, 3
add r3, r3, r4

# Get item amount from tail mode
lbz r4, 0x14(r3)
rlwinm r3, r4, 1, 30, 30
rlwinm r4, r4, 0, 30, 31
xor r4, r3, r4

# Check for Greens/Reds/Bananas/FIBs
itemChecks:
cmpwi r31, 3
ble quantCheck

# Check for Salty Six, Bombs and Blue Shells
# subi r3, r31, 5
# cmplwi r3, 2

# Check for Bombs and Blue Shells
subi r3, r31, 6
cmplwi r3, 1
bgtlr+

# Check if the amount is more than 1, if not return
quantCheck:
cmpwi r4, 1
blelr+

# Set type to trail by default
li r30, 2

# Return if item is banana
cmpwi r31, 2
beqlr

# Set type to trail otherwise
addi r30, r30, 1
blr
