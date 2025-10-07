.include "asm_setup.S"

.global DriftOverride

# Original instruction
DriftOverride:
lwz r5, 4(r4)

# Check if it's a kart
cmpwi r5, 0
beq- kart

# If it's a bike and selection is not 0, set the according drift
lis r8, DriftBikes@ha
lbz r8, DriftBikes@l(r8)
cmpwi r8, 0
beq+ end
mr r5, r8
b end

# If it's a kart and selection is 1, set inside drift
kart:
lis r8, DriftKarts@ha
lbz r8, DriftKarts@l(r8)
cmpwi r8, 1
bne+ end

# Set inside drift if checks pass
setinside:
li r5, 2

# Done
end:
blr