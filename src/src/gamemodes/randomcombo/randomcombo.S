.include "asm_setup.S"

.extern RandomComboPickerHook, RandomCombos, Menudata, RandomComboPickerC, DriftMenuBackFix2Return
.global RandomComboPicker, DriftMenuBackFix, DriftMenuBackFix2

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

# Restore / Set registers
mr r3, r29
li r4, 0x82             #id for multiplayer drift select

# Get MenuData98        #check if in multiplayer
lis r12, Menudata@ha
lwz r12, Menudata@l(r12)
lwz r12, 0x98(r12)
lwz r12, 0x124 (r12)
cmpwi r12, 1
bgt end

li r4, 0x6D             #id for drift select

# Return
end:
b RandomComboPickerHook+4

# Original instruction
DriftMenuBackFix:
cmpwi r3, 0x4

# Check if random combos are on
lis r5, RandomCombos@ha
lbz r5, RandomCombos@l(r5)
cmpwi cr7, r5, 1
bnelr+ cr7

# Hide back button
li r5, 1
stb r5, 0xD4(r31)
blr

# Check if random combos are on and if so return
DriftMenuBackFix2:
lis r12, RandomCombos@ha
lbz r12, RandomCombos@l(r12)
cmpwi r12, 1
beqlr

# Otherwise call original function
b DriftMenuBackFix2Return
