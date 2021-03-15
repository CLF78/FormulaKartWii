.include "asm_setup.S"

.extern TimeStoreHook2, TimeStoreHook3, FinishTimesHook, GameMode, Racedata, EnableRampUpStuff
.global StartingLap, JingleFix, LapSignFix, LakituBoard, TimeStore, TimeStore2, TimeStore3, FinishTimes

#########################
# Starting Lap Modifier #
#########################

StartingLap:
li r28, -51
addi r29, r28, 1

#######################
# Starting Jingle Fix #
#######################

# Original instruction
JingleFix:
lbz r0, 0xDB(r29)

# Check that it's the first lap
cmpwi r31, 0xCE
bnelr+

# If so force a match
li r0, 0xCE
blr

################
# Lap Sign Fix #
################

# Original instruction
LapSignFix:
extsh r3, r5

# Fix maxLap
extsb r0, r0
blr

####################
# Lakitu Board Fix #
####################

# Add 49 to lap count
LakituBoard:
addi r12, r12, 49

# Push stack
stwu r1, -0x10(r1)

# Load first magic number
lis r11, 0x5980
ori r11, r11, 0x0004
stw r11, 0x8(r1)
lfs f31, 0x8(r1)

# Load second magic number
lis r11, 0x4330
xoris r12, r12, 0x8000
stw r11, 0x8(r1)
stw r12, 0xC(r1)
lfd f2, 0x8(r1)

# Convert
fsub f31, f2, f31
frsp f31, f31

# Pop stack and return
addi r1, r1, 0x10
blr

####################
# Time Storing Fix #
####################

# Fix current lap
TimeStore:
extsb r3, r3
addi r3, r3, 50

# Module division
li r5, 10
divw r5, r3, r5
mulli r5, r5, 10
subf r3, r5, r3
blr

######################
# Time Storing Fix 2 #
######################

# Check game mode
TimeStore2:
lis r6, GameMode@ha
lbz r6, GameMode@l(r6)
cmpwi r6, 2
bne+ keepGoing

# Check if lap < 25
cmplwi r4, 0xE0
blt keepGoing

# Get player id
lbz r6, 0x8(r3)

# Store byte
li r8, 1
lis r7, EnableRampUpStuff@h
ori r7, r7, EnableRampUpStuff@l
stbx r8, r7, r6

# Modified original instruction
keepGoing:
cmplwi r4, 0xCF

# Convert lap
extsb r4, r4
addi r4, r4, 50

# Module division
li r6, 10
divw r6, r4, r6
mulli r6, r6, 10
subf r4, r6, r4

# Add 1 (will be subtracted later)
addi r4, r4, 1
b TimeStoreHook2+4

######################
# Time Storing Fix 3 #
######################

# Original instruction
TimeStore3:
subi r6, r4, 2

# If the result is -1, loop back to 9
cmpwi r6, -1
bne+ end

li r6, 9

end:
b TimeStoreHook3+4

######################
# Finishing Time Fix #
######################

# Original instruction
FinishTimes:
lfs f0, 0xC(r3)

# Load our float in f3
bl trick

.float 4.0
.float 0.125

trick:
mflr r4
lfs f3, 0(r4)
lfs f4, 0x4(r4)

# Add them together
fmadds f0, f0, f4, f3
b FinishTimesHook+4
