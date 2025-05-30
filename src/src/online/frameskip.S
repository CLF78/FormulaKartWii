.include "asm_setup.S"

.global GetFrameskip1, GetFrameskip2
.extern DriverManager, DisableInterrupts
.extern RestoreInterrupts, GetTime
.extern RKNetPacketManager, Racedata
.extern GXDrawDone, BeginFrame

# Frameskip function 1
GetFrameskip1:
lis     r3, 0x8000
lbz     r4, 5665(r3)
cmpwi   r4, 0x0
beq+    loc_0x34
lis     r4, 0x8000
lwz     r4, 5668(r4)
cmpwi   r4, 0x0
bne-    loc_0x74
li      r4, 0x0
stb     r4, 5665(r3)
li      r0, 0x0
stb     r0, 136(r30)
b       loc_0x70

loc_0x34:
lis     r3, 0x8000
lbz     r4, 5664(r3)
cmpwi   r4, 0x1
bne+    loc_0x70
cmpwi   r0, 0x0
bne+    loc_0x70
lis     r4, 0x8000
lwz     r4, 5668(r4)
cmpwi   r4, 0x0
beq+    loc_0x70
li      r0, 0x1
stb     r0, 136(r30)
lis     r4, 0x8000
stb     r0, 5665(r4)
b       loc_0x74

loc_0x70:
stb     r0, 5664(r3)

loc_0x74:
cmpwi   r0, 0x0
blr

# Frameskip function 2
GetFrameskip2:
mr      r3, r21;
mr      r4, r25;
stwu    r1, -40(r1);
stw     r28, 24(r1);
lis     r28, 0x8000;
lwz     r9, 5672(r28);
stw     r30, 32(r1);
cmpwi   cr7, r9, 0x0;
lwz     r30, 76(r3);
beq-    cr7, loc_0x4C;
cmpwi   cr7, r30, 0x0;
beq-    cr7, loc_0x4C;
lbz     r10, 105(r3);
li      r9, 0x0;
stw     r9, 5672(r28);
subic   r9, r10, 1;
subfe   r9, r9, r10;
addi    r9, r9, 0x1;
stb     r9, 8(r30);

loc_0x4C:
cmpwi   cr7, r4, 0x0;
li      r9, 0x0;
beq-    cr7, loc_0x170;
lis     r9, DriverManager@ha;
stw     r31, 36(r1);
lbz     r9, DriverManager@l(r9);
mr      r31, r3;
cmpwi   cr7, r9, 0x0;
nop
cmpwi   cr7, r30, 0x0;
li      r9, 0x1;
beq-    cr7, loc_0x2C0;
mflr    r0;
stw     r24, 8(r1);
stw     r0, 44(r1);
stw     r25, 12(r1);
lis     r25, 0x8000;
stw     r26, 16(r1);
stw     r27, 20(r1);
stw     r29, 28(r1);
lis     r12, DisableInterrupts@ha;
ori     r12, r12, DisableInterrupts@l;
mtctr   r12;
bctrl
mr      r26, r3;
mtctr   r12;
bctrl
lwz     r9, 5676(r25);
lis     r8, 0x8000;
lwz     r29, 104(r30);
mr      r24, r3;
lbz     r27, 105(r31);
add     r29, r9, r29;
lwz     r10, 108(r30);
addi    r27, r27, 0x1;
add     r29, r29, r27;
stw     r27, 5680(r8);
cmplw   cr7, r10, r29;
blt-    cr7, loc_0x184;
lis     r10, 0x8000;
lwz     r10, 5684(r10);
cmpw    cr7, r9, r10;
bge-    cr7, loc_0x184;
cmpwi   cr7, r9, 0x0;
beq-    cr7, loc_0x3FC;

loc_0x108:
lbz     r8, 8(r30);
lis     r7, 0x8000;
lwz     r10, 5688(r7);
add     r9, r27, r9;
add     r8, r27, r8;
mr      r3, r26;
stb     r8, 8(r30);
add     r27, r10, r27;
li      r8, 0x0;
lis     r10, 0x8000;
stw     r9, 5676(r25);
stw     r27, 5688(r7);
stw     r8, 5692(r10);
lis     r12, RestoreInterrupts@ha;
ori     r12, r12, RestoreInterrupts@l;
mtctr   r12;
bctrl
li      r9, 0x0;

loc_0x150:
lwz     r0, 44(r1);
lwz     r24, 8(r1);
lwz     r25, 12(r1);
mtlr    r0;
lwz     r26, 16(r1);
lwz     r27, 20(r1);
lwz     r29, 28(r1);
lwz     r31, 36(r1);

loc_0x170:
mr      r3, r9;
lwz     r28, 24(r1);
lwz     r30, 32(r1);
addi    r1, r1, 0x28;
b       loc_0x424;

