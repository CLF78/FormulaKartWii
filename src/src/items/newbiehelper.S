.include "asm_setup.S"

.extern Raceinfo, OurFloats, RespawnHelperHook, RespawnHelperHook2
.global NewbieHelper, RespawnHelper, RespawnHelper2

# Load Raceinfo
NewbieHelper:
lis r4, Raceinfo@ha
lwz r4, Raceinfo@l(r4)

# Get 1st place's playerId
lwz r5, 0x18(r4)
lbz r5, 0(r5)
slwi r5, r5, 2

# Get player array
lwz r4, 0xC(r4)

# Load 1st place's raceCompletion
lwzx r5, r5, r4
lfs f0, 0xC(r5)

# Get raceCompletion for currentPlayer
slwi r3, r3, 2
lwzx r4, r4, r3
lfs f1, 0xC(r4)

# Get immediate value for compare
lis r5, OurFloats@ha
lfs f2, OurFloats@l(r5)

# Assume false
li r3, 0

# Subtract and compare
fsubs f0, f0, f1
fcmpu cr0, f0, f2
blelr+

# Return true
li r3, 1
blr

##################
# Respawn Helper #
##################

# Original instruction
RespawnHelper:
li r0, 0x82

# Get player id
lwz r3, 0x4(r27)
lwz r3, 0(r3)
lbz r3, 0x10(r3)

# Call Newbie Helper
bl NewbieHelper

# Check if result is 1
cmpwi r3, 1
bne+ end

# Replace timer with 0
li r0, 0

# Return
end:
b RespawnHelperHook+4

# Save original r4 value
RespawnHelper2:
mr r12, r4

# Get playerId of player
lwz r3, 0(r30)
lwz r3, 0(r3)
lbz r3, 0x10(r3)

# Call Newbie Helper
bl NewbieHelper

# Check if result is 1
cmpwi r3, 1
beq applyNewbie

# Restore r4 if not
mr r4, r12
b end2

# Otherwise replace with zero
applyNewbie:
li r4, 0

# Original instruction
end2:
lhz r3, 0x234(r30)
b RespawnHelperHook2+4
