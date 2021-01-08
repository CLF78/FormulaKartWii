.set Pitch, 0x3F8C0000

.if (REGION == 'P')
	.set MusicPitch, 0x808A10D8
.elseif (REGION == 'U')
	.set MusicPitch, 0x8089C9D0
.elseif (REGION == 'J')
	.set MusicPitch, 0x808A0238
.elseif (REGION == 'K')
	.set MusicPitch, 0x8088F538
.else
    .err
.endif

# Original instruction
rlwinm r0, r3, 0, 0x18, 0x1F

# Check if it's lap 45
cmpwi r31, -2
beq doLapChange

# Check if it's lap 50
cmpwi r31, 3
bne+ end

# Change pitch
lis r3, Pitch@h
lis r5, MusicPitch@ha
stw r3, MusicPitch@l(r5)

# Change lap number to reset the song and play the jingle
doLapChange:
mr r0, r31

end:
#ENDCODE

##################
# Pitch Resetter #
##################
#INJECT 80711AD8, 8070A034, 80711144, 806FFE80

.if (REGION == 'P')
	.set MusicPitch, 0x808A10D8
.elseif (REGION == 'U')
	.set MusicPitch, 0x8089C9D0
.elseif (REGION == 'J')
	.set MusicPitch, 0x808A0238
.elseif (REGION == 'K')
	.set MusicPitch, 0x8088F538
.else
    .err
.endif

# Original instruction
mr r31, r4

# Check if the race is over
cmpwi r4, 7
bne+ end

# Write pitch back if so
lis r11, 0x3F80
lis r12, MusicPitch@ha
stw r11, MusicPitch@l(r12)

end:
#ENDCODE

####################
# Pitch Resetter 2 #
####################
#INJECT 8062C3A4, 805FB4F0, 8062BAF0, 8061A79C

.if (REGION == 'P')
	.set MusicPitch, 0x808A10D8
.elseif (REGION == 'U')
	.set MusicPitch, 0x8089C9D0
.elseif (REGION == 'J')
	.set MusicPitch, 0x808A0238
.elseif (REGION == 'K')
	.set MusicPitch, 0x8088F538
.else
    .err
.endif

# Original instruction
stwu r1, -0x10(r1)

# Write pitch back
lis r11, 0x3F80
lis r12, MusicPitch@ha
stw r11, MusicPitch@l(r12)
#ENDCODE
