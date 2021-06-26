.include "asm_setup.S"

.extern TimeDiff, Speedometer
.extern TimerInstance, TimeDiffPatchHook2, Racedata, Raceinfo
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

# Last lap failsafe
TimeDiffPatch:
cmpwi r31, 0
bne+ continue

# Move r31 to r3 to force the compare result if it's the last lap
mr r3, r31
b end

# Load Racedata and Raceinfo
continue:
lis r12, Racedata@ha
lwz r9, Racedata@l(r12)
lwz r12, Raceinfo@l(r12)

# Load PlayerIDInEachPosition and my PlayerID
lwz r6, 0x18(r12)
lbz r7, 0(r6)
lbz r8, 0xB84(r9)

# Check if i am in 1st
cmpw r8, r7
beq inFirst

# Otherwise check which option is enabled
lis r11, TimeDiff@ha
lbz r11, TimeDiff@l(r11)
cmpwi r11, 2
beq diffWithFirst

# TimeDiff == 1 (diff with person in front)
slwi r8, r8, 2
lwz r12, 0xC(r12)
lwzx r12, r12, r8
lbz r8, 0x20(r12)
b end

# TimeDiff == 2 (diff with 1st Place)
diffWithFirst:
li r8, 2
b end

# I'm in first
inFirst:
li r8, 3

# Get second place's maxLap
lbz r12, 0x1(r6)
slwi r12, r12, 2
lwzx r12, r5, r12
lbz r31, 0x26(r12)

# Original instruction
end:
cmplw r3, r31
blr

###########
# Patch 2 #
###########

# r5 = RaceInfoPlayer
# r6 = PlayerIdInEachPosition
# r8 = Position+2

# Depending on the situation, get the ID of the player in 1st, 2nd or the one in front of me
TimeDiffPatch2:
subi r8, r8, 2
lbzx r8, r6, r8
slwi r8, r8, 2

# Load their raceinfo
lwzx r5, r5, r8

# Add the correct offset for the function that fills the laps
lwz r5, 0x3C(r5)

# Convert lap
extsb r4, r31
addi r4, r4, 50

# Module division
li r12, 10
divw r12, r4, r12
mulli r12, r12, 10
subf r4, r12, r4

# Prevent array underflow
subi r4, r4, 1
cmpwi r4, -1
bne+ multiply
li r4, 9

# Add the result to r5
multiply:
mulli r4, r4, 0xC
add r5, r5, r4

# Replace r4 with TimerInstance so that the function that fills the laps loads a null lap 1
lis r4, TimerInstance@h
ori r4, r4, TimerInstance@l

# Return
b TimeDiffPatchHook2+8
