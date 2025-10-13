.include "asm_setup.S"

.global DriftOverride

# Original instruction
DriftOverride:
lwz r5, 4(r4)

# Check if it's a kart
cmpwi r5, 0
beq- kart

# If it's a bike and selection is not 0, set the according drift type and camera
lis r8, DriftBikes@ha
lbz r8, DriftBikes@l(r8)
cmpwi r8, 0
beq+ end
mr r5, r8
lis r8, 0x4234 
cmpwi r5, 1
beq storeDriftCam

li r8, 0
b storeDriftCam

# If it's a kart and selection is 1, set inside drift
kart:
lis r8, DriftKarts@ha
lbz r8, DriftKarts@l(r8)
cmpwi r8, 1
bne+ end

# Set inside drift type and camera if checks pass
setinside:
li r5, 2

# r8 is 1 in here but it's not a problem since inside drift cam value is 0, so 1 is no difference for this float

storeDriftCam:
stw r8, 0x64 (r3)

# Done
end:
blr