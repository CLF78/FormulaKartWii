.include "asm_setup.S"

.extern GameMode, PlayerHolder, OurFloats, RampUpHook, DriftSpeedHook4, DriftSpeedHook5, BoostAccelHook, Raceinfo
.global RampUp, RampUpSpeedFix, DriftSpeed1, DriftSpeed2, DriftSpeed3, DriftSpeed4, DriftSpeed5, BoostAccel, BoostAccel2, GetRampUp

####################
# Get Ramp Up Flag #
####################

# Check if game mode is not Ramp Up
GetRampUp:
lis r12, GameMode@ha
lbz r12, GameMode@l(r12)
cmpwi r12, 2
bne skip

# Get player id
lwz r12, 0(r11)
lbz r12, 0x10(r12)
slwi r12, r12, 2

# Get Raceinfo
lis r11, Raceinfo@ha
lwz r11, Raceinfo@l(r11)
lwz r11, 0xC(r11)
lwzx r11, r11, r12
lbz r11, 0x26(r11)

# Return value >= 20
subfic r11, r11, 19
subfe r11, r11, r11
neg r11, r11
b return

# Return 0
skip:
li r11, 0

# Do the cmpwi here because lazyness
return:
cmpwi r11, 0
blr

#####################
# Ramp Up Game Mode #
#####################

# Check if game mode matches
RampUp:
lis r3, GameMode@ha
lbz r3, GameMode@l(r3)
cmpwi r3, 2
bne+ end

# Run bl trick if so
bl trick

.float 0.0102040816
.float 220.0

# Load floats in f1 and f4
trick:
mflr r3
lfs f1, 0(r3)
lfs f4, 0x4(r3)

# Get player ID
lbz r3, 0x8(r29)
slwi r3, r3, 2

# Get current multiplier
lis r4, PlayerHolder@ha
lwz r4, PlayerHolder@l(r4)
lwz r4, 0x20(r4)
lwzx r3, r3, r4
lwz r4, 0x44(r3)
lfs f0, 0x10(r4)

# Add f1 to f0
fadds f2, f0, f1
stfs f2, 0x10(r4)

# Get stats
lwz r3, 0x1C(r3)
lwz r3, 0x14(r3)
lwz r3, 0(r3)

# Setup loop
addi r3, r3, 0x20
li r0, 4
mtctr r0

# Adjust acceleration stages
loop:
lfsu f3, 0x4(r3)
fdivs f3, f3, f0
fmuls f3, f3, f2
stfs f3, 0(r3)
bdnz+ loop

# Get baseSpeed and increase it
lfs f3, 0x14(r4)
fdivs f3, f3, f0
fmuls f3, f3, f2
stfs f3, 0x14(r4)

# Get hardSpeedLimit and increase it, unless it's the bullet bill speed
lfs f3, 0x2C(r4)
fcmpu cr0, f3, f4
beq+ end
fdivs f3, f3, f0
fmuls f3, f3, f2
stfs f3, 0x2C(r4)

# Original instruction
end:
lbz r3, 0x26(r29)
b RampUpHook+4

####################
# Max Speed Hotfix #
####################

# Multiply hard cap by current multiplier
# This will not affect regular races since the multiplier will always be 1.0
RampUpSpeedFix:
lfs f1, 0x10(r3)
fmuls f0, f0, f1

# Original instruction
stfs f0, 0x2C(r3)
blr

###################
# Drift Speed Sub #
###################

# Preload our floats
DriftSpeedSub:
lis r12, OurFloats@ha
lfs f11, OurFloats@l(r12)
lfs f10, DriftSpeedFloat@l(r12)

# Maths
fsubs f9, f11, f9
fmadds f0, f9, f10, f0
blr

#################
# Drift Speed 1 #
#################

# Original instruction
DriftSpeed1:
lfs f2, 0x20(r29)

# Load multiplier and call sub
lfs f9, 0x10(r29)
b DriftSpeedSub

#################
# Drift Speed 2 #
#################

# Original instruction
DriftSpeed2:
lfs f2, 0x20(r3)

# Load multiplier and call sub
lfs f9, 0x10(r3)
b DriftSpeedSub

#################
# Drift Speed 3 #
#################

# Original instruction
DriftSpeed3:
lfs f2, 0x20(r31)

# Load multiplier and call sub
lfs f9, 0x10(r31)
b DriftSpeedSub

#################
# Drift Speed 4 #
#################

# Original instruction
DriftSpeed4:
lfs f2, 0x20(r3)

# Preload our floats
lis r12, OurFloats@ha
lfs f11, OurFloats@l(r12)
lfs f10, DriftSpeedFloat@l(r12)
lfs f9, 0x10(r3)

# Maths
fsubs f9, f11, f9
fmadds f0, f9, f10, f0
b DriftSpeedHook4+4

#################
# Drift Speed 5 #
#################

# Original instruction
DriftSpeed5:
lfs f2, 0x20(r3)

# Preload our floats
lis r12, OurFloats@ha
lfs f11, OurFloats@l(r12)
lfs f10, DriftSpeedFloat@l(r12)
lfs f9, 0x10(r3)

# Maths
fsubs f9, f11, f9
fmadds f0, f9, f10, f0
b DriftSpeedHook5+4

######################
# Boost Acceleration #
######################

# Original instruction
BoostAccel:
lfsx f0, r7, r0

# Only act for boost type 0 (MT)
cmpwi r0, 0
bne+ end2

# Get multiplier unsafely and multiply boost acceleration
lfs f2, -0xF8(r3)
fmuls f0, f0, f2

end2:
b BoostAccelHook+4

########################
# Boost Acceleration 2 #
########################

# Original instruction
BoostAccel2:
lfsx f0, r7, r0

# Only act for boost type 0 (MT)
cmpwi r0, 0
bne+ end3

# Get multiplier unsafely and multiply boost acceleration
lfs f2, -0xF8(r3)
fmuls f0, f0, f2

end3:
b BoostAccelHook+0x74

########
# Data #
########

DriftSpeedFloat:
.float 0.6
