###################
# Player ID Saver #
###################
#INJECT 805967B0, 8058FF8C, 80596130, 80584808

.set PlayerID, 0x800001F0

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

# Store player ID
lis r4, PlayerID@ha
stb r3, PlayerID@l(r4)

# Original instruction
lis r4, RACEDATA@ha
#ENDCODE

###########################
# Cannon Bill Speed Mod 1 #
###########################
#INJECT 805850C4, 8057E8A0, 80584A44, 8057311C

.set PlayerID, 0x800001F0

.if (REGION == 'P')
	.set ItemHolder, 0x809C3618
.elseif (REGION == 'U')
	.set ItemHolder, 0x809BEE20
.elseif (REGION == 'J')
	.set ItemHolder, 0x809C2678
.elseif (REGION == 'K')
    .set ItemHolder, 0x809B1C58
.else
    .err
.endif

bl float

.float 1.5

float:
mflr r12

# Original instruction
lfs f0, 0x14(r30)

# Load multiplier
lfs f30, 0(r12)

# Get Player ID
lis r11, PlayerID@ha
lbz r11, PlayerID@l(r11)
mulli r11, r11, 0x248

# Load Bullet Bill Flag
lis r12, ItemHolder@ha
lwz r12, ItemHolder@l(r12)
lwz r12, 0x14(r12)
lwzx r12, r11, r12
lwz r12, 0x50(r12)
lwz r12, 0(r12)
lbz r4, 0x10C(r12)

# Check if it's on
cmpwi r4, 0
beq+ end

# Multiply float if so
fmuls f0, f0, f30

end:
#ENDCODE

###########################
# Cannon Bill Speed Mod 2 #
###########################
#INJECT 805850D0, 8057E8AC, 80584A50, 80573128

# Original instruction
lfs f7, 0(r29)

# Check if the bill flag is on
cmpwi r4, 0
beq+ end

# Multiply float if so
fmuls f7, f7, f30

end:
#ENDCODE
