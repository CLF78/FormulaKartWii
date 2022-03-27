.include "asm_setup.S"

.extern ItemAmounts, ItemAmountHook
.global ItemAmount

# Get player id
ItemAmount:
lwz r12, 0(r3)
lbz r12, 0x18(r12)

# Get amount from array
lis r11, ItemAmounts@h
ori r11, r11, ItemAmounts@l+0xC
lbzx r0, r11, r12
b ItemAmountHook+4
