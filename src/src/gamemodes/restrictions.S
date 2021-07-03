.include "asm_setup.S"

.extern VehicleRestrict
.global VehicleRestriction

# Load setting
VehicleRestriction:
lis r3, VehicleRestrict@ha
lbz r3, VehicleRestrict@l(r3)

# Check if it's 0
cmpwi r3, 0
beq noRestriction

# If not, subtract 1
subi r0, r3, 1
blr

# Original instruction
noRestriction:
li r0, 2
blr
