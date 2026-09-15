.include "asm_setup.S"

.global DriftOverride

# Original instruction
DriftOverride:
lwz r5, 4(r4)

# Replace type if outside drift
rlwinm r8, r5, 0, 31, 31
add r5, r8, r5
blr
