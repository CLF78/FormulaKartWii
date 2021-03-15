.include "asm_setup.S"

.extern TimeDiff, TimerInstance, TimeDiffPatchHook2, Racedata, Raceinfo
.global TimeDiffMPFix, TimeDiffPatch, TimeDiffPatch2

###################
# Multiplayer Fix #
###################

# Load HudPlayerIDs[1]
TimeDiffMPFix:
lis r3, Racedata@ha
lwz r3, Racedata@l(r3)
lbz r3, 0xB85(r3)

# If there's at least player two, skip (result must be 1 for single player and 0 for splitscreen)
srwi. r3, r3, 7
blr

###########
# Patch 1 #
###########

# r5 = RaceInfoPlayer

# Last lap failsafe
TimeDiffPatch:
cmpwi r31, 255
bne+ continue

# Move r31 to r3 to force the compare result if it's the last lap
mr r3, r31
b end

# Load Racedata and Raceinfo
continue:
lis r6, Racedata@ha
lwz r9, Racedata@l(r6)
lwz r6, Raceinfo@l(r6)

# Load TimeDiff type
lis r11, TimeDiff@ha
lbz r11, TimeDiff@l(r11)

# Load PlayerIDInEachPosition and my PlayerID
lwz r6, 0x18(r6)
lbz r7, 0(r6)
lbz r8, 0xB84(r9)

# Check if i am in 1st
cmpw r8, r7
beq inFirst

# Otherwise check which option is enabled
cmpwi r11, 2
beq diffWithFirst

# TimeDiff == 1 (diff with person in front, UGLY)
lis r11, Raceinfo@ha
lwz r11, Raceinfo@l(r11)
lwz r11, 0xC(r11)
lwzx r11, r11, r8
lbz r8, 0x20(r11)
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
mulli r12, r12, 4
lwzx r12, r5, r12
lbz r31, 0x26(r12)

# If not equal, trigger the difference
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
mulli r8, r8, 4

# Load their raceinfo
lwzx r5, r5, r8

# Add the correct offset for the function that fills the laps
addi r5, r5, 0x74

# Convert lap
extsb r4, r31
addi r4, r4, 50

# Module division
li r12, 3
divw r12, r4, r12
mulli r12, r12, 3
subf r4, r12, r4

# Prevent array underflow
subi r4, r4, 1
cmpwi r4, -1
bne+ multiply
li r4, 2

# Add the result to r5
multiply:
mulli r4, r4, 0xC
add r5, r5, r4

# Replace r4 with TimerInstance so that the function that fills the laps loads a null lap 1
lis r4, TimerInstance@h
ori r4, r4, TimerInstance@l

# Return
b TimeDiffPatchHook2+8
