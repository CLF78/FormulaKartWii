.include "asm_setup.S"

.global EVENTOverflow

# Default instruction
EVENTOverflow:
lbz r0, 0x19 (r27)

# Get data size
lbz r12, 0x1C (r27)

# Check if it would fit in the buffer
add r12, r30, r12
cmpwi r12, 0xE0
bltlr+

# Set type to none if not to ignore
li r0, 0
stb r0, 0x19 (r27)
blr
