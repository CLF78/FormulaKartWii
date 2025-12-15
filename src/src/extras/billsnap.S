.include "asm_setup.S"
.global BillSnap, BillTimerIncrement, BillTimerReset

BillTimerIncrement:

#original instruction
sth r0,0x12(r31)

lha r4, 0x66 (r31)
addi r0, r4, 1
sth r0, 0x66 (r31)

b end

BillTimerReset:

#original instruction
lwz r4,0x0(r31)

li r0, 0
sth r0, 0x66 (r31)

b end

BillSnap:

#original instruction
lfs f0, 0x1fcc (r3)

#make sure we are in the first 10 frames (number of frames can probably be reduced but to lazy)
lha r0, 0x66 (r31)  
cmpwi r0, 10 
bgt+ end

#set turn tightness ridiculously high if in the first 10 frames
lis r0, 0x447A
stw r0, -0x4 (r1)
lfs f0, -0x4 (r1)

end:

blr