# inject at 8059678c (PAL)
# inject at 8058ff68 (NTSC-U)
# inject at 8059610c (NTSC-J)
# inject at 805847e4 (NTSC-K)

.set region, ''

.if (region == 'P')
        .set Player_getControllerHolder, 0x805903f4
.elseif (region == 'E')
        .set Player_getControllerHolder, 0x80589bd0
.elseif (region == 'J')
        .set Player_getControllerHolder, 0x8058fd74
.elseif (region == 'K')
        .set Player_getControllerHolder, 0x8057e44c
.else
        .err
.endif

bl floats

.long 0x3e99999a # 0.3f
.long 0x3f800000 # 1.0f

floats:
mflr r12

mr r11, r4

lfs f0, 0x4c (r31) # -1.3f

lwz r3, 0x1c (r29) # playerSub->playerSub_1c
lwz r4, 0x1c (r3) # playerSub_1c->airtime

cmpwi r4, 0x1
ble end # airtime < 2

lbz r8, 0x96 (r3)
cmpwi r8, 0x1
bne not_hopping

cmpwi r4, 0x12
ble end # airtime < 19

not_hopping:
lwz r3, 0x18 (r3)
lis r4, Player_getControllerHolder@h
ori r4, r4, Player_getControllerHolder@l
mtctr r4
bctrl

lfs f2, 0x34 (r3) # controllerHolder->currentInputState.stickY
fabs f3, f2
fadds f2, f2, f3 # stickY <= 0.0f ? 0.0f : 2.0f * stickY
lfs f3, 0x0 (r12) # 0.3f
lfs f4, 0x4 (r12) # 1.0f
fmadds f2, f2, f3, f4
fmuls f0, f0, f2

end:

mr r4, r11
mr r3, r30

# inject at 80597390 (PAL)
# inject at 80590b6c (NTSC-U)
# inject at 80596d10 (NTSC-J)
# inject at 805853e8 (NTSC-K)

.set region, ''

.if (region == 'P')
        .set Player_getControllerHolder, 0x805903f4
.elseif (region == 'E')
        .set Player_getControllerHolder, 0x80589bd0
.elseif (region == 'J')
        .set Player_getControllerHolder, 0x8058fd74
.elseif (region == 'K')
        .set Player_getControllerHolder, 0x8057e44c
.else
        .err
.endif

bl floats

.long 0x3e99999a # 0.3f
.long 0x3f800000 # 1.0f

floats:
mflr r12

li r8, 0x1

lwz r3, 0x1c (r28) # playerSub->playerSub_1c
lwz r4, 0x1c (r3) # playerSub_1c->airtime

cmpwi r4, 0x0
bne not_first_frame # airtime != 0

li r8, 0x0
stb r8, 0x96 (r3)
lwz r8, 0x4 (r3)
rlwinm. r8, r8, 0, 24, 24
beq not_pressing_hop_button # !(playerSub_1c->bitfield0 & DRIFT_START)

li r8, 0x1
stb r8, 0x96 (r3)

not_pressing_hop_button:
not_first_frame:
cmpwi r4, 0x1
ble end # airtime < 2

lbz r8, 0x96 (r3)
cmpwi r8, 0x1
bne not_hopping

cmpwi r4, 0x12
ble end # airtime < 19

not_hopping:
lwz r3, 0x18 (r3)
lis r4, Player_getControllerHolder@h
ori r4, r4, Player_getControllerHolder@l
mtctr r4
bctrl

lfs f2, 0x34 (r3) # controllerHolder->currentInputState.stickY
fabs f3, f2
fadds f2, f2, f3 # stickY <= 0.0f ? 0.0f : 2.0f * stickY
lfs f3, 0x0 (r12) # 0.3f
lfs f4, 0x4 (r12) # 1.0f
fmadds f2, f2, f3, f4
fmuls f0, f0, f2

end:
mr r3, r28 # original instruction
