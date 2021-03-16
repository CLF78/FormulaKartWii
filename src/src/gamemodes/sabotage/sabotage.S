.include "asm_setup.S"

.extern UtilRandomSeed, UtilRandom, Racedata, SabotageHook, GameMode, isOnlineRace, PlayerHolder, RKNetController, KartParam, DriverParam
.global SabotageSetup, DoSabotage, RandomizeStats

##################
# Setup Function #
##################

# Restore r28 and execute original instruction
SabotageSetup:
li r28, 0
stw r28, 0x38(r3)

# Check game mode
lis r3, GameMode@ha
lbz r3, GameMode@l(r3)
cmpwi r3, 1
bne+ return

# Get selectid from RacedataSettings and set it as the seed
lis r3, Racedata@ha
lwz r3, Racedata@l(r3)
lwz r3, 0xB90(r3)
bl UtilRandomSeed

# Return
return:
b SabotageHook+4

##################################
# Vehicle Picker Helper Function #
##################################

PickVehicle:
mflr r12
li r3, 0
li r4, 36
bl UtilRandint
mulli r3, r3, 0x18C
add r3, r31, r3
mtlr r12
blr

#############################
# Clear Bit Helper Function #
#############################

clearBit:
li r5, -2
rlwnm r4, r5, r4, 0xFFFFFFFF
and r3, r4, r3
blr

###########################
# Set Bit Helper Function #
###########################

setBit:
li r5, 1
slw r4, r5, r4
or r3, r4, r3
blr

#################
# Main Function #
#################

# Push stack and save LR
DoSabotage:
stwu r1, -0x10(r1)
mflr r0
stw r0, 0x4(r1)

# Get PlayerHolder
lis r28, PlayerHolder@ha
lwz r28, PlayerHolder@l(r28)

# Check if race is online
lis r31, isOnlineRace@ha
lbz r31, isOnlineRace@l(r31)
cmpwi r31, 1
beq onlinePlayerGet

# Offline player loop
lbz r31, 0x24(r28)
mtctr r31

offlineLoop:
lwz r3, 0x20(r28)
mfctr r4
subi r4, r4, 1
bl RandomizeStats
bdnz+ offlineLoop
b end

# Online player loop
onlinePlayerGet:
lwz r29, 0x20(r28)
lis r28, RKNetController@ha
lwz r28, RKNetController@l(r28)
li r31, 0

# Check if aid is not disconnected
continueAidLoop:
b startPidLoop

# Keep the aid loop going when we're done
endAidLoop:
cmpwi r31, 11
addi r31, r31, 1
bne+ continueAidLoop
b end

# Setup pid loop
startPidLoop:
li r30, 0

# Check if pid's aid matches the current aid
continuePidLoop:
addi r12, r28, 0x2920
lbzx r12, r12, r30
cmpw r12, r31
bne+ endPidLoop

# If so randomize the player's stats
mr r3, r29
mr r4, r30
bl RandomizeStats

# Keep the pid loop going when we're done (an aid can have multiple pids!)
endPidLoop:
cmpwi r30, 11
addi r30, r30, 1
bne+ continuePidLoop
b endAidLoop

# Pop stack and return
end:
lwz r0, 0x4(r1)
mtlr r0
addi r1, r1, 0x10
blr

####################
# Stats Randomizer #
####################

# The real shit happens here! Push stack to get some free registers
RandomizeStats:
stwu r1, -0x20(r1)
mflr r0
stw r0, 0x4(r1)
stmw r27, 0x8(r1)
slwi r4, r4, 2

# Load kartParam and driverParam
lis r29, KartParam@ha
lwz r31, KartParam@l(r29)
lwz r30, DriverParam@l(r29)

# Load players[player]->playerParams
lwzx r27, r3, r4
lwz r29, 0x14(r27)

# Load playerParams->character
lwz r28, 0x8(r29)

# Fix Small Miis
subi r12, r28, 0x18
cmplwi r12, 5
bgt+ notMiiSmall
li r28, 0x18
b keepGoing

# Fix Medium Miis
notMiiSmall:
subi r12, r28, 0x1E
cmplwi r12, 5
bgt+ notMiiMedium
li r28, 0x19
b keepGoing

# Fix Large Miis
notMiiMedium:
subi r12, r28, 0x24
cmplwi r12, 5
bgt+ keepGoing
li r28, 0x1A

# Get the corresponding entry in DriverParam
keepGoing:
mulli r28, r28, 0x18C
add r30, r30, r28

# Load playerParams->statsBSP->stats
lwz r29, 0x14(r29)
lwz r29, 0(r29)

###################
# Randomize Speed #
###################

bl PickVehicle
lfs f1, 0x18(r3)
lfs f2, 0x18(r30)
fadds f1, f1, f2
stfs f1, 0x18(r29)

# This needs to be stored in PlayerSub10 too
lwz r28, 0x44(r27)
stfs f1, 0x14(r28)
stfs f1, 0x18(r28)
stfs f1, 0x1C(r28)

###########################
# Randomize Speed in Turn #
###########################

