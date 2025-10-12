.include "asm_setup.S"

.global MegaSizeMod, FOVFix

###################
# Size Multiplier #
###################

# Original instruction
MegaSizeMod:
lfs f0, 0x184(r4)

# Load the left part of our custom float in f1
lis r5, 0x3FC0
stw r5, 0x184(r3)
lfs f1, 0x184(r3)

# Multiply
fmuls f0, f1, f0

# Load the left part of the control float in f1
lis r5, 0x4020
stw r5, 0x184(r3)
lfs f1, 0x184(r3)

# Compare f0 and f1
fcmpo cr7, f0, f1
blt cr7, end

# If f0 is larger, then cap to f1
fmr f0, f1

end:
blr

###########
# FOV Fix #
###########

# Original instruction
FOVFix:
lwz r0, 0x4(r3)

# Null ptr check
lwz r5, 0x24(r4)
cmpwi r5, 0
beqlr

# Check if player is in a Mega
lwz r3, 0xC(r3)
rlwinm. r3, r3, 0, 16, 16
beqlr

# Store new FOV if so
lis r7, 0x4200
stw r7, 0x120(r5)
blr
