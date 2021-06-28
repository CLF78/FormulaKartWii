.include "asm_setup.S"

.extern CannonSpeed
.global CannonSpeedMultiplier, CannonSpeedMultiplier2

###########################
# Cannon Bill Speed Mod 1 #
###########################

# BL Trick
CannonSpeedMultiplier:
bl float

.float 1.5

float:
mflr r12

# Original instruction
lfs f0, 0x14(r30)

# Load multiplier
lfs f30, 0(r12)

# Check if the player is in a bullet
lwz r12, 0(r30)
lwz r12, 0x4(r12)
lwz r12, 0xC(r12)
rlwinm. r4, r12, 5, 31, 31
beq+ end

# Multiply float if so
fmuls f0, f0, f30

# Divide by multiplier for Ramp Up
end:
lfs f29, 0x10(r30)
fdivs f0, f0, f29

# No BLR because i did the bl trick and i cba to store the LR
b CannonSpeed+4

###########################
# Cannon Bill Speed Mod 2 #
###########################

# Original instruction
CannonSpeedMultiplier2:
lfs f7, 0(r29)

# Check if the bill flag is on
cmpwi r4, 0
beq+ noBill

# Multiply float if so (multiplier is still in f30, no need to load it again)
fmuls f7, f7, f30

# Multiply with multiplier for Ramp Up (that one's in r29)
noBill:
fmuls f7, f7, f29
blr
