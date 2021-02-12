.include "asm_setup.S"

.global PointsModifier

# Original instruction
PointsModifier:
lbz r3, -1(r3)

# Multiply
mullw r3, r3, r22
blr
