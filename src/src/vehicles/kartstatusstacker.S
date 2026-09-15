.include "asm_setup.S"

.extern StarTimer, MegaTimer, ShroomTimer
.global StarStacker1, StarStacker2, MegaStacker, BulletStacker1, BulletStacker2, BulletStacker3, ShockStacker1, ShockStacker2, ShroomStacker


# Star Timer
StarStacker1:
lwz r0, 0x8(r5)
mr r12, r0
blr

StarStacker2:
lha r0, StarTimer@l(r4)
andis. r12, r12, 0x8000
bne normal
lwz r12, 0(r3)
lwz r12, 4(r12)
lwz r12, 0xc(r12)
andis. r12, r12, 0x0800
li r12, 0
bne resetStar

normal:
lha r12, 0x18A(r3)

resetStar:
add r0, r12, r0
cmplwi r0, 0x7FFF
ble starCap
li r0, 0x7FFF
starCap:
sth r0, 0x278(r3)
blr


# Mega Timer
MegaStacker:
lha r0, MegaTimer(r4)
lha r12, 0x194(r3)
add r0, r12, r0
cmplwi r0, 0x7FFF
ble megaCap
li r0, 0x7FFF
megaCap:
blr


# Bullet Timer
BulletStacker1:
lha r5, 0x124(r29)
addi r5, r5, 0x1
sth r5, 0x124(r29)
cmpwi r5, 0x1
ble bullet1End
lha r5, 0x126(r29)
addi r5, r5, 0xB4
cmplwi r5, 0x7FFF
ble bulletCap
li r5, 0x7FFF
bulletCap:
sth       r5, 0x126(r29)

bullet1End:
li r0, 0
blr

BulletStacker2:
li r31, 0
stw r31, 0x124(r3)
mr r31, r3
blr

BulletStacker3:
lha r0, 0x12(r27)
lha r12, 0x124(r27)
cmpwi r12, 0x1
ble bullet3End
lha r12, 0x126(r27)
cmpwi r12, 0
ble bullet3End
li r11, 0x1
cmpwi r29, 0
beq subBulletTime
li r11, 0x6

subBulletTime:
sub r12, r12, r11
cmplwi r12, 0
bgt storeBulletTime
li r12, 0

storeBulletTime:
sth r12, 0x126(r27)
li r0, 0
sth r0, 0x12(r27)

bullet3End:
blr     


# Shock Timer
ShockStacker1:
mr r29, r4
lha r0, 0x18C(r3)
add r29, r0, r29
cmplwi r29, 0x7FFF
ble shockCap
li r29, 0x7FFF
shockCap:
sth r29, 0x27a(r3)
blr

ShockStacker2:
li r4, 0x1
lwz r5, 0x118(r28)
lwz r5, 0x0(r5)
lwz r5, 0x28(r5)
lha r6, 0x27A(r5)
cmpw r6, r0
ble shock2End
li r0, 0x2B1
lha r3, 0x18C(r5)
cmpwi r3, 0x5A
ble shock2End
stw r0, 0x4C(r28)

shock2End:
blr

# Mushroom Timer
ShroomStacker:
lha r31, ShroomTimer@l(r4)
lhz r0, 0x118(r30)
rlwinm. r0, r0, 0, 29, 29
li r0, 0
beq resetShroom
lha r0, 0x110(r30)
resetShroom:
add r31, r0, r31
cmplwi r31, 0x7FFF
ble shroomCap
li r31, 0x7FFF
shroomCap:
blr