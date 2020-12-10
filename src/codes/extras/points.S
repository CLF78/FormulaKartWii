.if (REGION == 'P')
	.set RACEINFO, 0x809BD730
.elseif (REGION == 'U')
	.set RACEINFO, 0x809B8F70
.elseif (REGION == 'J')
	.set RACEINFO, 0x809BC790
.elseif (REGION == 'K')
    .set RACEINFO, 0x809ABD70
.else
    .err
.endif

# Free registers = r0, r7, r8, r9, r10, r12
# Dest register = r3
# Other registers = r22 (number of players), current player (r19)

# Get RaceInfoPlayer array
lis r7, RACEINFO@ha
lwz r7, RACEINFO@l(r7)

# Random thing to make a loop and backup r19 to r0
li r3, 0
mr r0, r19

# Get player id in first and multiply it by 4
lwz r19, 0x18(r7)
lbz r19, 0(r19)
mulli r19, r19, 4

getPlayer:
# GetRaceInfoPlayer
lwz r8, 0xC(r7)

# Load the correct pointer
lwzx r8, r8, r19

# Load Timer class
lwz r8, 0x40(r8)

# Assemble the total time in r10

# Milliseconds
lhz r10, 0x8(r8)

# Seconds
lbz r9, 0x6(r8)
mulli r9, r9, 1000
add r10, r10, r9

# Minutes
lhz r9, 0x4(r8)
li r8, 0
ori r8, r8, 60000
mullw r9, r9, r8
add r10, r10, r9

# When this is run the first time, it's for getting the first finisher's time
# The second time is for getting the current player's time
addi r3, r3, 1
cmpwi r3, 1
bne continue

# Move first player's time to r12 and restore r19
mr r12, r10
mr r19, r0
b getPlayer

continue:
# C++ Code: https://godbolt.org/z/f1YGPe
# If the time is 0, give 0 points
li r9, 0
cmpw r10, r9
beq noPoints

# Subtract the first time to the player's time
sub r9, r10, r12

# Divide by 333 to get points to be subtracted
li r8, 333
divw r9, r9, r8

# Get maxpoints
mulli r10, r22, 15

# Subtract the point difference from maxpoints
sub r3, r10, r9

# Compare obtained points with number of players, if greater then we're done
cmpw r3, r22
bgt end

# If not, we'll set the points to be the number of players
mr r3, r22
b end

noPoints:
li r3, 0

end:
#ENDCODE
