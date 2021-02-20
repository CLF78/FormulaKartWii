.include "asm_setup.S"

.extern BrakeDriftMainHook, BrakeDriftSoundHook, BrakeDriftEffBikesHook, BrakeDriftEffKartsHook
.extern EnableRampUpStuff, PlayerGetControllerHolder, DoBrakeDrift, BrakeDriftEffFunc, BrakeDriftEffFunc2
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

# Get PlayerSub10 -> playerPointers -> playerParams -> playerID
BrakeDriftMain:
lwz r12, 0(r29)
lwz r12, 0(r12)
lbz r12, 0x10(r12)

# Check if brake drifting should be enabled
lis r11, EnableRampUpStuff@h
ori r11, r11, EnableRampUpStuff@l
lbzx r11, r11, r12
cmpwi r11, 1
bne+ return

# Save r4 to r11
mr r11, r4

# Check playerSub1c -> bitfield0
rlwinm r3, r11, 0, 28, 31
cmpwi r3, 0xF
bne+ end

# Get the player's controllerHolder
mr r3, r29
bl PlayerGetControllerHolder

# Load buttonActions and check for flag 0x10
lhz r3, 0x2C(r3)
rlwinm. r3, r3, 0, 27, 27
beq end

# Otherwise do brake drift! This should theoretically not return
b DoBrakeDrift

# Restore r4
end:
mr r4, r11

# Original instruction
return:
rlwinm. r3, r4, 0, 31, 31
b BrakeDriftMainHook+4

#####################
# Brake Drift Sound #
#####################

# Original instruction
rlwinm r27, r0, 30, 31, 31

# Get PlayerSub10 -> playerPointers -> playerParams -> playerID
BrakeDriftSound:
lwz r12, 0x54(r29)
lwz r12, 0(r12)
lwz r12, 0(r12)
lbz r12, 0x10(r12)

# Check if brake drifting is enabled
lis r11, EnableRampUpStuff@h
ori r11, r11, EnableRampUpStuff@l
lbzx r11, r11, r12
cmpwi r11, 1
bne+ return2

# Backup registers
mr r10, r0
mr r11, r3
mr r12, r4

# Check playerSub1c -> bitfield0
rlwinm r5, r10, 0, 27, 31
cmpwi r5, 0xF
bne+ end2

# Get the player's controllerHolder
lwz r3, 0x18(r12)
bl PlayerGetControllerHolder

# Load buttonActions and check for flag 0x10
lhz r5, 0x2C(r3)
rlwinm. r5, r5, 0, 27, 27
beq end2

# Check if player is accelerating
rlwinm. r5, r10, 0, 0, 0
bne end2

# Check if player is on the ground
rlwinm. r5, r10, 0, 11, 11
bne end2

# Enable sound!
li r27, 0
li r28, 1
li r30, 0

# Restore registers
end2:
mr r4, r12
mr r3, r11
mr r0, r10

# Return!
return2:
b BrakeDriftSoundHook+4

#################################
# Brake Drift Particles - Bikes #
#################################

# Get playerPointers
BrakeDriftEffBikes:
lwz r3, 0x118(r30)
lwz r3, 0(r3)

# Check if brake drifting is enabled
lwz r12, 0(r3)
lbz r12, 0x10(r12)
lis r11, EnableRampUpStuff@h
ori r11, r11, EnableRampUpStuff@l
lbzx r11, r11, r12
cmpwi r11, 1
bne+ end3

# Check playerSub1c -> bitfield0
lwz r3, 0x4(r3)
lwz r6, 0x4(r3)
rlwinm r5, r6, 0, 27, 31
cmpwi r5, 0xF
bne+ notBrakeDrifting

# Get the player's controllerHolder
lwz r3, 0x18(r3)
bl PlayerGetControllerHolder

# Load buttonActions and check for flag 0x10
lhz r5, 0x2C(r3)
rlwinm. r5, r5, 0, 27, 27
beq notBrakeDrifting

# Check if player is accelerating
rlwinm. r5, r6, 0, 0, 0
bne notBrakeDrifting

# Check if player is on the ground
rlwinm. r5, r6, 0, 11, 11
bne notBrakeDrifting

# Stores something in the controllerHolder
li r5, 1
stb r5, 0x15(r3)

# Call the function
lis r29, BrakeDriftEffFunc@h
ori r29, r29, BrakeDriftEffFunc@l
b callFunc

# Check a thing in controllerHolder
notBrakeDrifting:
lbz r5, 0x15(r3)
cmpwi r5, 1
bne end3

# Store 0 to the thing if it's not 1
li r5, 0
stb r5, 0x15(r3)

# Call the function
lis r29, BrakeDriftEffFunc2@h
ori r29, r29, BrakeDriftEffFunc2@l

callFunc:
mr r3, r30
lwz r4, 0x614(r30)
li r5, 0x19
li r6, 0x1A
li r7, 1
mtctr r29
bctrl

# Original instruction
end3:
addi r11, r1, 0xa0
b BrakeDriftEffBikesHook+4

##############################
# Brake Drift Effect - Karts #
##############################

# Get playerPointers
BrakeDriftEffKarts:
lwz r3, 0x118(r31)
lwz r3, 0(r3)

# Check if brake drifting is enabled
lwz r12, 0(r3)
lbz r12, 0x10(r12)
lis r11, EnableRampUpStuff@h
ori r11, r11, EnableRampUpStuff@l
lbzx r11, r11, r12
cmpwi r11, 1
bne+ end4

# Check playerSub1c -> bitfield0
lwz r3, 0x4 (r3)
lwz r6, 0x4 (r3)
rlwinm r5, r6, 0, 27, 31
cmpwi r5, 0xF
bne+ notBrakeDrifting2

# Get the player's controllerHolder
lwz r3, 0x18(r3)
bl PlayerGetControllerHolder

# Load buttonActions and check for flag 0x10
lhz r5, 0x2C(r3)
rlwinm. r5, r5, 0, 27, 27
beq notBrakeDrifting2

# Check if player is accelerating
rlwinm. r5, r6, 0, 0, 0
bne notBrakeDrifting2

# Check if player is on the ground
rlwinm. r5, r6, 0, 11, 11
bne notBrakeDrifting2

# Store 1 somewhere in controllerHolder
li r5, 1
stb r5, 0x15(r3)

# Call functions
lis r29, BrakeDriftEffFunc@h
ori r29, r29, BrakeDriftEffFunc@l
b callFuncs

# Check if thing in controllerHolder is 1
notBrakeDrifting2:
lbz r5, 0x15(r3)
cmpwi r5, 1
bne end4

# Store 0 somewhere in controllerHolder
li r5, 0
stb r5, 0x15(r3)

# Call functions
lis r29, BrakeDriftEffFunc2@h
ori r29, r29, BrakeDriftEffFunc2@l

callFuncs:
mr r3, r31
lwz r4, 0x530(r31)
li r5, 0x22
li r6, 0x23
li r7, 0
mtctr r29
bctrl

mr r3, r31
lwz r4, 0x530(r31)
li r5, 0x23
li r6, 0x24
li r7, 1
mtctr r29
bctrl

# Original instruction
end4:
lwz r0, 0x24(r1)
b BrakeDriftEffKartsHook+4
