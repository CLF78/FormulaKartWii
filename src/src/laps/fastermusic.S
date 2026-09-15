.include "asm_setup.S"

.extern MusicPitch
.global FinalLapCheck, PitchReset, PitchReset2

###################
# Final Lap Check #
###################

# Original instruction
FinalLapCheck:
rlwinm r0, r3, 0, 0x18, 0x1F

# Check if it's the penultimate lap(s)
li r3, 0xA
divw r3, r0, r3
sub r3, r0, r3
cmpw r31, r3
beq doLapChangeAndReset

# Check if it's the final lap
cmpw r31, r0
bne+ morechecks

# Change pitch for final lap
lis r3, 0x3F8C
lis r5, MusicPitch@ha
stw r3, MusicPitch@l(r5)
b doLapChange

# Change lap number to reset the song and play the jingle
doLapChangeAndReset:
lis r3, 0x3F80
lis r5, MusicPitch@ha
stw r3, MusicPitch@l(r5)

doLapChange:
mr r0, r31
blr

# If it's not the penultimate lap(s), check if setting is enabled
morechecks:
lis r5, 0x8000
lbz r5, 0x4007 (r5)
cmpwi r5, 1
beq- gradmusic
blr

# If it is setup the float multipliers
gradmusic:
mr r12, r0
subi r12, r12, 0xA
li r5, 0x14
divw r12, r12, r5
mulli r12, r12, 0x4
lis r5, PitchFloats@h
ori r5, r5, PitchFloats@l

# Check if it's the penultimate lap(s)
cmpw r31, r3
blt+ mulstore

# If it's the penultimate lap(s) increase by a bigger factor
finallaps:
addi r12, r12, 0x24

# Multiply current pitch by the constant and store the new pitch
mulstore:
lfsx f30, r5, r12
lis r5, MusicPitch@ha
lfs f29, MusicPitch@l(r5)
fmuls f29, f29, f30
stfs f29, MusicPitch@l(r5)

end:
blr

##################
# Pitch Resetter #
##################

# Original instruction
PitchReset:
mr r31, r4

# Check if the race is over
cmpwi r4, 7
bnelr+

####################
# Pitch Resetter 2 #
####################

# Write pitch back
PitchReset2:
lis r11, 0x3F80
lis r12, MusicPitch@ha
stw r11, MusicPitch@l(r12)
blr

PitchFloats:
.float 1.0108425 #9
.float 1.0036141666666667 #27
.float 1.0021685 #45
.float 1.0015489285714286 #63
.float 1.0012047222222222 #81
.float 1.00098568181818181 #99
.float 1.00083403846153845 #117
.float 1.00072283333333333 #135
.float 1.00063779411764705 #153
.float 1.1205685 #10
.float 1.0401895 #30
.float 1.0241137 #50
.float 1.017224071428571 #70
.float 1.0133965 #90
.float 1.010960772727273 #110
.float 1.0092744999999999 #130
.float 1.0080378999999999 #150
.float 1.0070922647058823 #170