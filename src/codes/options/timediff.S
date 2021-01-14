###########
# Patch 1 #
###########
#INJECT 807EE5C0, 8084215C, 807EDC2C, 807DC980

# r5 = RaceInfoPlayer

.set TimeDiffType, 0x800017B6

.if (REGION == 'P')
	.set RaceData, 0x809BD728
	.set RaceInfo, 0x809BD730
.elseif (REGION == 'U')
	.set RaceData, 0x809B8F68
	.set RaceInfo, 0x809B8F70
.elseif (REGION == 'J')
	.set RaceData, 0x809BC788
	.set RaceInfo, 0x809BC790
.elseif (REGION == 'K')
    .set RaceData, 0x809ABD68
    .set RaceInfo, 0x809ABD70
.else
    .err
.endif

# Check game mode
lis r6, RaceData@ha
lwz r9, RaceData@l(r6)
lwz r7, 0xB70(r9)
cmpwi r7, 2
beq end

# Hardcoded last lap failsafe
cmpwi r31, 255
beq doNothing

lis r11, TimeDiffType@ha
lbz r11, TimeDiffType@l(r11)
cmpwi r11, 0
bne+ next

# Move r31 to r3 to force the compare result if the option is disabled
doNothing:
mr r3, r31
b end

# Load PlayerIdInEachPosition
next:
lwz r6, RaceInfo@l(r6)
lwz r6, 0x18(r6)

# Load my PlayerID
lbz r8, 0x1774(r9)
mulli r8, r8, 4

# Check if in 1st
lwzx r8, r5, r8
lbz r8, 0x20(r8)
cmpwi r8, 1
beq next2

# Otherwise check which option is enabled
cmpwi r11, 2
bne+ end
li r8, 2
b end

# If so, load 2nd place's RaceInfo and MaxLap
next2:
addi r8, r8, 2
lbz r12, 0x1(r6)
mulli r12, r12, 4
lwzx r12, r5, r12
lbz r31, 0x26(r12)

# If not equal, trigger the difference
end:
cmplw r3, r31
#ENDCODE

###########
# Patch 2 #
###########
#INJECT 807EE5DC, 80842178, 807EDC48, 807DC99C 

# r5 = RaceInfoPlayer
# r6 = PlayerIdInEachPosition
# r7 = Game Mode
# r8 = Position
# r9 = Racedata

# Check gamemode
cmpwi r7, 2
bne+ next

# Otherwise do the default instructions
add r5, r30, r0
addi r5, r5, 0x204
b end

# Get the ID of the player in front of me, OR if in 1st, get the ID of the player in 2nd
next:
subi r8, r8, 2
lbzx r8, r6, r8
mulli r8, r8, 0x4

# Load their raceinfo
lwzx r5, r5, r8

# Add the correct offset for the function that fills the laps
addi r5, r5, 0x74

# Convert lap
extsb r4, r31
addi r4, r4, 50

# Module division
li r12, 3
divw r12, r4, r12
mulli r12, r12, 3
subf r4, r12, r4

subi r4, r4, 1
cmpwi r4, -1
bne+ multiply

li r4, 2

# Add the result to r5
multiply:
mulli r4, r4, 0xC
add r5, r5, r4

# Load a high MEM1 address so that the function that fills the laps loads a null lap 1
lis r4, 0x8150
ori r4, r4, 0x14B0
end:
#ENDCODE

########################
# Multiplayer Disabler #
########################
#INJECT 80858444, 808369B4, 80857AB0, 80846804

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

# Load HudPlayerIDs[1]
lis r3, RACEDATA@ha
lwz r3, RACEDATA@l(r3)
lbz r3, 0xB85(r3)

# If there's a player two, skip
srwi. r3, r3, 7

#ENDCODE

##########################
# Multiplayer Disabler 2 #
##########################
#INJECT 80858354, 808368C4, 808579C0, 80846714

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

# Load HudPlayerIDs[1]
lis r3, RACEDATA@ha
lwz r3, RACEDATA@l(r3)
lbz r3, 0xB85(r3)

# If there's no player two, skip
cmpwi r3, -1

#ENDCODE

#SETTYPE COMPILED
#SETREGION P
047EE5A4 38000001
047EE580 38000001
047EE5D8 60000000
#ENDCODE

#SETREGION U
04842140 38000001
0484211C 38000001
04842174 60000000
#ENDCODE

#SETREGION J
047EDC10 38000001
047EDBEC 38000001
047EDC44 60000000
#ENDCODE

#SETREGION K
047DC964 38000001
047DC940 38000001
047DC998 60000000
#ENDCODE
