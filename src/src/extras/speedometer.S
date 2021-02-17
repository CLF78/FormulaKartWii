.include "asm_setup.S"

.extern Racedata, Menudata, swprintf, SystemManager, SetTextSrc, SpeedoUpdate, SpeedoString, SpeedoParseSkip
.global SpeedoScreenElementASM, SpeedoUpdateASM, SpeedoTextParseASM

######################################
# Force Speedometer ScreenElement On #
######################################

# Original instruction
SpeedoScreenElementASM:
rlwinm. r0, r16, 0, 19, 19

# Skip if element is already scheduled for construction
bnelr

# Load current screen
lwz r3, 0x4(r15)

# Check for Offline VS
cmpwi r3, 0xE
beq invert

# Check for Online WW
cmpwi r3, 0x40
beq invert

# Check for Online Froom
cmpwi r3, 0x42
bnelr

# Force CR0's EQ bit on
invert:
crnot 4*cr0 + eq, 4*cr0 + eq
blr

#########################
# Update Function Patch #
#########################

SpeedoUpdateASM:
bl trick

# BMG escape sequence for yellow text
.short 0x001A, 0x0800, 0x0001, 0x0030

# The actual text
.string16 "%.2f km/h"
.align 2

# Get PlayerSub10 -> playerPointers -> playerParams -> playerID
trick:
lwz r6, 0(r29)
lwz r3, 0(r6)
lbz r3, 0x10(r3)

# Get HudPlayerIDs[0] from Racedata
lis r30, Racedata@ha
lwz r4, Racedata@l(r30)
lbz r4, 0xB84(r4)

# Check if the values match
cmpw r3, r4
bne+ end

# Check current screen
lwz r3, Menudata@l(r30)
lwz r3, 0(r3)

# Offline VS
lwz r28, 0x40(r3)
cmpwi r28, 0
bne found

# Online WW
lwz r28, 0x108(r3)
cmpwi r28, 0
bne found

# Online Friend Room
lwz r28, 0x110(r3)
cmpwi r28, 0
beq end

##################
# Setup swprintf #
##################

# Push stack:
# 0x8 needed by swprintf
# 0x30 for the formatted string
found:
addi r1, r1, -0x40

# Set CR1+EQ to store floats in the stack
crset 4 * cr1 + eq

# Destination
addi r3, r1, 0x8

# String length
li r4, 0x1A

# String pointer
mflr r5

# Get playerPointers -> playerGraphics -> playerPhysicsHolder -> playerPhysics -> speedNorm
lfs f1, 0x20(r29)
bl swprintf

############################
# Formatted String Parsing #
############################

# Skip the bmg escape sequence
addi r4, r1, 0x10

# Start loop
loop:
lhz r3, 0(r4)
cmpwi r3, 0
beq out

# Check for dash
cmpwi r3, 0x2D
bne notDash
li r3, 0x246D

# Check for dot
notDash:
cmpwi r3, 0x2E
bne notDot
li r3, 0x246B

# Check for digit
notDot:
subi r5, r3, 0x30
cmplwi r5, 9
bgt+ notDigit
addi r3, r3, 0x2430

# Continue the loop
notDigit:
sth r3, 0(r4)
addi r4, r4, 2
b loop

################
# Set Position #
################

# Get screen_hud -> ghostSaveInfoText
out:
lwz r3, 0x5C(r28)

# 30.0 for 4:3, 120.0 for 16:9
lis r4, 0x42F0

# Check if widescreen
lis r6, SystemManager@ha
lwz r6, SystemManager@l(r6)
lwz r6, 0x58(r6)
cmpwi r6, 1
beq+ widescreen

# Set it for 4:3
lis r4, 0x41F0

# Store it
widescreen:
stw r4, 0x4C(r3)

##################
# Set Visibility #
##################

# Set element visible
li r4, 0
stb r4, 0x80(r3)

######################
# Set Text Alignment #
######################

# Align the text to the right
li r6, 2
lwz r3, 0x114(r3)
lwz r7, 0(r3)
stb r6, 0x100(r7)

###################
# SetTextSrc Call #
###################

# Set remaining arguments and call the function
addi r5, r1, 0x8
bl SetTextSrc

# Pop stack
addi r1, r1, 0x40

# Original instruction
end:
lwz r31, 0x7C(r1)
b SpeedoUpdate+4

###############
# Text Parser #
###############

# Check if custom text is enabled
SpeedoTextParseASM:
cmpwi r4, 0
bne return

# Some registers are initialized in the middle of the BMG loading stuff we are skipping, so we have to do it here instead
lis r8, 0x4330
stw r8, 0x70(r1)
stw r8, 0x78(r1)
mr r18, r3
li r19, 0
lis r24, SpeedoString@ha
addi r24, r24, SpeedoString@l

# Load the custom string
stw r5, 0x20(r1)
li r5, 1
stw r5, 0x10(r1)

# Jump to the end of the BMG loading stuff
b SpeedoParseSkip

# Original instruction
return:
lwz r0, 0(r4)
blr
