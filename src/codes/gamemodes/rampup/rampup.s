#####################
# Ramp Up Game Mode #
#####################
#INJECT 80534B50, 80530008, 805344D0, 80522BA8

.set GameMode, 0x800017C0

.if (REGION == 'P')
	.set PlayerHolder, 0x809C18F8
.elseif (REGION == 'U')
	.set PlayerHolder, 0x809BD110
.elseif (REGION == 'J')
	.set PlayerHolder, 0x809C0958
.elseif (REGION == 'K')
	.set PlayerHolder, 0x809AFF38
.else
    .err
.endif

# Check if game mode matches
lis r3, GameMode@ha
lbz r3, GameMode@l(r3)
cmpwi r3, 2
bne+ end

# Run bl trick otherwise
bl trick

.float 0.01

# Load float in f1
trick:
mflr r3
lfs f1, 0(r3)

# Get player ID
lbz r3, 0x8(r29)
mulli r3, r3, 4

# Get current multiplier
lis r4, PlayerHolder@ha
lwz r4, PlayerHolder@l(r4)
lwz r4, 0x20(r4)
lwzx r4, r3, r4
lwz r4, 0x10(r4)
lwz r4, 0x10(r4)
lfs f0, 0x10(r4)

# Add f1 to f0
fadds f0, f0, f1
stfs f0, 0x10(r4)

# Original instruction
end:
lbz r3, 0x26(r29)
#ENDCODE
