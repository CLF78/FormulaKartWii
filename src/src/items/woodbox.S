.include "asm_setup.S"

.extern BushFunc
.global WoodboxPatch, WoodboxData

# Load address of previous BL
WoodboxPatch:
lwz r4, 0xA4(r1)
lis r8, BushFunc@h
ori r8, r8, BushFunc@l+4

# Check that it's for the bushes
cmpw r4, r8
beq isBush

# Else set probability to 100
li r28, 100
blr

# For bushes, set it to 1/3rd
isBush:
li r28, 33
blr

WoodboxData:
.long 0xB4, 0x42F00000
