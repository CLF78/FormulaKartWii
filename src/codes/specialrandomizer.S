# Original randomizer code
mftbl r4
li r11, 0xE
divw r11, r4, r11
mulli r11, r11, 0xE
sub r4, r4, r11
srawi r11, r4, 31
xor r4, r11, r4
sub r4, r4, r11

# Check that the item is not a Blooper
cmpwi r4, 0xA
bne+ end

# Replace with shroom otherwise
li r4, 3

# Original instruction
end:
stwu r1, -0x70(r1)

#ENDCODE
