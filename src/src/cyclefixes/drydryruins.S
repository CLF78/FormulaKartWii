.include "asm_setup.S"

.global PillarFix, SandpitFix

###########
# Pillars #
###########

# Multiply by 16 (CC-independent)
PillarFix:
slwi r0, r0, 4
stw r0, 0x108(r31)

# Original instruction
lwz r3, 0(r28)
blr

############
# Sandpits #
############

# Reload word as float (using 32 instead of 16 to make the sandpits fill slower than actual pace)
SandpitFix:
lis r4, 0x4200
stw r4, 0x128(r28)
lfs f1, 0x128(r28)

# Divide
fdivs f0, f0, f1

# Store (original instruction)
stfs f0, 0x128(r28)
blr
