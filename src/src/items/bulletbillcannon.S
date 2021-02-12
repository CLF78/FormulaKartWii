.include "asm_setup.S"

.extern Racedata, ItemHolder, CannonSpeed2
.global StorePlayer, CannonSpeedMultiplier, CannonSpeedMultiplier2

###################
# Player ID Saver #
###################

# Store player ID in the stack (this particular spot will not be used until later in the function, so it's safe)
StorePlayer:
stb r3, 0x30(r1)

# Original instruction
lis r4, Racedata@ha
blr

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

# Get Player ID (stack was increased by 0xF0 between the player id save patch and this patch)
lbz r11, 0x120(r1)
mulli r11, r11, 0x248

# Load Bullet Bill Flag
lis r12, ItemHolder@ha
lwz r12, ItemHolder@l(r12)
lwz r12, 0x14(r12)
lwzx r12, r11, r12
lwz r12, 0x50(r12)
lwz r12, 0(r12)
lbz r4, 0x10C(r12)

# Check if it's on
cmpwi r4, 0
beq+ end

# Multiply float if so
fmuls f0, f0, f30

# No BLR because i did the bl trick and i cba to store the LR
end:
b CannonSpeed2+4

###########################
# Cannon Bill Speed Mod 2 #
###########################

# Original instruction
CannonSpeedMultiplier2:
lfs f7, 0(r29)

# Check if the bill flag is on
cmpwi r4, 0
beqlr+

# Multiply float if so (multiplier is still in f30, no need to load it again)
fmuls f7, f7, f30
blr
