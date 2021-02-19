.include "asm_setup.S"

.extern BoostAccelHook
.global BoostAccel

# Do bl trick
BoostAccel:
bl trick

.float 1.0
.float 0.03

trick:
mflr r5

# Load our floats
lfs f2, 0(r5)
lfs f3, 0x4(r5)

# Get current multiplier
lfs f4, -0xF8(r3)

# Accel += (multiplier - 1.0) * 0.03
fsubs f4, f4, f2
fmadds f0, f4, f3, f0

# Original instruction
stfs f0, 0x18(r3)
b BoostAccelHook+4
