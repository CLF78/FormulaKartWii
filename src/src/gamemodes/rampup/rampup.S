.include "asm_setup.S"

.extern GameMode, PlayerHolder
.global RampUp, RampUpHook, RampUpSpeedFix

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

.float 0.01

# Load float in f1
trick:
mflr r3
lfs f1, 0(r3)

# Get player ID
lbz r3, 0x8(r29)
slwi r3, r3, 2

# Get current multiplier
lis r4, PlayerHolder@ha
lwz r4, PlayerHolder@l(r4)
lwz r4, 0x20(r4)
lwzx r4, r3, r4
lwz r4, 0x10(r4)
lwz r4, 0x10(r4)
lfs f0, 0x10(r4)

# Add f1 to f0
fadds f2, f0, f1
stfs f2, 0x10(r4)

# Get baseSpeed and increase it
lfs f3, 0x14(r4)
fdivs f3, f3, f0
fmuls f3, f3, f2
stfs f3, 0x14(r4)

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
