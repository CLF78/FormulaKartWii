.include "asm_setup.S"

.extern KMPinfo, LapCount2
.global LapHook1, LapHook2, LapHook3, LapHook4

LapHook1:
mflr r5
bl getLapCount
mtlr r5
mr r5, r12
blr

LapHook2:
mflr r3
bl getLapCount
mtlr r3
mr r3, r12
b LapCount2+0x4

LapHook3:
mflr r4
bl getLapCount
mtlr r4
mr r4, r12
blr

LapHook4:
mflr r6
bl getLapCount
mtlr r6
mr r6, r12
blr

getLapCount:
lis r12, KMPinfo@ha
lwz r12, KMPinfo@l(r12)
lwz r12, 0x3C(r12)
lwz r12, 0x0(r12)
lwz r12, 0x0(r12)
lwz r12, 0x0(r12)
lbz r12, 0x0(r12)
subi r12, r12, 1
mulli r12, r12, 0x14
addi r12, r12, 0xA
blr