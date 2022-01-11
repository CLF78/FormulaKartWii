.include "asm_setup.S"

.extern TimeDiff, Speedometer
.extern TimeDiffPatchHook, _directWriteArray
.global TimeDiffPatch, TimeDiffPatch2, TimeDiffApply

########################
# Multiplayer Failsafe #
########################

# Get local player count
TimeDiffApply:
lis r4, Racedata@ha
lwz r4, Racedata@l(r4)
lbz r4, 0x26(r4)

# If multiplayer, skip
cmpwi r4, 1
bgt return

# Load 0x8000 in r31
lis r31, Speedometer@ha

# If speedometer is enabled, or with 0x1000
lbz r4, Speedometer@l(r31)
cmpwi r4, 1
bne noSpeedo
ori r3, r3, 0x1000

# If timediff is enabled or with 0x100
noSpeedo:
lbz r4, TimeDiff@l(r31)
subi r4, r4, 1
cmplwi r4, 1
bgt return
ori r3, r3, 0x100

# Original instruction
return:
mr r31, r3
blr

###########
# Patch 1 #
###########

# Check if the player is in 1st using cr7 so we can store the result for the next hook
TimeDiffPatch:
lwz r6, 0x18(r5)
lbz r7, 0(r6)
cmpw cr7, r3, r7
bne+ cr7, end

# If so, get the player in 2nd for the reference
lbz r3, 0x1(r6)

# Original instruction
end:
slwi r4, r3, 2
blr

###########
# Patch 2 #
###########

# r0 = timer offset
# r3 = argument for memcpy
# r4 = raceInfoPlayer
# r5 = raceInfoPlayers
# r6 = player in each position
# r7 = player in 1st

# Reuse check from the previous hook, as the RaceinfoPlayer is already in r4 in this case
TimeDiffPatch2:
beq+ cr7, skip

# Get the player we need based on the setting
lis r8, TimeDiff@ha
lbz r8, TimeDiff@l(r8)
cmpwi r8, 2
bne playerInFront

# Get RaceinfoPlayer of 1st place
slwi r4, r7, 2
b getRinfo

# Get our position
playerInFront:
lbz r4, 0x20(r4)

# Get player in front of us
subi r4, r4, 2
lbzx r4, r4, r6
slwi r4, r4, 2

# Get their RaceinfoPlayer
getRinfo:
lwzx r4, r4, r5

# Copy the correct timer to the stack using memcpy
skip:
lwz r4, 0x3C(r4)
add r4, r4, r0
li r5, 0xC
bl _directWriteArray

# Return later to skip the function call
b TimeDiffPatchHook+0x5C
