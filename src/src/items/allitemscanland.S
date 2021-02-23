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
li r7, 0xA
b begin

# Bullet Bill
li r7, 0xF
b begin

# Shock
li r7, 0x8
b begin

# POW
li r7, 0xD

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

# Get current item amount and check that the item is a golden
lwz r4, 0x90(r3)
cmpwi r7, 0xA
bne+ addItem

# Get current item
lwz r5, 0x8C(r3)

cmpwi r5, 2
ble tripleItems

cmpwi r5, 3
beq tripleFIBs

cmpwi r5, 4
bne+ quantCheck

# Mushrooms go to Triple Mushrooms
li r5, 5
b storeItem

# Bananas/Shells go to the triple counterpart
tripleItems:
addi r5, r5, 0x10
b storeItem

# FIBs go to Triple FIBs
tripleFIBs:
li r5, 0xC

storeItem:
stw r5, 0x8C(r3)

quantCheck:
cmpwi r4, 3
bge noAddItem

addItem:
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

# Pop stack
return:
li r3, -1
lwz r0, 0x14(r1)
mtlr r0
addi r1, r1, 0x10
blr

#####################
# Item Struct Patch #
#####################
NoItemLandingPoofASM:
li r12, 1
li r11, 1
li r10, 1
li r9, 1
