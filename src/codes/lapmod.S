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

# Get current lap of player
lbz r28, 0x26(r28)

# Add 47 to match
extsb r28, r28
addi r28, r28, 47
#ENDCODE

##########################
# Lakitu Float Converter #
##########################
#INJECT 80723D54, 8071F924, 807233C0, 807120FC 

# Add 45 to lap count
addi r12, r12, 45

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
# Lap Counting Fix #
####################
#INJECT 80534A00, 8052FEB8, 80534380, 80522A58

# Original instruction
sth r5, 0x24(r3)

# Check that it isn't the final lap
cmpwi r5, 3
beq end

# Otherwise store to maxLap as well
stb r5, 0x26(r3)

end:
####################
# Custom Laps Code #
####################
#ENDCODE

#SETTYPE COMPILED
#SETREGION P
045340A0 3B80FFD1
045340A4 3BBC0001
045340B0 60000000
04723D3C 48000008
04723D48 7FAC0774
#ENDCODE

#SETREGION U
0452F558 3B80FFD1
0452F55C 3BBC0001
0452F568 60000000
0471F90C 48000008
0471F918 7FAC0774
#ENDCODE

#SETREGION J
04533A20 3B80FFD1
04533A24 3BBC0001
04533A30 60000000
047233A8 48000008
047233B4 7FAC0774
#ENDCODE

#SETREGION K
045220F8 3B80FFD1
045220FC 3BBC0001
04522108 60000000
047120E4 48000008
047120F0 7FAC0774
#ENDCODE
