.include "asm_setup.S"

.extern MusicPitch
.global FinalLapCheck, PitchReset, PitchReset2

###################
# Final Lap Check #
###################

# Original instruction
FinalLapCheck:
rlwinm r0, r3, 0, 0x18, 0x1F

# Check if it's lap 45
cmpwi r31, 45
beq doLapChangeAndReset

# Check if it's lap 50
cmpwi r31, 50
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

# If it's not lap 45 or 50, check if setting is enabled
morechecks:
lis r5, Music@ha
lbz r5, Music@l (r5)
cmpwi r5, 2
beq- gradmusic
blr

# If it is load the current pitch
gradmusic:
lis r5, MusicPitch@ha
lfs f29, MusicPitch@l(r5)

# If it's laps 1-44 increase by a small factor
lis r3, 0x3F80
ori r3, r3, 0x4400

# Check if it's lap 46-49
cmpwi r31, 45
blt+ mulstore

# If it's laps 46-49 increase by a bigger factor
finallaps:
lis r3, 0x3F83
ori r3, r3, 0x1600

# Multiply by the constant and store the new pitch
mulstore:
stw r3, MusicPitch@l(r5)
lfs f30, MusicPitch@l(r5)
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
