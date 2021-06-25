.include "asm_setup.S"

.extern NoItemPoofFunc, NoItemPoofFunc2, NoItemPoof2Hook, NoItemPoof3Hook
.global NoItemPoof2, NoItemPoof3

# Copy of instruction
NoItemPoof2:
addi r3, r29, 0x174

# Call ptmf_test
bl NoItemPoofFunc

# This check is used later
cmpwi r3, 0

# Original instruction
mr r3, r29
b NoItemPoof2Hook+4

# This reuses the cmpwi from the above function
NoItemPoof3:
beqlr

# Original function call (does not return)
b NoItemPoofFunc2
