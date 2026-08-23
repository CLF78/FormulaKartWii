.include "asm_setup.S"

.global FeatherCutIndicator
.extern ResourceExists

FeatherCutIndicator:
# Check IDs for FCIs
lhz r3, 0x88(r30)
cmpwi r3, 0x2f0
beq+ fci
cmpwi r3, 0x2de
beq+ fci
cmpwi r3, 0x2c1
beq+ fci
cmpwi r3, 0x173
beq+ fci
cmpwi r3, 0x174
beq+ fci
cmpwi r3, 0xda
beq+ fci

# Set to load object from TRACK by default
li r3, 1
b loadResource

fci:
# Set to load object from COMMON if its an FCI (this li also serves as a skip if FCIs are disabled)
li r3, 0

lis r12, FCIs@ha
lbz r12, FCIs@l(r12)
cmpwi r12, 1
bnelr

loadResource:
# Store in the stack for next call
stw r3, 0x28(r1)
#flow override to check if the file exists
b ResourceExists
