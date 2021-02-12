.include "asm_setup.S"

.extern SharedItemHook, Raceinfo, ItemHolder
.global UltimateRandom

# Notes: r25 is position, r3 is a pointer to ItemSlotData, r4 is item to be stored
# Other free registers: r5, r6, r7, r8

# Get a random number using the timebase as a seed (modulo division)
UltimateRandom:
mftbl r4
li r5, 19
divw r5, r4, r5
mulli r5, r5, 19
subf r4, r5, r4

# Since timebase-low might be negative, get absolute value
srawi r5, r4, 31
xor r4, r5, r4
subf r4, r5, r4

# Specific item checks
cmpwi r4, 7
beq blue

cmpwi r4, 8
beq shock

cmpwi r4, 0xD
bne+ checkNewbie

###################
# POW Timer Check #
###################

lwz r5, 0x40(r3)
cmpwi r5, 0
bne+ UltimateRandom

# If the player is in 1st, give them a Mushroom instead
cmpwi r25, 1
bne+ end
li r4, 4
b end

####################
# Blue Timer Check #
####################

blue:
lwz r5, 0x38(r3)
cmpwi r5, 0
bne+ UltimateRandom
b end

#####################
# Shock Timer Check #
#####################

shock:
lwz r5, 0x34(r3)
cmpwi r5, 0
bne+ UltimateRandom
b end

###############
# Anti-Lapper #
###############

# Load RaceInfo
checkNewbie:
lis r8, Raceinfo@ha
lwz r8, Raceinfo@l(r8)

# Load difference threshold
bl trick

.float 1.0

trick:
mflr r7
lfs f0, 0(r7)

# Get the playerId from r23
lis r7, ItemHolder@ha
lwz r7, ItemHolder@l(r7)
lwz r7, 0x14(r7)
sub r7, r23, r7
li r6, 0x92
divw r6, r7, r6

# Get player id in 1st and multiply it by 4
lwz r5, 0x18(r8)
lbz r5, 0(r5)
rlwinm r5, r5, 2, 0, 29

# Get RaceInfo player pointers
lwz r8, 0xC(r8)
lwzx r5, r8, r5
lwzx r6, r8, r6

# Get lap progresses and calculate difference
lfs f2, 0xC(r5)
lfs f3, 0xC(r6)
fsubs f2, f2, f3

# If greater than threshold, apply the Newbie Helper
fcmpu cr0, f2, f0
ble+ end

#################
# Newbie Helper #
#################

# Green/Red Shells go to Triple Shrooms/Bomb
cmpwi r4, 1
ble newbie1

# Bananas/FIBs go to TC/Bullet Bill
cmpwi r4, 3
ble newbie2

# Triple FIBs go to Blue Shell
cmpwi r4, 12
beq newbie3

# Triple Bananas/Shells go to Star/Golden/Mega
cmpwi r4, 16
blt+ end

# Subtraction logic, yay
newbie4:
subi r4, r4, 2

newbie3:
subi r4, r4, 5
b end

newbie2:
addi r4, r4, 7

newbie1:
addi r4, r4, 5

# Move item to r3
end:
mr r3, r4
b SharedItemHook+4
