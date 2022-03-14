.include "asm_setup.S"

.extern RandomComboPickerHook, RandomCombos, Menudata, RandomComboPickerC
.global RandomComboPicker

# Original instruction
RandomComboPicker:
li r4, 0x6B

# Check if random combos are on
lis r12, RandomCombos@ha
lbz r12, RandomCombos@l(r12)
cmpwi r12, 1
bne+ end

# Get MenuData98
lis r3, Menudata@ha
lwz r3, Menudata@l(r3)
lwz r3, 0x98(r3)

# Call C function
bl RandomComboPickerC

# Restore registers
mr r3, r29
li r4, 0x6D

# Return
end:
b RandomComboPickerHook+4
