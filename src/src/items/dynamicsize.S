.include "asm_setup.S"

.extern PlayerHolder, DynamicSizingHook, DynamicSizingHook3, DynamicSizingHook4, BlueExplosionFunc
.global DynamicSizing, DynamicSizing2, DynamicSizing3Helper, DynamicSizing3, DynamicSizing4, DynamicSizing5, DynamicSizing6, DynamicSizing7
.global BombVisualSize, BombVisualSize2, BombSize, BombSize2, BombSize3, BlueVisualSize, BlueSize, BlueSize2
.global OurFloats

##########
# Hook 1 #
##########

# Check if it's a blue shell explosion
DynamicSizing:
lis r12, BlueExplosionFunc@h
ori r12, r12, BlueExplosionFunc@l+4
lwz r0, 0x14(r1)
cmpw r0, r12
beq end

# If not, reset item status
store:
li r0, 0
stb r0, 0x72(r6)

# Original instruction
end:
cmpwi r5, 0
b DynamicSizingHook+4

##########
# Hook 2 #
##########

# Get item status
DynamicSizing2:
lbz r12, 0x2E(r5)
lis r11, OurFloats@h
ori r11, r11, OurFloats@l-4
lfsx f0, r11, r12

# Multiply
fmuls f1, f1, f0

# Original instruction
fmr f29, f1
blr

#################
# Hook 3 Helper #
#################

# Save our beloved r3
DynamicSizing3Helper:
mr r12, r3

# Original instruction
cmpwi r4, 0
b DynamicSizingHook3+4

##########
# Hook 3 #
##########

# Original instruction
DynamicSizing3:
lfs f1, 0x48(r3)

# Get item status
lbz r12, 0x72(r12)
lis r11, OurFloats@h
ori r11, r11, OurFloats@l-4
lfsx f2, r11, r12

# Multiply
fmuls f1, f1, f2
b DynamicSizingHook3+0x4C

##########
# Hook 4 #
##########

# Check if status was already set, and if so return
DynamicSizing4:
lbz r0, 0x72(r3)
cmpwi r0, 0
bne+ end2

# Assume no mod required
li r0, 1

# Do not resize the TC
lwz r7, 0x4(r3)
cmpwi r7, 0xE
beq storeStatus

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

# Check if their damage is shock or zapper and if so skip
cmpwi r12, 0xA
beq+ storeStatus
cmpwi r12, 0xF
beq+ storeStatus
li r0, 3

# Store result
storeStatus:
slwi r0, r0, 2
stb r0, 0x72(r3)

# Original instruction
end2:
mr r29, r3
blr

####################
# Hook 5 and 6 Sub #
####################

# Original instruction
DynamicSizing5Sub:
lfs f2, 0x48(r3)

# Get item status
lbz r12, 0x72(r29)

# Load correct float based on status
lis r11, OurFloats@h
ori r11, r11, OurFloats@l-4
lfsx f3, r11, r12

# Multiply
fmuls f2, f2, f3

# Repeat for growth size using the other array
addi r11, r11, 0x18
lfsx f3, r11, r12
blr

##########
# Hook 5 #
##########

# Call sub
DynamicSizing5:
bl DynamicSizing5Sub

# Skipped instruction
lfs f0, 0x2C(r31)

# Multiply growth size
fmuls f0, f0, f3
b DynamicSizingHook4+0x1CC

##########
# Hook 6 #
##########

# Call sub
DynamicSizing6:
bl DynamicSizing5Sub

# Multiply growth size
fmuls f1, f1, f3
b DynamicSizingHook4+0x3E8

##########
# Hook 7 #
##########

# Original instruction
DynamicSizing7:
lfs f0, 0x48(r4)

# Get item status
lbz r12, 0x72(r3)
lis r11, OurFloats@h
ori r11, r11, OurFloats@l-4
lfsx f3, r11, r12

# Multiply
fmuls f0, f0, f3
blr

######################
# Bomb/Blue Size Sub #
######################

# Get item status
SizeSub:
lis r12, OurFloats2@h
ori r12, r12, OurFloats2@l-4
lfsx f1, r12, r11

# Multiply and return
fmuls f0, f0, f1
blr

########################
# Bomb/Blue Size Sub 2 #
########################

# Get item status
SizeSub2:
lis r12, OurFloats2@h
ori r12, r12, OurFloats2@l-4
lfsx f0, r12, r11

# Multiply and return
fmuls f1, f1, f0
blr

####################
# Bomb Visual Size #
####################

# Original instruction
BombVisualSize:
lfs f0, 0xA0(r31)

# Get item status
lbz r11, 0x72(r29)
b SizeSub

######################
# Bomb Visual Size 2 #
######################

# Original instruction
BombVisualSize2:
lwz r3, 0x74(r6)

# Get item status
lbz r11, 0x72(r31)
b SizeSub2

######################
# Bomb Physical Size #
######################

# Original instruction
BombSize:
lwz r3, 0xB0(r29)

# Get item status
lbz r11, 0x72(r29)
b SizeSub

########################
# Bomb Physical Size 2 #
########################

# Original instruction
BombSize2:
mr r3, r29

# Get item status
lbz r11, 0x72(r29)
b SizeSub2

########################
# Bomb Physical Size 3 #
########################

# Get item status
BombSize3:
lbz r11, 0x72(r30)
lis r12, OurFloats2@h
ori r12, r12, OurFloats2@l-4
lfsx f0, r12, r11

# Multiply and return
fmuls f4, f4, f0

# Original instruction
xoris r0, r0, 0x8000
blr

####################
# Blue Visual Size #
####################

# Original instruction
BlueVisualSize:
lfs f0, 0x198(r31)

# Get item status
lbz r11, 0x72(r30)
b SizeSub

######################
# Blue Physical Size #
######################

# Original instruction
BlueSize:
lwz r3, 0xB0(r30)

# Get item status
lbz r11, 0x72(r30)
lis r12, OurFloats2@h
ori r12, r12, OurFloats2@l-4
lfsx f2, r12, r11

# Multiply and return
fmuls f1, f1, f2
blr

########################
# Blue Physical Size 2 #
########################

# Original instruction
BlueSize2:
mr r3, r30

# Get item status
lbz r11, 0x72(r30)
b SizeSub2

# Floats used for items
OurFloats:
.float 1.0
.float 2.0
.float 0.5

# Floats used for explosions
OurFloats2:
.float 1.0
.float 2.0
.float 0.75

# Floats used for growth size
OurFloats3:
.float 1.0
.float 5.0
.float 0.5
