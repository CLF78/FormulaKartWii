.include "asm_setup.S"

.extern ItemHolder, ItemStructs
.global AllItemsCanLand, NoItemLandingPoofASM

################################
# All Items Can Land Main Code #
################################
AllItemsCanLand:

# Mega
li r7, 0xB
b begin

# Golden
li r7, 0x4
b begin

# Feather
li r7, 0xC
b begin

# Bullet Bill
li r7, 0xF

# Push stack and save LR
begin:
stwu r1, -0x10(r1)
mflr r0
stw r0, 0x14(r1)

# Get player struct
lis r3, ItemHolder@ha
lwz r3, ItemHolder@l(r3)
lwz r3, 0x14(r3)
mulli r4, r24, 0x248
add r3, r3, r4

# Add 1 to current item amount
lwz r4, 0x90(r3)
addi r4, r4, 1
stw r4, 0x90(r3)

# Run the correct function
noAddItem:
lis r4, ItemStructs@h
ori r4, r4, ItemStructs@l
mulli r7, r7, 0x1C
lwzx r4, r4, r7
cmpwi r4, 0
beq return
mtctr r4
bctrl

# Return damage type -1
return:
li r3, -1

# Pop stack
lwz r0, 0x14(r1)
mtlr r0
addi r1, r1, 0x10
blr
