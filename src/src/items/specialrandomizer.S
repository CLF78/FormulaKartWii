.include "asm_setup.S"

.extern SpecialItemHook, CalcRandom
.global SpecialRandom

# Get random item
SpecialRandom:
bl CalcRandom
li r28,12
divw r28, r3, r28
mulli r28, r28, 12
subf r3, r28, r3

# Replace shock
cmpwi r3, 6
blt+ end
addi r3, r3, 1

# Replace POW
cmpwi r3, 0xB
blt+ end
addi r3, r3, 1

# Store result
end:
mr r28, r3

# Original instruction
mr r3, r27
b SpecialItemHook+4
