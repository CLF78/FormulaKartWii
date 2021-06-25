.include "asm_setup.S"

.extern Racedata, Menudata, SystemManager, Raceinfo, PlayerHolder, ScreenHUD
.extern swprintf, SetTextSrc, SpeedoParseSkip
.global SpeedoUpdateASM, SpeedoTextParseASM, SpeedoNoPause

#########################
# Update Function Patch #
#########################

# Get HUD
SpeedoUpdateASM:
lis r28, ScreenHUD@ha
lwz r28, ScreenHUD@l(r28)

# Get text element
lwz r28, 0x5C(r28)
cmpwi r28, 0
beqlr

# Save LR
mflr r0

# BMG escape sequence for yellow text
bl trick
.short 0x001A, 0x0800, 0x0001, 0x0030

# The actual text
.string16 "%.2f km/h"
.align 2

# Push stack:
# + 0x8 needed by swprintf
# + 0x30 for the formatted string
# ---------------------------------
# = 0x40 after alignment
trick:
stwu r1, -0x40(r1)
stw r0, 0x44(r1)

# Set cr1+eq to store floats in the stack
crset 4 * cr1 + eq

# Buffer
addi r3, r1, 0x8

# String length
li r4, 0x1A

# String pointer
mflr r5

# Get local player id in r29
lis r29, Racedata@ha
lwz r29, Racedata@l(r29)
lbz r29, 0xB84(r29)

# Get PlayerSub10 in r31
lis r31, PlayerHolder@ha
lwz r31, PlayerHolder@l(r31)
lwz r31, 0x20(r31)
slwi r12, r29, 2
lwzx r31, r12, r31
lwz r31, 0x44(r31)

# Get vehicle speed
lfs f1, 0x20(r31)
bl swprintf

############################
# Formatted String Parsing #
############################

# Skip the bmg escape sequence
addi r4, r1, 0x0E

# Start loop
loop:
lhzu r3, 0x2(r4)
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
b loop

#############################
# Position/Size Adjustments #
#############################

# Check if adjustments are required
out:
lbz r3, 0x80(r28)
cmpwi r3, 0

# Preload function arguments in the relevant registers
lwz r3, 0x114(r28)
li r4, 0
addi r5, r1, 0x8
li r6, 2
lwz r7, 0(r3)

# Do the branch
beq+ skipAdjustments

# Make element visible - the regular way
stb r4, 0x80(r28)

##################
# Set X Position #
##################

# 16:9 Position = 120.0f
lis r11, 0x42F0

# Check if widescreen
lis r12, SystemManager@ha
lwz r12, SystemManager@l(r12)
lwz r12, 0x58(r12)
cmpwi r12, 1
beq+ widescreen

# 4:3 Position = -30.0f
lis r11, 0x41F0

# Store position
widescreen:
stw r11, 0x4C(r28)

##################
# Set Y Position #
##################

lis r11, 0xC37A
stw r11, 0x50(r28)

######################
# Set Text Alignment #
######################

# Alignment = Right
stb r6, 0x100(r7)

##################
# Set Visibility #
##################

# Default value
skipAdjustments:
li r11, 0

# Disable the text when respawning
lwz r12, 0(r31)
lwz r12, 0x30(r12)
lhz r12, 0x48(r12)
cmpwi r12, 0
bne hide

# Disable the text if the race has ended
lis r12, Raceinfo@ha
lwz r12, Raceinfo@l(r12)
lwz r12, 0x28(r12)
cmpwi r12, 2
beq+ noHide

hide:
li r11, 1

# Store result
noHide:
stb r11, 0x85(r3)

###################
# SetTextSrc Call #
###################

# Call function
bl SetTextSrc

# Pop stack and return
lwz r0, 0x44(r1)
mtlr r0
addi r1, r1, 0x40
blr

###############
# Text Parser #
###############

# Check if custom text is enabled
SpeedoTextParseASM:
cmpwi r4, 0
bne original

# Load the custom string
stw r5, 0x20(r1)
li r5, 1
stw r5, 0x10(r1)

# Jump to the end of the BMG loading stuff. This will not return
b SpeedoParseSkip

# Original instructions (the lwz was nopped, so the result of the cmpwi was also wrong)
original:
lwz r0, 0(r4)
cmpwi r0, 0
blr

################################
# Disable Speedometer on Pause #
################################

# Get if game is paused
SpeedoNoPause:
lis r12, Menudata@ha
lwz r12, Menudata@l(r12)
lwz r12, 0(r12)
lbz r12, 0x38B(r12)

# Load screen element
lis r11, ScreenHUD@ha
lwz r11, ScreenHUD@l(r11)
lwz r11, 0x5C(r11)

# Skip if ptr is null, otherwise store value
cmpwi r11, 0
beq doNothing
stb r12, 0x85(r11)

# Original instruction
doNothing:
lfs f0, 0x80(r3)
blr
