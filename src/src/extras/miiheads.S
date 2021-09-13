.include "asm_setup.S"

.extern isOnlineRace
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

# Replace with large mii
li r3, 0x2C
blr
