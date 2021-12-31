.include "asm_setup.S"

.extern MusicPitch, DriftSpeed
.global FinalLapCheck, PitchReset, PitchReset2

###################
# Final Lap Check #
###################

# Original instruction
FinalLapCheck:
rlwinm r0, r3, 0, 0x18, 0x1F

# Check if it's lap 45
cmpwi r31, 45
beq doLapChange

# Check if it's lap 50
cmpwi r31, 50
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

####################
# Pitch Resetter 2 #
####################

# Save LR
PitchReset2:
mflr r12

# Do BL trick
bl trick

.float 0.55

# Restore LR
trick:
mflr r11
lfs f0, 0(r11)

# Restore minimum drift speed
lis r11, DriftSpeed@ha
stfs f0, DriftSpeed@l(r11)

# Restore LR
mtlr r12

# Write pitch back
lis r11, 0x3F80
lis r12, MusicPitch@ha
stw r11, MusicPitch@l(r12)

# Reset TimerInstance
li r11, 0
stw r11, TimerInstance@l(r12)
stw r11, TimerInstance@l+4(r12)
stw r11, TimerInstance@l+8(r12)
blr
