.include "asm_setup.S"

.extern Raceinfo, OurFloats, RespawnHelperHook, RespawnHelperHook2, RespawnHelperHook3, InstaDraftHook
.global NewbieHelper, RespawnHelper, RespawnHelper2, RespawnHelper3, InstaDraft

# Newbie Helper Function uses registers r3, r4, r5, f0, f1, f2 and clobbers cr0
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

# Subtract and compare
fsubs f0, f0, f1
fcmpu cr0, f0, f2

# Return value of cr0+gt
mfcr r3
rlwinm r3, r3, 2, 31, 31
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

# Replace timer with 0 if necessary (use cr0+gt from ASM call)
ble+ end
li r0, 0

# Return
end:
b RespawnHelperHook+4

# Get playerId of player
RespawnHelper2:
lwz r3, 0(r30)
lwz r3, 0(r3)
lbz r3, 0x10(r3)

# Backup r4
mr r12, r4

# Call Newbie Helper
bl NewbieHelper

# Restore r4
mr r4, r12

# Replace timer with 0 if necessary (use cr0+gt from ASM call)
ble+ end2
li r4, 0

# Original instruction
end2:
lhz r3, 0x234(r30)
b RespawnHelperHook2+4

# Original instruction
RespawnHelper3:
lhz r0, 0x236(r29)

# Get player id
lwz r3, 0(r3)
lbz r3, 0x10(r3)

# Call Newbie Helper
bl NewbieHelper

# Restore r5 that we just clobbered
lwz r5, 0(r29)
lwz r5, 0x4(r5)

# Use cr0+gt from Newbie Helper ASM
ble+ end3

# force 1 if not braking
lwz r3,0x4(r5)
rlwinm. r3,r3,0x0,0x1e,0x1e
bne skipforce
li r0, 1
skipforce:

# Return
end3:
b RespawnHelperHook3+4

#################
# Instant Draft #
#################

# Original Instruction
InstaDraft:
lha r0, 0x0290 (r30)

# Backup r3
mr r7, r3

# Get playerId
or r3, r29, r29
lwz r3, 0 (r3)
lwz r3, 0 (r3)
lbz r3, 0x10 (r3)
rlwinm r28, r3, 0, 0x18, 0x1f

# Call Newbie Helper
bl NewbieHelper

# Restore r3
mr r3, r7

# Use cr0+gt from Newbie Helper ASM
ble+ end4

# Force to 0
li r0, 0

# Return
end4:
b InstaDraftHook+4