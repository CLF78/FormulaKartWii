.include "asm_setup.S"

.extern EffectPointer
.global BillAnimationFix

##########################################
# Bullet Bill Exhaust Fire Animation Fix #
##########################################
BillAnimationFix:

slwi r4, r3, 2
lis r12, EffectPointer@ha
lwz r12, EffectPointer@l(r12)
lwz r12, 0x68(r12)
lwzx r12, r12, r4
li r4, 0
stb r4, 0x7D(r12)
stb r4, 0x7E(r12)
li r4, -1
sth r4, 0x99C(r12)

# Original instruction
lis r4, 0x809C
blr