.include "asm_setup.S"

.extern ItemAmounts, ItemAmountHook, ItemAmountHook2, ItemAmountHook3
.global ItemAmount, ItemAmount2, ItemAmount3

# Get player id
ItemAmount:
lwz r12, 0(r3)
lbz r12, 0x18(r12)

# Get amount from array
lis r11, ItemAmounts@h
ori r11, r11, ItemAmounts@l+0xC
lbzx r0, r11, r12
b ItemAmountHook+4

# Original instruction
ItemAmount2:
stw r0, 0x8(r3)

# Store updated amount in the amount array as well
lwz r4, 0(r3)
lbz r4, 0x18(r4)
lis r5, ItemAmounts@h
ori r5, r5, ItemAmounts@l+0xC
stbx r0, r4, r5
b ItemAmountHook2+4

# Original instruction
ItemAmount3:
stw r0, 0x8(r31)

# Store updated amount in the amount array as well
lwz r3, 0(r31)
lbz r3, 0x18(r3)
lis r5, ItemAmounts@h
ori r5, r5, ItemAmounts@l+0xC
stbx r0, r3, r5
b ItemAmountHook3+4
