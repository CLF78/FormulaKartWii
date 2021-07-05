.include "asm_setup.S"

.extern ItemAmountArray, ItemAmountHook2
.global ItemAmount1, ItemAmount2

# Get item amount from eva
ItemAmount1:
lis r7, ItemAmountArray@h
ori r7, r7, ItemAmountArray@l
lbzx r7, r7, r4

# Store it as a single bit
rlwinm r7, r7, 6, 24, 24
stb r7, 0x7(r3)

# Original instruction
mr r31, r5
blr

# Get player id
ItemAmount2:
lwz r12, 0(r3)
lbz r12, 0x18(r12)

# Get amount from array
lis r11, ItemAmountArray@h
ori r11, r11, ItemAmountArray@l
lbzx r0, r11, r12
b ItemAmountHook2+4