loc_0x184:
cmpwi   cr7, r9, 0x0;
ble-    cr7, loc_0x2D8;
lis     r10, 0x8000;
stw     r9, 5696(r10);
lis     r12, GetTime@h;
ori     r12, r12, GetTime@l;
mtctr   r12;
bctrl
lwz     r10, 108(r30);
lis     r9, 0x8000;
addi    r9, r9, 0x1644;
li      r8, 0x0;
sub     r29, r10, r29;
li      r10, 0x1;
addic.  r7, r29, 1;
stw     r3, 0(r9);
stw     r4, 4(r9);
stw     r8, 5676(r25);
stw     r10, 5672(r28);
ble-    loc_0x24C;
lis     r9, RKNetPacketManager@ha;
lis     r8, 0x8000;
lwz     r9, RKNetPacketManager@l(r9);
stw     r10, 5708(r8);
cmpwi   cr7, r9, 0x0;
beq-    cr7, loc_0x24C;
lbz     r10, 0(r9);
cmpwi   cr7, r10, 0x0;
beq-    cr7, loc_0x24C;
lha     r10, 18(r9);
cmpwi   cr7, r10, 0x0;
bgt+    cr7, loc_0x24C;
lis     r10, Racedata@ha;
lwz     r10, Racedata@l(r10);
lwz     r10, 2932(r10);
cmpwi   cr7, r10, 0x6;
beq-    cr7, loc_0x24C;
lbz     r10, 105(r31);
cmpwi   cr7, r10, 0x0;
beq-    cr7, loc_0x230;
andi.   r10, r7, 0x1;
beq-    loc_0x230;
addi    r7, r29, 0x2;

loc_0x230:
lis     r6, 0x8000;
lhz     r8, 16(r9);
lwz     r10, 5712(r6);
add     r8, r7, r8;
add     r10, r10, r7;
sth     r8, 16(r9);
stw     r10, 5712(r6);

loc_0x24C:
lis     r31, 0x8000;
mr      r3, r30;
addi    r31, r31, 0x1654;
lis     r12, BeginFrame@h;
ori     r12, r12, BeginFrame@l;
mtctr   r12;
bctrl
lwz     r10, 0(r31);
lis     r9, 0x8000;
lwz     r11, 4(r31);
addi    r9, r9, 0x165C;
stw     r10, 0(r9);
stw     r11, 4(r9);
lis     r12, GetTime@h;
ori     r12, r12, GetTime@l;
mtctr   r12;
bctrl
stw     r3, 0(r31);
lis     r9, 0x8000;
li      r10, 0x1;
mr      r3, r26;
stw     r10, 5692(r9);
stw     r4, 4(r31);
lis     r12, RestoreInterrupts@ha;
ori     r12, r12, RestoreInterrupts@l;
mtctr   r12;
bctrl
li      r9, 0x1;
b       loc_0x150;

loc_0x2C0:
lwz     r31, 36(r1);
mr      r3, r9;
lwz     r28, 24(r1);
lwz     r30, 32(r1);
addi    r1, r1, 0x28;
b       loc_0x424;

loc_0x2D8:
lis     r9, 0x8000;
li      r10, 0x0;
stw     r10, 5696(r9);
lis     r12, GetTime@h;
ori     r12, r12, GetTime@l;
mtctr   r12;
bctrl
lis     r7, 0x8000;
lis     r10, 0x8000;
lbz     r8, 5666(r7);
addi    r10, r10, 0x1668;
lis     r9, 0x8000;
stw     r3, 0(r10);
cmpwi   cr7, r8, 0x0;
addi    r9, r9, 0x1644;
stw     r4, 4(r10);
li      r11, 0x0;
li      r10, 0x0;
stw     r11, 4(r9);
stw     r10, 0(r9);
beq-    cr7, loc_0x334;
subi    r8, r8, 0x1;
stb     r8, 5666(r7);

loc_0x334:
cmpwi   cr7, r24, 0x0;
b       loc_0x24C;
lis     r31, RKNetPacketManager@ha;
lwz     r9, RKNetPacketManager@l(r31);
cmpwi   cr7, r9, 0x0;
beq-    cr7, loc_0x24C;
lbz     r10, 0(r9);
cmpwi   cr7, r10, 0x0;
beq-    cr7, loc_0x24C;
lha     r9, 18(r9);
cmpwi   cr7, r9, 0x0;
bgt+    cr7, loc_0x24C;
lis     r9, Racedata@ha;
lwz     r9, Racedata@l(r9);
lwz     r9, 2932(r9);
cmpwi   cr7, r9, 0x6;
beq-    cr7, loc_0x24C;
mr      r3, r30;
lis     r12, BeginFrame@h;
ori     r12, r12, BeginFrame@l;
mtctr   r12;
bctrl
lis     r12, GXDrawDone@ha;
ori     r12, r12, GXDrawDone@l;
mtctr   r12;
bctrl
lwz     r10, RKNetPacketManager@l(r31);
lis     r8, 0x8000;
lhz     r9, 16(r10);
add     r9, r27, r9;
rlwinm  r9, r9, 0, 16, 31;
sth     r9, 16(r10);
stw     r9, 5732(r8);
b       loc_0x24C;
mflr    r0;
mr      r3, r30;
stw     r0, 44(r1);
lis     r12, BeginFrame@h;
ori     r12, r12, BeginFrame@l;
mtctr   r12;
bctrl
lwz     r0, 44(r1);
li      r9, 0x1;
lwz     r31, 36(r1);
mr      r3, r9;
lwz     r28, 24(r1);
mtlr    r0;
lwz     r30, 32(r1);
addi    r1, r1, 0x28;
b       loc_0x424;

loc_0x3FC:
lis     r12, GetTime@h;
ori     r12, r12, GetTime@l;
mtctr   r12;
bctrl
lis     r10, 0x8000;
addi    r10, r10, 0x1668;
lwz     r9, 5676(r25);
stw     r3, 0(r10);
stw     r4, 4(r10);
b       loc_0x108;

loc_0x424:
mr      r25, r3;
cmpwi   r25, 0x0;
blr;