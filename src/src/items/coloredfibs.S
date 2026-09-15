.include "asm_setup.S"

.extern UtilRandom, FIBFunc

.global FIBColors

FIBColors:

# Backup r3
mr r12, r3

# Setup function call for random number generator
li r3, 0
li r4, 6
bl UtilRandom

# Setup colors and choose one based on r3's value
lis r4, ColorFloats@ha
ori r4, r4, ColorFloats@l
slwi r3, r3, 2
lfsx f31, r4, r3

# Restore r3 and set r4 up again
mr r3, r12
li r4, 3
b FIBFunc +0x4

ColorFloats:
.float 0
.float 1
.float 2
.float 3
.float 4
.float 5