.include "asm_setup.S"

.extern GameMode, playerCount, isOnlineRace, Racedata, srand, rand, PlayerHolder, getPlayerById, getPlayerPosition, SpecialItemHook, ItemRainMainHook, Framerate, FramerateHook
.global ItemRainMain

################
# Sub Function #
################

# Turn the value into a range between -16384 and 16384
ItemRainSub:
cmpwi r3, 0x4000
blt noSubtract

subi r3, r3, 0x8000
extsh r3, r3

# Divide value by 2
noSubtract:
li r11, 2
divw r3, r3, r11

# Load first magic number
lis r11, 0x5980
ori r11, r11, 0x0004
stw r11, 0x8(r1)
lfs f1, 0x8(r1)

# Load second magic number
lis r11, 0x4330
xoris r3, r3, 0x8000
stw r11, 0x8(r1)
stw r3, 0xC(r1)
lfd f2, 0x8(r1)

# Convert and return
fsub f1, f2, f1
frsp f1, f1
blr

#######################
# Main Item Rain Code #
#######################

# Free registers: r28-r31, r0, r3, r11, r12, probably more

# Original instruction
ItemRainMain:
stw r0, 0x48(r29)

# Check GameMode
lis r28, GameMode@ha
lbz r28, GameMode@l(r28)
cmpwi r28, 1
bne+ end

# Get playerCount and multiply it by 2
lis r28, playerCount@ha
lbz r28, playerCount@l(r28)
slwi r28, r28, 1

# Module division
divw r29, r3, r28
mullw r28, r29, r28
subf r28, r28, r3

# Check if value is even
rlwinm. r29, r28, 0, 31, 31
bne end

# Divide value by 2
srwi r28, r28, 1

# Check if race is online
lis r29, isOnlineRace@ha
lbz r29, isOnlineRace@l(r29)
cmpwi r29, 0
beq notOnline

# The race is online, check if player is at the console
lis r29, Racedata@ha
lwz r29, Racedata@l(r29)
mulli r30, r28, 0xF0
addi r30, r30, 0x2E
lbzx r29, r29, r30
cmpwi r29, -1
beq+ end

# Get a random number based on TBL
notOnline:
mftbl r3
bl srand
bl rand

# Random item lookup table
bl itemtrick

# Golden Mushroom, POW Block, Bullet Bill, Bob-Omb, Mega Mushroom, Fake Item Box, Shock, Blue Shell, Mushroom, Banana, Red Shell (Green Shell uses whatever remains)
.short 0x200, 0x200, 0x200, 0xE00, 0xE00, 0xE00, 0x200, 0x400, 0x200, 0x600, 0x1800, 0x1800
.align 2

# Setup loop
itemtrick:
mflr r12
subi r12, r12, 2
li r10, 0
li r11, 12
mtctr r11

# Load halfword from lookup table and check if the value is less than the one in r3
loop:
lhzu r11, 0x2(r12)
add r10, r10, r11
cmpw r3, r10
blt exit
bdnz+ loop

# Use CTR as item once the loop is over
exit:
mfctr r30
cmpwi r30, 0xA
bne+ notBlooper

# Replace Blooper with Bullet Bill
li r30, 0xD

# Get player's position
notBlooper:
lis r3, PlayerHolder@ha
lwz r3, PlayerHolder@l(r3)
mr r4, r28
bl getPlayerById
bl getPlayerPosition

# Load positions
lfs f3, 0(r3)
lfs f4, 0x4(r3)
lfs f5, 0x8(r3)

# Add random value to X position
mftbl r3
bl srand
bl rand
bl ItemRainSub
fadds f3, f3, f1

# Add random value to Z position
mftbl r3
bl srand
bl rand
bl ItemRainSub
fadds f5, f5, f1

# Add 3000 to Y position
bl trick

# Y position
.float 3000.0

# Position (actual position will be written here)
.float 0.0, 0.0, 0.0

# Speeds (unchanged)
.float 0.0, -100.0, 0.0

trick:
mflr r12
lfs f1, 0(r12)
fadds f4, f4, f1

# Store positions
stfs f3, 0x4(r12)
stfs f4, 0x8(r12)
stfs f5, 0xC(r12)

# Setup arguments
lis r3, ItemHolder@ha
lwz r3, ItemHolder@l(r3)
mr r4, r30
addi r5, r12, 4
addi r6, r12, 0x10
mr r7, r28

# Custom argument to prevent randomizer from working
li r8, 0xDAD

# Call function (yes, i am lazy)
bl SpecialItemHook-0xC

# 30 FPS code
end:
lis r31, Framerate@ha
lbz r31, Framerate@l(r31)
cmpwi r31, 1
bne+ end

li r30, 2
lis r29, FramerateHook@ha
stb r30, FramerateHook@l(r29)

b ItemRainMainHook+4
