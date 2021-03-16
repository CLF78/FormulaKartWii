.include "asm_setup.S"

.extern UtilRandomSeed, UtilRandom, Racedata, SabotageHook, GameMode, isOnlineRace, PlayerHolder, RKNetController
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

#############################
# Check Bit Helper Function #
#############################

checkBitHelper:
sraw r3, r4, r3
rlwinm r3, r3, 0, 31, 31
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
mr r3, r31
lwz r4, 0x292C(r28)
bl checkBitHelper

# If so start pid loop
cmpwi r3, 0
beq+ startPidLoop

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
stmw r28, 0x8(r1)
mr r31, r3
slwi r4, r4, 2

# Load players[player]->playerParams->statsBSP->stats
lwzx r28, r3, r4
lwz r28, 0x14(r28)
lwz r28, 0x14(r28)
lwz r28, 0(r28)

# Randomize miniturbo
li r3, 15
li r4, 41
bl UtilRandint
stw r3, 0x6C(r28)

# Pop stack and return
lmw r28, 0x8(r1)
lwz r0, 0x4(r1)
mtlr r0
addi r1, r1, 0x20
blr
