# Inject @ 80799948 PAL, 8079093C NTSC-U, 80798FB4 NTSC-J, 80787D08 NTSC-K

.set EVArray, 0x800001B0

.if (REGION == 'P')
	.set RACEDATA, 0x809BD728
	.set DROPFUNC, 0x80798A30
.elseif (REGION == 'U')
	.set RACEDATA, 0x809B8F68
	.set DROPFUNC, 0x8078FA24
.elseif (REGION == 'J')
	.set RACEDATA, 0x809BC788
	.set DROPFUNC, 0x8079809C
.elseif (REGION == 'K')
    .set RACEDATA, 0x809ABD68
	.set DROPFUNC, 0x80786DF0
.else
    .err
.endif

# Push stack and execute og instruction
add r3, r3, r0
stwu r1, -0x10(r1)
stw r3, 0x8(r1)

# Load RACEDATA
lis r12, RACEDATA@ha
lwz r12, RACEDATA@l(r12)

# Get player ID
li r11, 0x248
divw r11, r0, r11
mulli r11, r11, 0xF0

# Get proper offset in racedata
addi r11, r11, 0x2E

# Get realControllerID
lbzx r11, r11, r12

# Check that it's a real player
cmpwi r11, -1
beq+ end

# Get current item and check that it's a blue shell
lwz r5, 0x8C(r3)
cmpwi r5, 7
bne+ end

# Load the byte from the EVA
lis r12, EVArray@h
ori r12, r12, EVArray@l
lbzx r11, r11, r12
cmpwi r11, 1
bne+ end

# All conditions are met, so call the function!
li r4, 0xC
lis r12, DROPFUNC@h
ori r12, r12, DROPFUNC@l
mtctr r12
bctrl

# Pop stack
end:
lwz r3, 0x8(r1)
addi r1, r1, 0x10
#ENDCODE
