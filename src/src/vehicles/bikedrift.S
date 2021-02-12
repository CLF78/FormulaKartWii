.include "asm_setup.S"

.global DriftOverride

# Original instruction
DriftOverride:
lwz r5, 4(r4)

# Check if type is outside drift bike
cmpwi r5, 1
bnelr+

# If so override it
li r5, 2
blr
