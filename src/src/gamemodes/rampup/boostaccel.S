.include "asm_setup.S"

.extern BoostAccelHook
.global BoostAccel

TheFloats:
.float 1.0
.float 0.03

# There is no other free register than r5. Simply amazing.

# Load our floats
BoostAccel:
lis r5, TheFloats@ha
lfs f2, TheFloats@l(r5)
lfs f3, TheFloats@l+4(r5)

# Load multiplier and subtract 1.0
lfs f4, -0xF8(r3)
fsubs f4, f4, f2

# Multiply by 0.03 and add value to boost acceleration
fmadds f0, f3, f4, f0

# Original instruction
stfs f0, 0x18(r3)
b BoostAccelHook+4
