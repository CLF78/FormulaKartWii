.include "asm_setup.S"

.global FeatherCutIndicator

# Get ID and check if it's our ID
FeatherCutIndicator:
lhz r3, 0x88(r30)
xori r3, r3, 0x2f0
cntlzw r3, r3
srwi r3, r3, 5

# Get the setting value and determine if we show or not
lis r12, 0x8000
lbz r12, 0x4007(r12)
and r3, r3, r12
xori r3, r3, 1

# Store in the stack for next call
stw r3, 0x28(r1)
blr
