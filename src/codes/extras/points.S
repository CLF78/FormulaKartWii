.if (REGION == 'P')
	.set RACEDATA, 0x809BD728
.elseif (REGION == 'U')
	.set RACEDATA, 0x809B8F68
.elseif (REGION == 'J')
	.set RACEDATA, 0x809BC788
.elseif (REGION == 'K')
    .set RACEDATA, 0x809ABD68
.else
    .err
.endif

# Original Instruction
lbz r3, -1(r3)

# Get number of players from Racedata
lis r14, RACEDATA@h
lwz r14, RACEDATA@l(r14)
lbz r14, 0x24(r14)

# Multiply
mullw r3, r3, r14

#ENDCODE
