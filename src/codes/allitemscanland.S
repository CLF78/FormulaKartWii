.if (REGION == 'P')
	.set ADDR1, 0x809C3618
	.set ADDR2, 0x809C36B8
.elseif (REGION == 'U')
	.set ADDR1, 0x809BEE20
	.set ADDR2, 0x809BEEB0
.elseif (REGION == 'J')
	.set ADDR1, 0x809C2678
	.set ADDR2, 0x809C2718
.elseif (REGION == 'K')
	.set ADDR1, 0x809B1C58
	.set ADDR2, 0x80893E78
.else
    .err
.endif


# Mega
li r7, 0xB
b begin

# Golden
li r7, 0xA
b begin

# Bullet Bill
li r7, 0xF
b begin

# Backup registers and setup
begin:
	stwu sp, -0x10(sp)
	mflr r0
	stw r0, 0x14(sp)
	lwz r6, 0x4(r3)
	lis r4, ADDR1@ha
	lwz r4, ADDR1@l(r4)
	lwz r4, 0x14(r4)
	li r3, 0

loc_0x50:
	lwz r5, 0x0(r4)
	cmpw r5, r6
	beq loc_0x70
	addi r4, r4, 0x248
	addi r3, r3, 0x1
	cmpwi r3, 0xC
	beq return
	b loc_0x50

loc_0x70:
	mr r3, r4
	lwz r4, 0x90(r3)
	cmpwi r4, 3
	beq noadd
	addi r4, r4, 0x1
	stw r4, 0x90(r3)

noadd:
	lis r4, ADDR2@h
	ori r4, r4, ADDR2@l
	mulli r7, r7, 0x1C
	lwzx r4, r4, r7
	cmpwi r4, 0
	beq return
	mtctr r4
	bctrl

return:
	li r3, -0x1
	lwz r0, 0x14(sp)
	mtlr r0
	addi sp, sp, 0x10
	blr

#ENDCODE

#SETTYPE COMPILED
#SETREGION P
047A66C4 60000000
04796D30 38600000
08790EF0 39800001
20030004 FFE00000
048B54D0 80001600
048B5500 80001608
048B550C 80001610
#ENDCODE

#SETREGION U
0479D6B8 60000000
0478DD24 38600000
08787EE4 39800001
20030004 FFE00000
048B0D98 80001600
048B0DC8 80001608
048B0DD4 80001610
#ENDCODE

#SETREGION J
047A5D30 60000000
0479639C 38600000
0879055C 39800001
20030004 FFE00000
048B4630 80001600
048B4660 80001608
048B466C 80001610
#ENDCODE

#SETREGION K
04794A84 60000000
047850F0 38600000
0877F2B0 39800001
20030004 FFE00000
048A3948 80001600
048A3978 80001608
048A3984 80001610
#ENDCODE
