.include "asm_setup.S"

.global ClearExhaust

# Clears exhaust pipe flames after being hit
ClearExhaust:
lis     r3, 0x809C
lwz     r3, 8656(r3)
lwz     r3, 104(r3)
lwz     r4, 0(r31)
lwz     r5, 40(r4)
lwz     r4, 0(r4)
lbz     r4, 16(r4)
mulli   r4, r4, 0x4
lwzx    r3, r3, r4
li      r0, 0x0
stw     r0, 24(r3)
blr