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
cmpwi r31, 250
beq doLapChange

# Check if it's lap 50
cmpwi r31, 255
bnelr+

# Change pitch (lap 50 ONLY)
lis r3, 0x3F8C
lis r5, MusicPitch@ha
stw r3, MusicPitch@l(r5)

# Change lap number to reset the song and play the jingle
doLapChange:
mr r0, r31
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

# Write pitch back if so
lis r11, 0x3F80
lis r12, MusicPitch@ha
stw r11, MusicPitch@l(r12)
blr

####################
# Pitch Resetter 2 #
####################

# Write pitch back
PitchReset2:
lis r11, 0x3F80
lis r12, MusicPitch@ha
stw r11, MusicPitch@l(r12)
blr
