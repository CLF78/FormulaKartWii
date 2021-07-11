.include "asm_setup.S"

.extern PlayerHolder, ItemStatusArray, DynamicSizingHook4Helper, DynamicSizingHook4
.global DynamicSizing, DynamicSizing2, DynamicSizing3, DynamicSizing4Helper, DynamicSizing4, DynamicSizing5, DynamicSizing6

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
ori r11, r11, OurFloats@l
lfsx f2, r11, r12

# Multiply
DynamicSubMini:
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
ori r11, r11, OurFloats@l
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

# Assume no mod required
li r6, 0

# Get playerId
lbz r4, 0x6C(r31)
slwi r4, r4, 2

# Get the related PlayerHolder
lis r5, PlayerHolder@ha
lwz r5, PlayerHolder@l(r5)
lwz r5, 0x20(r5)
lwzx r4, r5, r4

# Get PlayerSub1c->bitfield2
lwz r4, 0x20(r4)
lwz r4, 0xC(r4)

# Check if player is in a mega
rlwinm. r5, r4, 17, 31, 31
beq notMega
li r6, 1
b storeStatus

# Check if player is shocked
notMega:
rlwinm. r5, r4, 25, 31, 31
beq storeStatus
li r6, 2

# Store result
storeStatus:
lis r4, ItemStatusArray@h
ori r4, r4, ItemStatusArray@l
lhz r5, 0x8(r31)
stbx r6, r4, r5

# Get float based on status
slwi r6, r6, 2
lis r4, OurFloats@h
ori r4, r4, OurFloats@l
lfsx f2, r4, r6
b DynamicSubMini

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
cmpwi r12, 0
beqlr+

# If so just overwrite f1 with f2
fmr f1, f2
blr

# Floats used for multiplication
OurFloats:
.float 1.0
.float 2.0
.float 0.5
