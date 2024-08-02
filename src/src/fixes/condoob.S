.include "asm_setup.S"

.extern KMPdata, Raceinfo
.global ConditionalOutofBounds

# Riidefi's code

ConditionalOutofBounds:
extsh.    r3, r3
blt+      end
lis 	  r6, KMPdata@ha;
lwz       r5, 0x4(r31)
lwz       r5, 0x0(r5)
lwz 	  r4, KMPdata@l(r6);
lis 	  r6, Raceinfo@ha; 
lwz 	  r6, Raceinfo@l(r6);
rlwinm    r0,r3,2,0,29
lwz       r4, 0x2C(r4)
lbz       r5, 0x10(r5)
lwz       r4, 0x0(r4)
lwz       r6, 0xC(r6)
rlwinm    r5,r5,2,0,29
lwzx      r4, r4, r0
lwzx      r5, r6, r5
lwz       r4, 0x4(r4)
lhz       r7, 0xA(r5)
lhz       r8, 0x28(r4)
lhz       r9, 0x2A(r4)
sub       r10, r9, r8
srawi     r4, r10, 0x1F
xor       r0, r4, r10
sub       r6, r0, r4
subc      r5, r9, r8
subfe     r4, r9, r9
cntlzw    r0, r10
and       r5, r5, r4
add       r5, r8, r5
rlwinm    r4,r10,1,31,31
sub       r5, r7, r5
rlwinm    r0,r0,27,5,31
subc      r5, r5, r6
subfe     r5, r5, r5
neg       r5, r5
xor       r4, r5, r4
or        r4, r4, r0
subi      r0, r4, 0x1
or.       r3, r0, r3

end: