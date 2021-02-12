.include "asm_setup.S"

.extern isOnlineRace, MegaFunc, MegaTCHook
.global MegaTC

# Give Mega effect
MegaTC:
bl MegaFunc

# Check if it's an online race
lis r3, isOnlineRace@ha
lbz r0, isOnlineRace@l(r3)
cmpwi r0, 0
beq+ end

# If so, transmit the required data
li r3, 0x8
li r4, 0xC

# Return
end:
b MegaTCHook+4
