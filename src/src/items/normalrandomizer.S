.include "asm_setup.S"

.extern RandomNextLimited, RandomInstance, Raceinfo, ItemAmountArray
.global UltimateRandom

# Push stack
UltimateRandom:
stwu r1, -0x20(r1)
mflr r0
stw r0, 0x24(r1)
stmw r28, 0xC(r1)

# Backup some important registers
mr r31, r3
mr r30, r8

# Assume newbie helper off
li r29, 0

# Check if player is human
cmpwi r26, 1
bne+ getRandom

# Load Raceinfo
lis r4, Raceinfo@ha
lwz r4, Raceinfo@l(r4)

# Get raceCompletion for player in 1st
lwz r5, 0x18(r4)
lbz r5, 0(r5)
slwi r5, r5, 2
lwz r4, 0xC(r4)
lwzx r5, r5, r4
lfs f0, 0xC(r5)

# Get raceCompletion for currentPlayer
lbz r5, 0x18(r30)
slwi r5, r5, 2
lwzx r5, r5, r4
lfs f1, 0xC(r5)

# Get immediate value for compare
lis r6, 0x3F80
stw r6, 0x1C(r1)
lfs f2, 0x1C(r1)

# Subtract and compare
fsubs f0, f0, f1
fcmpu cr0, f0, f2
ble+ getRandom

# Newbie Helper required!
li r29, 1

# Get random number
getRandom:
lis r3, RandomInstance@h
ori r3, r3, RandomInstance@l

# Get amount of possible items
notHuman:
li r4, 0x13
cmpwi r29, 0
beq+ rand
li r4, 0xa

# Call function
rand:
bl RandomNextLimited

# If Newbie Helper is on, add 6
cmpwi r29, 0
beq+ noNewb
addi r3, r3, 6
b noDecrease

# Skip value 5
noNewb:
cmpwi r3, 0x5
blt noIncrease
addi r3, r3, 1

# Subtract 0x10 for values 16 and above
noIncrease:
cmpwi r3, 0x10
blt+ noDecrease
subi r3, r3, 0x10

# If blue, check blue timer
noDecrease:
cmpwi r3, 0x7
bne+ notBlue
lwz r4, 0x38(r31)
cmpwi r4, 0
bne getRandom

# If shock, check shock timer
notBlue:
cmpwi r3, 0x8
bne+ notShock
lwz r4, 0x34(r31)
cmpwi r4, 0
bne getRandom

# If pow, check pow timer
notShock:
cmpwi r3, 0xD
bne+ notPow
lwz r4, 0x40(r31)
cmpwi r4, 0
bne getRandom

# Save chosen item
notPow:
mr r28, r3

# Call random function
lis r3, RandomInstance@h
ori r3, r3, RandomInstance@l
li r4, 100
bl RandomNextLimited

# Assume new amount to be 1
li r6, 1

# Setup chances array
mulli r29, r29, 38
slwi r5, r28, 1
lis r4, ChancesArray@h
ori r4, r4, ChancesArray@l
add r4, r4, r29
add r4, r4, r5

# Check double chance
lbz r5, 0(r4)
cmpw r3, r5
blt+ end
addi r6, r6, 1

# Check triple chance
lbz r5, 0x1(r4)
cmpw r3, r5
blt+ end
addi r6, r6, 1

# Store amount and return item
end:
lis r4, ItemAmountArray@h
ori r4, r4, ItemAmountArray@l
lbz r5, 0x18(r30)
stbx r6, r4, r5
mr r3, r28

# Pop stack and return
lwz r0, 0x24(r1)
lmw r28, 0xC(r1)
mtlr r0
addi r1, r1, 0x20
blr

# Regular Items
ChancesArray:

# Green Shell
.byte 34,67

# Red Shell
.byte 34,67

# Banana
.byte 34,67

# FIB
.byte 34,67

# Mushroom
.byte 34,67

# Triple Mushroom (UNUSED)
.byte -1,-1

# Bomb
.byte 95,99

# Blue Shell
.byte 95,99

# Shock
.byte 95,99

# Star
.byte 85,95

# Golden
.byte 95,99

# Mega
.byte 85,95

# Feather
.byte 85,95

# POW
.byte 95,99

# TC (SINGLE ONLY)
.byte -1,-1

# Bullet Bill
.byte 95,99

# Triple Banana (UNUSED)
.byte -1,-1

# Triple Green (UNUSED)
.byte -1,-1

# Triple Red (UNUSED)
.byte -1,-1

# Newbie Helper Items

# Green Shell
.byte -1,-1

# Red Shell
.byte -1,-1

# Banana
.byte -1,-1

# FIB
.byte -1,-1

# Mushroom
.byte -1,-1

# Triple Mushroom (UNUSED)
.byte -1,-1

# Bomb
.byte 85,95

# Blue Shell
.byte 85,95

# Shock
.byte 95,99

# Star
.byte 34,67

# Golden
.byte 85,95

# Mega
.byte 34,67

# Feather
.byte 34,67

# POW
.byte 95,99

# TC (SINGLE ONLY)
.byte -1,-1

# Bullet Bill
.byte 95,99

# Triple Banana (UNUSED)
.byte -1,-1

# Triple Green (UNUSED)
.byte -1,-1

# Triple Red (UNUSED)
.byte -1,-1
.align 2