bl PickVehicle
lfs f1, 0x1C(r3)
lfs f2, 0x1C(r30)
fadds f1, f1, f2
stfs f1, 0x1C(r29)

##########################
# Randomize Acceleration #
##########################

bl PickVehicle

# A0
lfs f1, 0x24(r3)
lfs f2, 0x24(r30)
fadds f1, f1, f2
stfs f1, 0x24(r29)

# A1
lfs f1, 0x28(r3)
lfs f2, 0x28(r30)
fadds f1, f1, f2
stfs f1, 0x28(r29)

# A2-T3
addi r12, r3, 0x2C
lswi r3, r12, 20
addi r12, r29, 0x2C
stswi r3, r12, 20

##################################
# Randomize Acceleration in Turn #
##################################

bl PickVehicle

# A0
lfs f1, 0x40(r3)
lfs f2, 0x40(r30)
fadds f1, f1, f2
stfs f1, 0x40(r29)

# A1
lfs f1, 0x44(r3)
lfs f2, 0x44(r30)
fadds f1, f1, f2
stfs f1, 0x44(r29)

# T1
lfs f1, 0x48(r3)
stfs f1, 0x48(r29)

######################
# Randomize Handling #
######################

bl PickVehicle

# Manual
lfs f1, 0x4C(r3)
lfs f2, 0x4C(r30)
fadds f1, f1, f2
stfs f1, 0x4C(r29)

# Auto
lfs f1, 0x50(r3)
lfs f2, 0x50(r30)
fadds f1, f1, f2
stfs f1, 0x50(r29)

# Reactivity
lfs f1, 0x54(r3)
stfs f1, 0x54(r29)

###################
# Randomize Drift #
###################

bl PickVehicle

# Manual
lfs f1, 0x58(r3)
lfs f2, 0x58(r30)
fadds f1, f1, f2
stfs f1, 0x58(r29)

# Auto
lfs f1, 0x5C(r3)
lfs f2, 0x5C(r30)
fadds f1, f1, f2
stfs f1, 0x5C(r29)

# Reactivity
lfs f1, 0x60(r3)
stfs f1, 0x60(r29)

#######################
# Randomize Miniturbo #
#######################

bl PickVehicle
lwz r3, 0x6C(r3)
lwz r4, 0x6C(r30)
add r3, r3, r4
stw r3, 0x6C(r29)

###########################
# Randomize Offroad Speed #
###########################

bl PickVehicle

# 0x02
lfs f1, 0x78(r3)
lfs f2, 0x78(r30)
fadds f1, f1, f2
stfs f1, 0x78(r29)

# 0x03
lfs f1, 0x7C(r3)
lfs f2, 0x7C(r30)
fadds f1, f1, f2
stfs f1, 0x7C(r29)

# 0x04
lfs f1, 0x80(r3)
lfs f2, 0x80(r30)
fadds f1, f1, f2
stfs f1, 0x80(r29)

# 0x05
lfs f1, 0x84(r3)
lfs f2, 0x84(r30)
fadds f1, f1, f2
stfs f1, 0x84(r29)

##############################
# Randomize Offroad Handling #
##############################

bl PickVehicle

# 0x01
lfs f1, 0xF4(r3)
lfs f2, 0xF4(r30)
fadds f1, f1, f2
stfs f1, 0xF4(r29)

# 0x02
lfs f1, 0xF8(r3)
lfs f2, 0xF8(r30)
fadds f1, f1, f2
stfs f1, 0xF8(r29)

# 0x03
lfs f1, 0xFC(r3)
lfs f2, 0xFC(r30)
fadds f1, f1, f2
stfs f1, 0xFC(r29)

# 0x04
lfs f1, 0x100(r3)
lfs f2, 0x100(r30)
fadds f1, f1, f2
stfs f1, 0x100(r29)

# 0x05
lfs f1, 0x104(r3)
lfs f2, 0x104(r30)
fadds f1, f1, f2
stfs f1, 0x104(r29)

########################
# Randomize Drift Type #
########################

# Get PlayerSub1c
lwz r27, 0x20(r27)

# Get random number
li r3, 0
li r4, 101
bl UtilRandint
cmpwi r3, 70
bgt changeToAuto

##########
# Manual #
##########

# Clear the auto drift type from bitfield4
lwz r3, 0x14(r27)
li r4, 4
bl clearBit
stw r3, 0x14(r27)

# Clear bit 28 from bitfield0
lwz r3, 0x4(r27)
li r4, 28
bl clearBit
stw r3, 0x4(r27)
b finish

#############
# Automatic #
#############

# Set the auto drift type in bitfield4
changeToAuto:
lwz r3, 0x14(r27)
li r4, 4
bl setBit
stw r3, 0x14(r27)

# Unset drift state
li r3, 0
sth r3, 0xFC(r28)

# Clear bit 3 and 19 from bitfield0
lwz r3, 0x4(r27)
li r4, 3
bl clearBit
li r4, 19
bl clearBit
stw r3, 0x4(r27)

# Pop stack and return
finish:
lmw r27, 0x8(r1)
lwz r0, 0x4(r1)
mtlr r0
addi r1, r1, 0x20
blr
