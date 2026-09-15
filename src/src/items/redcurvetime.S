.include "asm_setup.S"

.global RedCurveTime

RedCurveTime:
stw       r29, 0x260(r28)
lis r3, floats@h
ori r3, r3, floats@l
stwu r1, -0x10(r1)
lis r0, 0x4330
stw r0, 0x8(r1)
xoris r4, r29, 0x8000
stw r4, 0xC(r1)
lfs f0, 0x8(r3)
lfd f1, 0x8(r1)
lfd f2, 0x0(r3)
fsubs f1, f1, f2
fdivs f0, f0, f1
stfs f0, 0x264(r28)
addi r1, r1, 0x10
blr

floats:
.double 4503601774854144
.float 1
.align 2