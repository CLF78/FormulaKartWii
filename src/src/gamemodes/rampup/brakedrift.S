# inject at 8051f5f8 (PAL)
# inject at 8051b184 (NTSC-U)
# inject at 8051ef78 (NTSC-J)
# inject at 8050d61c (NTSC-K)

andi. r8, r3, 0x240
cmpwi r8, 0x240
bne end # (buttonRaw & (B | R)) != (B | R)

ori r6, r6, 0x10

end:
ori r6, r6, 0x1 # original instruction

# inject at 8052029c (PAL)
# inject at 8051be28 (NTSC-U)
# inject at 8051fc1c (NTSC-J)
# inject at 8050e2c0 (NTSC-K)

andi. r4, r5, 0x220
cmpwi r4, 0x220
bne end # (buttonRaw & (B | R)) != (B | R)

ori r8, r8, 0x10

end:
ori r8, r8, 0x1 # original instruction

# inject at 80745cb4 (PAL)
# inject at 80735de8 (NTSC-U)
# inject at 80745320 (NTSC-J)
# inject at 80734074 (NTSC-K)

andi. r6, r3, 0x404
cmpwi r6, 0x404
bne end # (buttonRaw & (B | R)) != (B | R)

ori r31, r31, 0x10

end:
ori r31, r31, 0x1 # original instruction

# inject at 80745f70 (PAL)
# inject at 807360a4 (NTSC-U)
# inject at 807455dc (NTSC-J)
# inject at 80734330 (NTSC-K)

andi. r3, r4, 0x600
cmpwi r3, 0x600
bne end

ori r0, r0, 0x10

end:
ori r0, r0, 0x1 # original instruction

# inject at 8057adec (PAL)
# inject at 80574588 (NTSC-U)
# inject at 8057a76c (NTSC-J)
# inject at 80568e44 (NTSC-K)

.set region, ''

.if (region == 'P')
        .set Player_getControllerHolder, 0x805903f4
        .set braking, 0x8057ae8c
.elseif (region == 'E')
        .set Player_getControllerHolder, 0x80589bd0
        .set braking, 0x80574628
.elseif (region == 'J')
        .set Player_getControllerHolder, 0x8058fd74
        .set braking, 0x8057a80c
.elseif (region == 'K')
        .set Player_getControllerHolder, 0x8057e44c
        .set braking, 0x80568ee4
.else
        .err
.endif

mr r11, r4

rlwinm r3, r11, 0, 28, 31
cmpwi r3, 0xf
bne end

mr r3, r29
lis r4, Player_getControllerHolder@h
ori r4, r4, Player_getControllerHolder@l
mtctr r4
bctrl

lhz r3, 0x2c (r3)
rlwinm. r3, r3, 0, 27, 27
beq end

lis r4, braking@h
ori r4, r4, braking@l
mtctr r4
bctr

end:
rlwinm. r3, r11, 0, 31, 31 # original instruction

# inject at 806faff8 (PAL)
# inject at 806f6090 (NTSC-U)
# inject at 806fa664 (NTSC-J)
# inject at 806e93a0 (NTSC-K)

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

mr r10, r0
mr r11, r3
mr r12, r4

rlwinm r27, r10, 30, 31, 31 # original instruction

rlwinm r5, r10, 0, 27, 31
cmpwi r5, 0xf
bne end # !drifting

lwz r3, 0x18 (r12)
lis r5, Player_getControllerHolder@h
ori r5, r5, Player_getControllerHolder@l
mtctr r5
bctrl

lhz r5, 0x2c (r3)
rlwinm. r5, r5, 0, 27, 27
beq end

rlwinm. r5, r10, 0, 0, 0
bne end

rlwinm. r5, r10, 0, 11, 11
bne end

li r27, 0x0
li r28, 0x1
li r30, 0x0

end:
mr r4, r12
mr r3, r11
mr r0, r10

# inject at 80699c98 (PAL)
# inject at 80695810 (NTSC-U)
# inject at 80699304 (NTSC-J)
# inject at 80688040 (NTSC-K)

.set region, ''

.if (region == 'P')
        .set Player_getControllerHolder, 0x805903f4
        .set func0, 0x806a19d8
        .set func1, 0x806a1b68
