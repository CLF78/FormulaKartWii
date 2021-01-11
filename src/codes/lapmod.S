###############
# Lap Counter #
###############
#INJECT 807F84F8, 807ED9F8, 807F7B64, 807E68B8

.if (REGION == 'P')
	.set RACEDATA, 0x809BD728
	.set RACEINFO, 0x809BD730
.elseif (REGION == 'U')
	.set RACEDATA, 0x809B8F68
	.set RACEINFO, 0x809B8F70
.elseif (REGION == 'J')
	.set RACEDATA, 0x809BC788
	.set RACEINFO, 0x809BC790
.elseif (REGION == 'K')
	.set RACEDATA, 0x809ABD68
    .set RACEINFO, 0x809ABD70
.else
    .err
.endif

# Free registers: r26, r28
# Target = r28

# Get racedata
lis r26, RACEDATA@ha
lwz r26, RACEDATA@l(r26)

# Load HUD pid and convert it to player array index
# racedata.main = 0x1c
# main.scenarios[0] = 0x4
# scenarios[0].settings = 0xb48
# settings.hudPlayerIds[0] = 0x1c
# total = 0xb84
lbz r26, 0xB84(r26)
rlwinm r26, r26, 2, 0, 29 # Multiply by 4

# Get raceinfo pointer - needs special porting
lis r28, RACEINFO@ha
lwz r28, RACEINFO@l(r28)

# Get player from player array
lwz r28, 0xC(r28)
lwzx r28, r28, r26

# Get max lap of player
lbz r28, 0x26(r28)

# Add 51 to match
extsb r28, r28
addi r28, r28, 51
#ENDCODE

##########################
# Lakitu Float Converter #
##########################
#INJECT 80723D54, 8071F924, 807233C0, 807120FC 

# Add 49 to lap count
addi r12, r12, 49

# Push stack
stwu r1, -0x10(r1)

# Load first magic number
lis r11, 0x5980
ori r11, r11, 0x0004
stw r11, 0x8(r1)
lfs f31, 0x8(r1)

# Load second magic number
lis r11, 0x4330
xoris r12, r12, 0x8000
stw r11, 0x8(r1)
stw r12, 0xC(r1)
lfd f2, 0x8(r1)

# Convert
fsub f31, f2, f31
frsp f31, f31

# Pop stack
addi r1, r1, 0x10

#ENDCODE

####################
# Time Storing Fix #
####################
#INJECT 80534B58, 80530010, 805344D8, 80522BB0

# Fix current lap
extsb r3, r3
addi r3, r3, 50

# Module division
li r5, 3
divw r5, r3, r5
mulli r5, r5, 3
subf r3, r5, r3

#ENDCODE

######################
# Time Storing Fix 2 #
######################
#INJECT 8053572C, 80530BE4, 805350AC, 80523784

# Modified original instruction
cmplwi r4, 0xCF

# Convert lap
extsb r4, r4
addi r4, r4, 50

# Module division
li r6, 3
divw r6, r4, r6
mulli r6, r6, 3
subf r4, r6, r4

# Add 1
addi r4, r4, 1

end:
#ENDCODE

######################
# Time Storing Fix 3 #
######################
#INJECT 80535798, 80530C50, 80535118, 805237F0

# Original instruction
subi r6, r4, 2

# If the result is -1, loop back to 2
cmpwi r6, -1
bne+ end

li r6, 2

end:
#ENDCODE

###################
# Race Ending Fix #
###################
#INJECT 80534A18, 8052FED0, 80534398, 80522A70

# Fix both lap counts
extsh r3, r5
extsb r0, r0

#ENDCODE

#######################
# Starting Jingle Fix #
#######################
#INJECT 8070B2B8, 80704914, 8070A924, 806F9660

# Original instruction
lbz r0, 0xDB(r29)

# Check that it isn't the first lap
cmpwi r31, 0xCE
bne+ end

# If so force a match
li r0, 0xCE

end:
#ENDCODE

################
# CPU Time Fix #
################
#INJECT 8053438C, 8052F844, 80533D0C, 805223E4

.set Floaty, 0x800001C0

# Original instruction
lfs f0, 0xC(r3)

# Load our float in f3
lis r4, Floaty@ha
lfs f3, Floaty@l(r4)

# Add them together
fadds f0, f0, f3

####################
# Custom Laps Code #
####################
#ENDCODE

#SETTYPE COMPILED
#SETREGION P
045340A0 3B80FFCD
045340A4 3BBC0001
045340B0 60000000
04723D3C 48000008
04723D48 7FAC0774
04534BDC 380000FF
04723CCC 380000FF
040001C0 40400000
#ENDCODE

#SETREGION U
0452F558 3B80FFCD
0452F55C 3BBC0001
0452F568 60000000
0471F90C 48000008
0471F918 7FAC0774
04530094 380000FF
0471F89C 380000FF
040001C0 40400000
#ENDCODE

#SETREGION J
04533A20 3B80FFCD
04533A24 3BBC0001
04533A30 60000000
047233A8 48000008
047233B4 7FAC0774
0453455C 380000FF
04723338 380000FF
040001C0 40400000
#ENDCODE

#SETREGION K
045220F8 3B80FFCD
045220FC 3BBC0001
04522108 60000000
047120E4 48000008
047120F0 7FAC0774
04522C34 380000FF
04712074 380000FF
040001C0 40400000
#ENDCODE
