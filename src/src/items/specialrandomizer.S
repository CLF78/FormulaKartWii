.include "asm_setup.S"

.global SpecialRandom

# Get a random number using the timebase as a seed (modulo division)
SpecialRandom:
mftbl r4
li r11, 0xB
divw r11, r4, r11
mulli r11, r11, 0xB
sub r4, r4, r11

# Since timebase-low might be negative, get absolute value
srawi r11, r4, 31
xor r4, r11, r4
sub r4, r4, r11

# Convert the Blooper to a Bullet Bill
cmpwi r4, 0xA
beq fixblooper

# Convert the Shock to a Golden Mushroom
cmpwi r4, 6
bne+ end

fixshock:
addi r4, r4, 3

fixblooper:
addi r4, r4, 3

# Original instruction
end:
addi r11, r1, 0x70
blr
