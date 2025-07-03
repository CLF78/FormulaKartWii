.include "asm_setup.S"

.extern BrakeDriftMainHook, BrakeDriftSoundHook, BrakeDriftEffBikesHook, BrakeDriftEffKartsHook
.extern PlayerGetControllerHolder, BrakeDriftEffFunc, BrakeDriftEffFunc2
.global BrakeDriftClassic, BrakeDriftGCN, BrakeDriftNunchuck, BrakeDriftWheel, BrakeDriftMain, BrakeDriftSound, BrakeDriftEffBikes, BrakeDriftEffKarts

#########################################
# Button Activator - Classic Controller #
#########################################

# Original instruction
BrakeDriftClassic:
ori r6, r6, 0x1

# (buttonRaw & (B | R)) == (B | R)
andi. r8, r3, 0x240
cmpwi r8, 0x240
bnelr+

# Enable flag
ori r6, r6, 0x10
blr

#####################################
# Button Activator - GCN Controller #
#####################################

# Original instruction
BrakeDriftGCN:
ori r8, r8, 0x1

# (buttonRaw & (B | R)) == (B | R)
andi. r4, r5, 0x220
cmpwi r4, 0x220
bnelr+

# Enable flag
ori r8, r8, 0x10
blr

###############################
# Button Activator - Nunchuck #
###############################

# Original instruction
BrakeDriftNunchuck:
ori r31, r31, 0x1

# (buttonRaw & (B | DOWN)) == (B | DOWN)
andi. r6, r3, 0x404
cmpwi r6, 0x404
bnelr+

# Enable flag
ori r31, r31, 0x10
blr

################################
# Button Activator - Wii Wheel #
################################

# Original instruction
BrakeDriftWheel:
ori r0, r0, 0x1

# (buttonRaw & (B | 1)) == (B | 1)
andi. r3, r4, 0x600
cmpwi r3, 0x600
bnelr+

ori r0, r0, 0x10
blr

#########################
# Enable Brake Drifting #
#########################

# Get ramp up flag
BrakeDriftMain:
lwz r11, 0(r29)
bl GetRampUp
bne return

# Check if we are brake drifting
rlwinm r3, r4, 0, 28, 31
cmpwi r3, 0xF
bne+ return

# Get the player's controllerHolder
mr r3, r29
bl PlayerGetControllerHolder

# Load buttonActions and check for flag 0x10
lhz r3, 0x2C(r3)
rlwinm. r3, r3, 0, 27, 27
beq end

# Otherwise do brake drift! This will not return
b BrakeDriftMainHook+0xA0

# Restore r4
end:
lwz r4, 0x4(r6)

# Original instruction
return:
rlwinm. r3, r4, 0, 31, 31
b BrakeDriftMainHook+4

#####################
# Brake Drift Sound #
#####################

# Original instruction
BrakeDriftSound:
rlwinm r27, r0, 30, 31, 31

# Get ramp up flag
lwz r11, 0(r3)
bl GetRampUp
bne return2

# Check if player is accelerating
rlwinm. r4, r0, 0, 0, 0
bne return2

# Check if player is on the ground
rlwinm. r4, r0, 0, 11, 11
bne return2

# Check if we are brake drifting
rlwinm r4, r0, 0, 27, 31
cmpwi r4, 0xF
bne+ return2

# Get the player's controllerHolder
bl PlayerGetControllerHolder

# Load buttonActions and check for flag 0x10
lhz r4, 0x2C(r3)
rlwinm. r4, r4, 0, 27, 27
beq return2

# Enable sound!
li r27, 0
li r28, 1
li r30, 0

# Restore r3 and return
return2:
mr r3, r5
b BrakeDriftSoundHook+4

#################################
# Brake Drift Particles - Bikes #
#################################

# Get playerPointers
BrakeDriftEffBikes:
lwz r3, 0x118(r30)

# Get ramp up flag
lwz r11, 0(r3)
bl GetRampUp
bne end3

# Reload playerPointers
lwz r5, 0(r3)

# Get the player's controllerHolder
bl PlayerGetControllerHolder

# Default value for thing
lbz r28, 0x15(r3)

# Check if we are brake drifting
lwz r5, 0x4(r5)
lwz r6, 0x4(r5)
rlwinm r5, r6, 0, 27, 31
cmpwi r5, 0xF
bne+ skip

# Load buttonActions and check for flag 0x10
lhz r5, 0x2C(r3)
rlwinm. r5, r5, 0, 27, 27
beq skip

# Check if player is accelerating
rlwinm. r5, r6, 0, 0, 0
bne skip

# Check if player is on the ground
rlwinm. r5, r6, 0, 11, 11
bne skip

# Set thing to 2 for next code
li r28, 2

# Load function if thing > 0
skip:
subic. r28, r28, 1
blt+ end3

# Array access
stb r28, 0x15(r3)
slwi r28, r28, 2
lis r12, BrakeDriftFuncs@h
ori r12, r12, BrakeDriftFuncs@l
lwzx r12, r12, r28

# Function call
mr r3, r30
lwz r4, 0x614(r30)
li r5, 0x19
li r6, 0x1A
li r7, 1
mtctr r12
bctrl

# Original instruction
end3:
addi r11, r1, 0xA0
b BrakeDriftEffBikesHook+4

##############################
# Brake Drift Effect - Karts #
##############################

# Get playerPointers
BrakeDriftEffKarts:
lwz r3, 0x118(r31)

# Get ramp up flag
lwz r11, 0(r3)
bl GetRampUp
bne end4

# Reload playerPointers
lwz r5, 0(r3)

# Get the player's controllerHolder
bl PlayerGetControllerHolder

# Default value for thing
lbz r28, 0x15(r3)

# Check if we are brake drifting
lwz r5, 0x4(r5)
lwz r6, 0x4(r5)
rlwinm r5, r6, 0, 27, 31
cmpwi r5, 0xF
bne+ skip2

# Load buttonActions and check for flag 0x10
lhz r5, 0x2C(r3)
rlwinm. r5, r5, 0, 27, 27
beq skip2

# Check if player is accelerating
rlwinm. r5, r6, 0, 0, 0
bne skip2

# Check if player is on the ground
rlwinm. r5, r6, 0, 11, 11
bne skip2

# Set thing to 2 for next code
li r28, 2

# Load function if thing > 0
skip2:
subic. r28, r28, 1
blt+ end4

# Array access
stb r28, 0x15(r3)
slwi r28, r28, 2
lis r12, BrakeDriftFuncs@h
ori r12, r12, BrakeDriftFuncs@l
lwzx r12, r12, r28

# Function calls
mr r3, r31
lwz r4, 0x530(r31)
li r5, 0x22
li r6, 0x23
li r7, 0
mtctr r12
bctrl

mr r3, r31
lwz r4, 0x530(r31)
li r5, 0x23
li r6, 0x24
li r7, 1
mtctr r12
bctrl

# Original instruction
end4:
lwz r0, 0x24(r1)
b BrakeDriftEffKartsHook+4

##############################
# Arrays For Function Access #
##############################

BrakeDriftFuncs:
.long BrakeDriftEffFunc2, BrakeDriftEffFunc
