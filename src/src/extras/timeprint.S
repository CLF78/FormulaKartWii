.include "asm_setup.S"

.extern Raceinfo, SetMatText, SubtractTimers, swprintf, SetTextSrc, DCFix, isOnlineRace
.global TimePrint, DCBugFix, NoTransitionASM

# Independently of the output, align the text to the right on the X axis
TimePrint:
lwz r7, 0x114(r3)
lwz r7, 0x8C(r7)
li r8, 5
stb r8, 0x100(r7)

# Load Raceinfo data that we need
lis r12, Raceinfo@ha
lwz r12, Raceinfo@l(r12)
lwz r11, 0x18(r12)
lwz r12, 0xC(r12)

# Check if the player we are processing is first place
lbz r7, 0(r11)
cmpw r7, r30
bne+ notFirst

# The player is first place, proceed with original function call (will not return)
b SetMatText

# Push stack
notFirst:
stwu r1, -0x30(r1)
mflr r0
stw r0, 0x34(r1)

# Load the player's raceinfo
slwi r8, r30, 2
lwzx r10, r8, r12

# Get the player's raceCompletion, and convert it to absolute int
lfs f0, 0xC(r10)
fabs f0, f0
fctiwz f0, f0
stfd f0, 0x8(r1)
lwz r6, 0xC(r1)

# Check if completion is more than one lap from the end
cmpwi r6, 1
bge printLapDistance

# Check if player got disconnected
lwz r8, 0x38(r10)
rlwinm. r8, r8, 28, 31, 31
bne printLapDistance

# Get time difference with 1st place
addi r3, r1, 0x20
lwz r4, 0x40(r10)
slwi r7, r7, 2
lwzx r5, r7, r12
lwz r5, 0x40(r5)
bl SubtractTimers

# Preload top half of r5
lis r5, MinutesDistance@h

# Get timer minutes
lhz r6, 0x24(r1)
cmpwi r6, 0
beq useSecondsDistance

# If minutes are not 0, use MinutesDistance (r6 was already set up)
ori r5, r5, MinutesDistance@l
lbz r7, 0x26(r1)
lhz r8, 0x28(r1)
b printText

# Else use SecondsDistance
useSecondsDistance:
ori r5, r5, SecondsDistance@l
lbz r6, 0x26(r1)
lhz r7, 0x28(r1)
b printText

# Print lap is the other option (r6 was already set up)
printLapDistance:
lis r5, LapDistance@h
ori r5, r5, LapDistance@l

# Default to "s"
addi r7, r5, 17

# Check if r6 is 1
cmpwi r6, 1
bne+ printText

# Add 1 to r7 if so
addi r7, r7, 1

# Call swprintf (all other arguments were separately set up)
printText:
addi r3, r1, 0x8
li r4, 0x18
bl swprintf

# Call setTextSrc (r6 doesn't matter)
lwz r3, 0x114(r31)
addi r3, r3, 0x8C
li r4, 0
addi r5, r1, 0x8
lwz r7, 0(r3)
bl SetTextSrc

# Pop stack and return
lwz r0, 0x34(r1)
mtlr r0
addi r1, r1, 0x30
blr

MinutesDistance:
.string16 "%+d:%002d.%003d"

SecondsDistance:
.string16 "%+d.%003d"

LapDistance:
.string16 "%+d Lap%s"

.align 2

# Skipped instruction
DCBugFix:
rlwinm r7, r0, 3, 0, 28

# Get raceCompletion
lfs f0, 0xC(r10)

# Get our float
lis r9, 0xC248
stw r9, 0x118(r1)
lfs f1, 0x118(r1)

# Do subtraction and return
fadds f0, f0, f1
b DCFix+0x34

# Original instruction
NoTransitionASM:
li r0, 0x258

# If it's an online race, return
lis r4, isOnlineRace@ha
lbz r4, isOnlineRace@l(r4)
cmpwi r4, 1
beqlr

# Else override with infinite time
li r0, 0xFFFF
blr
