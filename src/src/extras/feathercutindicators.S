.include "asm_setup.S"

.global FeatherCutIndicator

# Set visible by default
FeatherCutIndicator:
li r3, 1

# Load FCI flag and check if it's enabled
lis r12, FCIs@ha
lbz r12, FCIs@l(r12)
cmpwi r12, 1
bne end

# Otherwise, check IDs and disable if they match
lhz r3, 0x88(r30)
cmpwi r3, 0x2f0
beq+ disabled
cmpwi r3, 0x2de
beq+ disabled
cmpwi r3, 0x2c1
beq+ disabled
cmpwi r3, 0xda
beq+ disabled
li r3, 1
b end

# Load from Common if an ID needs it
disabled:
li r3, 0

# Store in the stack for next call
end:
stw r3, 0x28(r1)
blr
