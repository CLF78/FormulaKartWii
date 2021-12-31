.include "asm_setup.S"

.global LakituBoard, FinishTimes

####################
# Lakitu Board Fix #
####################

# Subtract 2 to lap count to account for lap 1 and frame index
LakituBoard:
subi r12, r29, 0x2
stb r12, 0x4C(r1)

# Convert to float
psq_l f31, 0x4C(r1), 1, 2
blr

######################
# Finishing Time Fix #
######################

# Original instruction
FinishTimes:
lfs f0, 0xC(r3)

# Load lap count and convert it
psq_l f3, 0x3F(r1), 1, 2

# Add 1 to it
ps_sum0 f3, f3, f3, f3

# Subtract raceCompletion from it
fsubs f3, f3, f0

# Load multiplier
lis r3, 0x3E00
stw r3, 0x44(r1)
lfs f4, 0x44(r1)

# Multiply and add raceCompletion back
fmadds f0, f3, f4, f0
blr
