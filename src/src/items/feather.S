.include "asm_setup.S"

.extern SubtractItem, GenerateEVENT, isOnlineRace, ItemHolder, FeatherArray
.global FeatherFunc, FeatherSpeeds, FeatherOnlineFix, FeatherInvisWall, FeatherReset, FeatherReset2

# Push stack
FeatherFunc:
stwu r1, -0x10(r1)
mflr r0
stw r0, 0x14(r1)

# Get playerPointers
lwz r4, 0(r3)

# Update specialFloor in playerSub10
lwz r5, 0x28(r4)
lwz r6, 0x250(r5)
ori r6, r6, 4
stw r6, 0x250(r5)

# Get playerSub1c
lwz r5, 0x4(r4)

# Assume 7 and 1
li r7, 7
li r8, 1

# Check if we're on a halfpipe
lwz r6, 0x8(r5)
rlwinm. r6, r6, 18, 31, 31
beq+ notHalfpipe

# If so change jumpPad to the lowest possible one to prevent excessive airtime
li r7, 2

# Also don't allow going through invisible walls
li r8, 0

# Store result to jumpPadType
notHalfpipe:
stw r7, 0x78(r5)

# Allow tricking
li r6, 4
sth r6, 0xA6(r5)

# Update Feather status array
lis r4, FeatherArray@h
ori r4, r4, FeatherArray@l
lbz r5, 0x18(r3)
stbx r8, r4, r5

# Subtract 1 item
addi r3, r3, 0x88
li r4, 1
bl SubtractItem

# Check if online race
lis r5, isOnlineRace@ha
lbz r5, isOnlineRace@l(r5)
cmpwi r5, 1
bne+ end

# Check if player is not ONLINE_REAL_LOCAL
lbz r4, -0x6E(r3)
cmpwi r4, 1
beq+ end

# If so create an EVENT entry
lbz r4, -0x70(r3)
li r3, 10
bl GenerateEVENT

# Pop stack and return
end:
lwz r0, 0x14(r1)
mtlr r0
addi r1, r1, 0x10
blr

FeatherSpeeds:
.float 85.0
.float 85.0
.float 75.0

# Call the feather function rather than the original
FeatherOnlineFix:
lis r3, ItemHolder@ha
lwz r3, ItemHolder@l(r3)
lwz r3, 0x14(r3)
mulli r4, r4, 0x248
add r3, r3, r4
b FeatherFunc

# Original instruction
FeatherReset:
lwz r0, 0(r4)

# Preload PlayerPointers
lwz r28, 0x4(r3)

# Check if we are on the ground
lwz r27, 0x4(r28)
lwz r27, 0x4(r27)
rlwinm. r27, r27, 14, 31, 31
beqlr+

# Reset feather status
FeatherResetSub:
lis r27, FeatherArray@h
ori r27, r27, FeatherArray@l
lwz r28, 0(r28)
lbz r28, 0x10(r28)
li r29, 0
stbx r29, r27, r28
blr

# Original instruction
FeatherReset2:
lwz r8, 0x4(r3)

# Copy r8 into r28
mr r28, r8

# Call the sub
b FeatherResetSub

# Original instruction
FeatherInvisWall:
subi r23, r14, 0x4201

# Check if player is in a Feather
lwz r27, 0x4(r15)
lwz r27, 0(r27)
lbz r27, 0x10(r27)
lis r4, FeatherArray@h
ori r4, r4, FeatherArray@l
lbzx r27, r27, r4
cmpwi r27, 1
bnelr+

# Ignore invisible walls if so
subi r23, r23, 0x2000
blr
