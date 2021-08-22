.include "asm_setup.S"

.extern ItemHolder, ItemAssignerCall, ItemAssignerHook4, ItemAssignerHook5, ItemStructsEX, ItemStructs, _directWrite32
.global ItemAssignerStackFix, ItemAssignerStackFix2, ItemAssigner2, ItemAssigner3, ItemAssigner4, ItemAssigner5, ItemUsageFix
.global SetupLaunchFunctions

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
lwz r9, -0xC(r28)

# Assume not crazy
li r10, 0

# Check if caller is the one we're looking for
lis r25, ItemAssignerCall@h
ori r25, r25, ItemAssignerCall@l+4
cmpw r0, r25
bne+ notCrazy

# Check if the item is crazy eight
cmpwi r9, 5
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
addi r9, r25, 4

# Store result to stack
notCrazy2:
stbu r9, 0x1(r11)
bdnz+ loop

# Setup next loop - goes to Hook 4
li r25, 0
b ItemAssignerHook4

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

# Get object id
LaunchFunc:
lwz r4, 0x4(r3)

# Check if it's a Golden Mushroom
cmpwi r4, 0xC
bne+ notGolden

# If so replace with Mushroom
li r4, 3

# Get associated item id using a lookup table (there is no way to get it otherwise!)
notGolden:
lis r5, ObjectToItem@h
ori r5, r5, ObjectToItem@l
lbzx r4, r4, r5
mulli r4, r4, 0x1C

# Get the corresponding function
lis r12, ItemStructs@ha
ori r12, r12, ItemStructs@l
lwzx r12, r4, r12

# Setup argument - ItemHolderPlayer
lis r4, ItemHolder@ha
lwz r4, ItemHolder@l(r4)
lwz r4, 0x14(r4)
lbz r5, 0x6C(r3)
mulli r5, r5, 0x248
add r3, r4, r5

# Call function - does not return
mtctr r12
bctr

ObjectToItem:
.byte 0, 1, 2, 4, 9, 7, 8, 3, 0xB, 6, 0xC, 0xD, 0xA, 0xF, 0xE
.align 2

##########################
# Setup Launch Functions #
##########################

# Save LR
SetupLaunchFunctions:
mflr r12

# Do bl trick
bl trick

# Items that need modifications
.byte 3, 4, 7, 8, 0xA, 0xC, 0xD
.align 2

# Setup loop - loop length
trick:
li r3, 7
mtctr r3

# Value to be written
lis r4, LaunchFunc@h
ori r4, r4, LaunchFunc@l

# Initial offset
lis r5, ItemStructsEX@h
ori r5, r5, ItemStructsEX@l+0x20

# Array to be used
mflr r6
subi r6, r6, 1

# Run loop
loop2:
lbzu r3, 0x1(r6)
mulli r3, r3, 0x74
add r3, r3, r5
bl _directWrite32
bdnz+ loop2

# Restore LR and return
mtlr r12
blr