.elseif (region =='E')
        .set Player_getControllerHolder, 0x80589bd0
        .set func0, 0x8069d550
        .set func1, 0x8069d6e0
.elseif (region =='J')
        .set Player_getControllerHolder, 0x8058fd74
        .set func0, 0x806a1044
        .set func1, 0x806a11d4
.elseif (region =='K')
        .set Player_getControllerHolder, 0x8057e44c
        .set func0, 0x8068fd80
        .set func1, 0x8068ff10
.else
        .err
.endif

lwz r3, 0x118 (r30)
lwz r3, 0x0 (r3)
lwz r3, 0x4 (r3)
lwz r6, 0x4 (r3)
rlwinm r5, r6, 0, 27, 31
cmpwi r5, 0xf
bne not_brake_drifting # !drifting

lwz r3, 0x18 (r3)
lis r5, Player_getControllerHolder@h
ori r5, r5, Player_getControllerHolder@l
mtctr r5
bctrl

lhz r5, 0x2c (r3)
rlwinm. r5, r5, 0, 27, 27
beq not_brake_drifting

rlwinm. r5, r6, 0, 0, 0
bne not_brake_drifting

rlwinm. r5, r6, 0, 11, 11
bne not_brake_drifting

li r5, 0x1
stb r5, 0x15 (r3)

lis r29, func0@h
ori r29, r29, func0@l

b call_func

not_brake_drifting:
lbz r5, 0x15 (r3)

cmpwi r5, 0x1
bne end

li r5, 0x0
stb r5, 0x15 (r3)

lis r29, func1@h
ori r29, r29, func1@l

call_func:
mr r3, r30
lwz r4, 0x614 (r30)
li r5, 0x19
li r6, 0x1a
li r7, 0x1
mtctr r29
bctrl

end:
addi r11, r1, 0xa0 # original instruction

# inject at 80698f50 (PAL)
# inject at 80694ac8 (NTSC-U)
# inject at 806985bc (NTSC-J)
# inject at 806872f8 (NTSC-K)

.set region, ''

.if (region == 'P')
        .set Player_getControllerHolder, 0x805903f4
        .set func0, 0x806a19d8
        .set func1, 0x806a1b68
.elseif (region =='E')
        .set Player_getControllerHolder, 0x80589bd0
        .set func0, 0x8069d550
        .set func1, 0x8069d6e0
.elseif (region =='J')
        .set Player_getControllerHolder, 0x8058fd74
        .set func0, 0x806a1044
        .set func1, 0x806a11d4
.elseif (region =='K')
        .set Player_getControllerHolder, 0x8057e44c
        .set func0, 0x8068fd80
        .set func1, 0x8068ff10
.else
        .err
.endif

mr r30, r0

lwz r3, 0x118 (r31)
lwz r3, 0x0 (r3)
lwz r3, 0x4 (r3)
lwz r6, 0x4 (r3)
rlwinm r5, r6, 0, 27, 31
cmpwi r5, 0xf
bne not_brake_drifting # !drifting

lwz r3, 0x18 (r3)
lis r5, Player_getControllerHolder@h
ori r5, r5, Player_getControllerHolder@l
mtctr r5
bctrl

lhz r5, 0x2c (r3)
rlwinm. r5, r5, 0, 27, 27
beq not_brake_drifting

rlwinm. r5, r6, 0, 0, 0
bne not_brake_drifting

rlwinm. r5, r6, 0, 11, 11
bne not_brake_drifting

li r5, 0x1
stb r5, 0x15 (r3)

lis r29, func0@h
ori r29, r29, func0@l

b call_funcs

not_brake_drifting:
lbz r5, 0x15 (r3)

cmpwi r5, 0x1
bne end

li r5, 0x0
stb r5, 0x15 (r3)

lis r29, func1@h
ori r29, r29, func1@l

call_funcs:
mr r3, r31
lwz r4, 0x530 (r31)
li r5, 0x22
li r6, 0x23
li r7, 0x0
mtctr r29
bctrl

mr r3, r31
lwz r4, 0x530 (r31)
li r5, 0x23
li r6, 0x24
li r7, 0x1
mtctr r29
bctrl

end:
mr r0, r30

lwz r0, 0x24 (r1) # original instruction
