.include "asm_setup.S"

.extern UtilRandomSeed, Racedata, SabotageHook, GameMode
.global SabotageSetup

# Restore r28 and execute original instruction
SabotageSetup:
li r28, 0
stw r28, 0x38(r3)

# Check game mode
lis r3, GameMode@ha
lbz r3, GameMode@l(r3)
cmpwi r3, 1
bne+ return

# Get selectid from RacedataSettings and set it as the seed
lis r3, Racedata@ha
lwz r3, Racedata@l(r3)
lwz r3, 0xB90(r3)
bl UtilRandomSeed

# Return
return:
b SabotageHook+4
