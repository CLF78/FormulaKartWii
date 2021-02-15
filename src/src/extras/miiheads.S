.include "asm_setup.S"

.extern RKNetController, isOnlineRace
.global MiiHeadsPatch

# Original instruction
MiiHeadsPatch:
lwz r3, 0x34(r3)

# Check if it's an online race
lis r12, isOnlineRace@ha
lbz r12, isOnlineRace@l(r12)
cmpwi r12, 1
bnelr+

# Check if character is already a Mii
cmpwi r3, 0x2A
bgelr

# Check if player is connected
cmpwi r6, 0
beq doReplacement

# Check if connection state is not 0
lis r12, RKNetController@ha
lwz r12, RKNetController@l(r12)
lwz r12, 0x28(r12)
cmpwi r12, 0
beqlr

# Replace with large mii
doReplacement:
li r3, 0x2C
blr
