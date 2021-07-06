.include "asm_setup.S"

.extern RandomInstance, RandomNextLimited, SpecialItemHook
.global SpecialRandom

# Get random item
SpecialRandom:
lis r3, RandomInstance@h
ori r3, r3, RandomInstance@l
li r4, 0xC
bl RandomNextLimited

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
