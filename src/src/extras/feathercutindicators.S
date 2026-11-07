.include "asm_setup.S"

.global FeatherCutIndicator, CalcModelFlagCheck
.extern ResourceExists, CalcModelFlagCheckHook

FeatherCutIndicator:
# Check IDs for FCIs
lhz r12, 0x88(r30)
cmpwi r12, 0x2f0
beq+ fci
cmpwi r12, 0x2de
beq+ fci
cmpwi r12, 0x2c1
beq+ fci
cmpwi r12, 0x173
beq+ fci
cmpwi r12, 0x174
beq+ fci
cmpwi r12, 0xda
beq+ fci

# original r3 if no fci
b loadResource

fci:
# Set to load object from COMMON if its an FCI (this li also serves as a skip if FCIs are disabled)
li r3, 0

#skip by returning false for the ResourceExists call if FCIs are disabled
lis r12, FCIs@ha
lbz r12, FCIs@l(r12)
cmpwi r12, 1
bne disableModel

loadResource:
# Store in the stack for load call
stw r3, 0x28(r1)
#flow override to check if the file exists
b ResourceExists

disableModel:
lhz r12, 0x2c (r30)
ori r12, r12, 0x10 #flag to disable calcModel entirely
sth r12, 0x2c (r30)
blr

CalcModelFlagCheck:
lhz r12, 0x2c (r3)
andi. r12, r12, 0x10 #check flag to disable calcModel entirely
bnelr #return early if set

stwu r1, -0x10 (r1) #original instruction
b CalcModelFlagCheckHook + 4
