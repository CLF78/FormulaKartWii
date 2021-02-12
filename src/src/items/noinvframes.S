.include "asm_setup.S"

.global NoInvFrames

# Original instruction
NoInvFrames:
lwz r5, 0x1C(r21)

# Do not do anything for explosion damage types
subi r3, r5, 7
cmplwi r3, 1
blelr

# For types 0-2, remove invincibility frames in any case
cmpwi r5, 2
ble removeInvFrames

# For all other types, remove invincibility frames only if damage type is different than the previous one
cmpw r5, r22
beqlr+

removeInvFrames:
li r5,-1
blr
