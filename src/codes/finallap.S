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
cmpwi r31, 2
beq doLapChange

# Check if it's lap 50
cmpwi r31, 7
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
#INJECT 80534908, 8052FDC0, 80534288, 80522960

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
lbz r3, 8(r3)

# Write pitch back
lis r11, 0x3F80
lis r12, MusicPitch@ha
stw r11, MusicPitch@l(r12)
#ENDCODE
