.if (REGION == 'P')
	.set ItemHolder, 0x809C3618
	.set ItemStructs, 0x809C36B8
.elseif (REGION == 'U')
	.set ItemHolder, 0x809BEE20
	.set ItemStructs, 0x809BEEB0
.elseif (REGION == 'J')
	.set ItemHolder, 0x809C2678
	.set ItemStructs, 0x809C2718
.elseif (REGION == 'K')
	.set ItemHolder, 0x809B1C58
	.set ItemStructs, 0x80893E78
.else
    .err
.endif

# Mega
li r7, 0xB
b begin

# Golden
li r7, 0xA
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
li r3, -0x1
lwz r0, 0x14(r1)
mtlr r0
addi r1, r1, 0x10
blr

#ENDCODE

#SETTYPE COMPILED
#SETREGION P
047A66C4 60000000
04796D30 38600000
08790EF0 39800001
20030004 FFE00000
048B54D0 80001600
048B5500 80001608
048B550C 80001610
#ENDCODE

#SETREGION U
0479D6B8 60000000
0478DD24 38600000
08787EE4 39800001
20030004 FFE00000
048B0D98 80001600
048B0DC8 80001608
048B0DD4 80001610
#ENDCODE

#SETREGION J
047A5D30 60000000
0479639C 38600000
0879055C 39800001
20030004 FFE00000
048B4630 80001600
048B4660 80001608
048B466C 80001610
#ENDCODE

#SETREGION K
04794A84 60000000
047850F0 38600000
0877F2B0 39800001
20030004 FFE00000
048A3948 80001600
048A3978 80001608
048A3984 80001610
#ENDCODE
