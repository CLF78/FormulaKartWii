.include "asm_setup.S"

.extern ItemHolder, ItemAssignerCall, ItemAssignerCall2, ItemAssignerHook4, ItemAssignerHook5, ItemStructsEX, ItemStructs, SubtractItem, SubtractItemFix, DestroyItem
.global ItemAssignerStackFix, ItemAssignerStackFix2, ItemAssigner2, ItemAssigner3, ItemAssigner4, ItemAssigner5, ItemUsageFix
.global LaunchFunc, SubtractItemFixFunc

###########################
# Hook 1 - Fix Stack Push #
###########################

ItemAssignerStackFix:
stwu r1, -0x40(r1)
mflr r0
stw r0, 0x44(r1)

############################
# Hook 2 - Item Setup Loop #
############################

# Original instruction
ItemAssigner2:
mr r31, r8

# Get item
lwz r9, 0(r26)

# Assume not crazy
li r10, 0

# Check if caller is the one we're looking for, plus preload the item value for the correct struct
lis r25, ItemAssignerCall@h
ori r25, r25, ItemAssignerCall@l+4
cmpw r0, r25
lwz r25, -0x8(r28)
beq crazyItemCheck

lis r25, ItemAssignerCall2@h
ori r25, r25, ItemAssignerCall2@l+4
cmpw r0, r25
lwz r25, 0x4(r28)
bne+ notCrazy

# Check if the item is crazy eight
crazyItemCheck:
cmpwi r25, 5
bne+ notCrazy

# Crazy eight confirmed! I repeat, crazy eight confirmed!
li r10, 1

# Setup loop
notCrazy:
mtctr r27
addi r11, r1, 0x7

# If crazy eight, generate random item
loop:
cmpwi r10, 0
beq+ notCrazy2

# Call function and move result to r9
#bl GenerateCrazyItem
#mr r9, r3
mfctr r25
addi r9, r25, 7

# Store result to stack
notCrazy2:
stbu r9, 0x1(r11)
bdnz+ loop

# Setup next loop - goes to Hook 4
li r25, 0
b ItemAssigner4

###########################
# Hook 3 - Modified Check #
###########################

# Modified check
ItemAssigner3:
lwz r9, 0x10(r26)
lwz r0, 0x8(r26)
add r3, r9, r25
cmpw r3, r0
ble +140
nop

###################
# Loop Subroutine #
###################

# Get ItemTable for current item
ItemAssignerSub:
lis r3, ItemHolder@ha
lwz r3, ItemHolder@l(r3)
addi r3, r3, 0x48
addi r4, r1, 0x8
lbzx r4, r4, r25
mulli r4, r4, 0x24
add r26, r3, r4
blr

###########################
# Hook 4 - First Loop Fix #
###########################

# Call subroutine
ItemAssigner4:
bl ItemAssignerSub

# Continue loop
addi r25, r25, 1
cmpw r25, r27
b ItemAssignerHook4+0x10

############################
# Hook 5 - Second Loop Fix #
############################

# Call subroutine
ItemAssigner5:
bl ItemAssignerSub

# Original instruction
lwz r3, 0x10(r26)
b ItemAssignerHook5+4

##########################
# Hook 6 - Fix Stack Pop #
##########################

ItemAssignerStackFix2:
lwz r0, 0x44(r1)
mtlr r0
addi r1, r1, 0x40

###########################
# Hook 7 - Fix Item Usage #
###########################

# Load the correct float for the item we are about to use
ItemUsageFix:
lis r3, ItemStructsEX@h
ori r3, r3, ItemStructsEX@l
lwz r4, 0x4(r27)
mulli r4, r4, 0x74
add r3, r3, r4
lfs f1, 0x44(r3)
blr

####################################################
# Launch Function Designed For Non-Throwable Items #
####################################################

# Push stack
LaunchFunc:
stwu r1, -0x10(r1)
mflr r0
stw r0, 0x14(r1)
stw r31, 0xC(r1)

# Backup item to r31
mr r31, r3

# Set PTMF to 0 in order to prevent this function from running again
li r4, 0
stw r4, 0x16C(r3)
stw r4, 0x170(r3)

# Store 1 to EVA to prevent subtraction of items
li r4, 1
lis r5, SubtractItemFix@ha
stb r4, SubtractItemFix@l(r5)

# Get object id
lwz r4, 0x4(r3)

# Check if it's a Golden Mushroom
cmpwi r4, 0xC
bne+ notGolden

# If so replace with Mushroom
li r4, 3

# Get associated item id using a lookup table (there is no way to get it otherwise!)
notGolden:
bl trick

.byte 0, 1, 2, 4, 9, 7, 8, 3, 0xB, 6, 0xC, 0xD, 0xA, 0xF, 0xE
.align 2

# Get the corresponding function
trick:
mflr r5
lbzx r4, r4, r5
mulli r4, r4, 0x1C
lis r12, ItemStructs@ha
ori r12, r12, ItemStructs@l
lwzx r12, r4, r12

# Argument 1 - ItemHolderPlayer
lis r4, ItemHolder@ha
lwz r4, ItemHolder@l(r4)
lwz r4, 0x14(r4)
lbz r5, 0x6C(r3)
mulli r5, r5, 0x248
add r3, r4, r5

# Call item function
mtctr r12
bctrl

# Destroy the item to prevent it dropping on the track
mr r3, r31
bl DestroyItem

# Pop stack and return
lwz r0, 0x14(r1)
lwz r31, 0xC(r1)
mtlr r0
addi r1, r1, 0x10
blr

########################
# Item Subtraction Fix #
########################

# Check if item should be subtracted
SubtractItemFixFunc:
lis r5, SubtractItemFix@ha
lbz r0, SubtractItemFix@l(r5)
cmpwi r0, 1
beq noSub

# Original instruction
lwz r0, 0x8(r3)
b SubtractItem+4

# Store 0 back and return
noSub:
li r0, 0
stb r0, SubtractItemFix@l(r5)
blr
