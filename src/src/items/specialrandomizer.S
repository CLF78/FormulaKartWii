.include "asm_setup.S"

.extern GameMode
.global SpecialRandom

# Check if this was called by item rain
SpecialRandom:
cmpwi r8, 0xDAD
beq end

# Get a random number using the timebase as a seed (modulo division)
mftbl r4
li r11, 0xE
divw r11, r4, r11
mulli r11, r11, 0xE
sub r4, r4, r11

# Since timebase-low might be negative, get absolute value
srawi r11, r4, 31
xor r4, r11, r4
sub r4, r4, r11

# Do not allow the Blooper to get out
cmpwi r4, 0xA
beq SpecialRandom

# Don't do any other change for Item Rain
lis r11, GameMode@ha
lbz r11, GameMode@l(r11)
cmpwi r11, 1
beq end

# Otherwise check for POW and Shock
cmpwi r4, 6
beq SpecialRandom

cmpwi r4, 0xD
beq SpecialRandom

# Original instruction
end:
addi r11, r1, 0x70
blr
