.include "asm_setup.S"

.extern DrawShit, ChasePointer, ChaseIconHook
.global ChaseIconFix

ChaseIconFix:
mr r26, r3

slwi r0, r28, 2
lis r3, ChasePointer@ha
lwz r3, ChasePointer+8@l(r3)
lwzx r3, r3, r0
li r4, 1
li r5, 0
lis r12, DrawShit@h
ori r12, r12, DrawShit@l
mtctr r12
bctrl

end:
mr r4, r30
lhz r0, 0x334(r26)
b ChaseIconHook+4