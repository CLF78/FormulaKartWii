.include "asm_setup.S"

.extern PlayerHolder, ItemStatusArray, DynamicSizingHook4Helper, DynamicSizingHook4, BlueExplosionFunc
.global DynamicSizing, DynamicSizing2, DynamicSizing3, DynamicSizing4Helper, DynamicSizing4, DynamicSizing5, DynamicSizing6, DynamicSizing7
.global BombVisualSize, BombVisualSize2, BombSize, BombSize2, BlueVisualSize, BlueSize, BlueSize2
.global OurFloats

##############
# Function 1 #
##############

# Load item status (status goes in r12)
DynamicSub:
lis r11, ItemStatusArray@h
ori r11, r11, ItemStatusArray@l
lbzx r12, r11, r12

# Load correct float based on status
slwi r12, r12, 2
lis r11, OurFloats@h
ori r11, r11, OurFloats@l-4
lfsx f2, r11, r12

# Multiply
fmuls f1, f1, f2
blr

##############
# Function 2 #
##############

# Get item status
DynamicSub2:
lis r11, ItemStatusArray@h
ori r11, r11, ItemStatusArray@l
lbzx r12, r11, r12

# Load correct float based on status
slwi r12, r12, 2
lis r11, OurFloats@h
ori r11, r11, OurFloats@l-4
lfsx f3, r11, r12

# Multiply
fmuls f2, f2, f3
blr

##########
# Hook 1 #
##########

# Original instruction
DynamicSizing:
lfs f1, 0x48(r5)

# Check if caller is for blue explosion and skip if so
lwz r4, 0x14(r1)
lis r5, BlueExplosionFunc@h
ori r5, r5, BlueExplosionFunc@l+4
cmpw r4, r5
beqlr

# Restore status to 0
lis r4, ItemStatusArray@h
ori r4, r4, ItemStatusArray@l
lhz r5, 0x8(r31)
li r6, 0
stbx r6, r4, r5
blr

################
# Hook 2 and 3 #
################

# Original instruction
DynamicSizing2:
lfs f1, 0x48(r7)

# Get item status
lhz r12, 0x8(r28)
b DynamicSub

#################
# Hook 4 Helper #
#################

# Save our beloved r3
DynamicSizing4Helper:
mr r12, r3

# Original instruction
cmpwi r4, 0
b DynamicSizingHook4Helper+4

##########
# Hook 4 #
##########

# Original instruction
DynamicSizing4:
lfs f1, 0x48(r3)

# Get item status
lhz r12, 0x8(r12)

# Save LR
mflr r4

# Call sub
bl DynamicSub

# Restore LR and return
mtlr r4
b DynamicSizingHook4+4

##########
# Hook 5 #
##########

# Original instruction
DynamicSizing5:
lfs f2, 0x48(r3)

# Get item status
lhz r12, 0x8(r29)

# Call sub
b DynamicSub2

##########
# Hook 6 #
##########

# Original instruction
DynamicSizing6:
lfs f2, 0x48(r3)

# Get item status
lhz r12, 0x8(r29)

# Call sub
mflr r0
bl DynamicSub2
mtlr r0

# Check if growing size needs to be changed
cmpwi r12, 4
blelr+

# If so just overwrite f1 with f2
fmr f1, f2
blr

##########
# Hook 7 #
##########

# Preload status array in r29
DynamicSizing7:
lis r29, ItemStatusArray@h
ori r29, r29, ItemStatusArray@l

# Check if status was already set, and if so return
lhz r11, 0x8(r3)
lbzx r0, r11, r29
cmpwi r0, 0
bne+ end

# Assume no mod required
li r0, 1

# Get playerId
lbz r7, 0x6C(r3)
slwi r7, r7, 2

# Get the related PlayerHolder
lis r11, PlayerHolder@ha
lwz r11, PlayerHolder@l(r11)
lwz r11, 0x20(r11)
lwzx r7, r11, r7

# Get Playersub14->damage
lwz r12, 0x48(r7)
lwz r12, 0x1C(r12)

# Get PlayerSub1c->bitfield2
lwz r7, 0x20(r7)
lwz r7, 0xC(r7)

# Check if player is in a mega
rlwinm. r11, r7, 17, 31, 31
beq+ notMega
li r0, 2
b storeStatus

# Check if player is shocked
notMega:
rlwinm. r11, r7, 25, 31, 31
beq+ storeStatus

# Check if his damage is shock or zapper and if so skip
cmpwi r12, 0xA
beq+ storeStatus
cmpwi r12, 0xF
beq+ storeStatus
li r0, 3

# Store result
storeStatus:
lhz r11, 0x8(r3)
stbx r0, r11, r29

# Original instruction
end:
mr r29, r3
blr

####################
# Bomb Visual Size #
####################

# Original instruction
BombVisualSize:
lfs f0, 0xA0(r31)

# Get item status
lhz r11, 0x8(r29)

# Load from array
SizeSub:
lis r12, ItemStatusArray@h
ori r12, r12, ItemStatusArray@l
lbzx r11, r12, r11
slwi r11, r11, 2

# Load correct float based on status
lis r12, OurFloats2@h
ori r12, r12, OurFloats2@l-4
lfsx f1, r12, r11

# Multiply and return
fmuls f0, f0, f1
blr

# Original instruction
BombVisualSize2:
lwz r3, 0x74(r6)

# Get item status
lhz r11, 0x8(r31)

# Load from array
SizeSub2:
lis r12, ItemStatusArray@h
ori r12, r12, ItemStatusArray@l
lbzx r11, r12, r11
slwi r11, r11, 2

# Load correct float based on status
lis r12, OurFloats2@h
ori r12, r12, OurFloats2@l-4
lfsx f0, r12, r11

# Multiply and return
fmuls f1, f1, f0
blr

######################
# Bomb Physical Size #
######################

# Original instruction
BombSize:
lwz r3, 0xB0(r29)

# Get item status
lhz r11, 0x8(r29)

# Call sub to do the hard work for us
b SizeSub

# Original instruction
BombSize2:
mr r3, r29

# Get item status
lhz r11, 0x8(r29)

# Call sub to do the hard work for us
b SizeSub2

####################
# Blue Visual Size #
####################

# Original instruction
BlueVisualSize:
lfs f0, 0x198(r31)

# Get item status
lhz r11, 0x8(r30)

# Call sub to do the hard work for us
b SizeSub

######################
# Blue Physical Size #
######################

# Original instruction
BlueSize:
lwz r3, 0xB0(r30)

# Get item status
lhz r11, 0x8(r30)

# Load from array
SizeSub3:
lis r12, ItemStatusArray@h
ori r12, r12, ItemStatusArray@l
lbzx r11, r12, r11
slwi r11, r11, 2

# Load correct float based on status
lis r12, OurFloats2@h
ori r12, r12, OurFloats2@l-4
lfsx f2, r12, r11

# Multiply and return
fmuls f1, f1, f2
blr

# Original instruction
BlueSize2:
mr r3, r30

# Get item status
lhz r11, 0x8(r30)

# Call sub to do the hard work for us
b SizeSub2

# Floats used for multiplication
OurFloats:
.float 1.0
.float 2.0
.float 0.5

# Floats used for multiplication
OurFloats2:
.float 1.0
.float 2.0
.float 0.75
