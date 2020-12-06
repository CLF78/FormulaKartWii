.if (REGION == 'P')
	.set RACEDATA, 0x809BD728
	.set RACEINFO, 0x809BD730
.elseif (REGION == 'U')
	.set RACEDATA, 0x809B8F68
	.set RACEINFO, 0x809B8F70
.elseif (REGION == 'J')
	.set RACEDATA, 0x809BC788
	.set RACEINFO, 0x809BC790
.elseif (REGION == 'K')
	.set RACEDATA, 0x809ABD68
    .set RACEINFO, 0x809ABD70
.else
    .err
.endif

# BL Trick
mflr r12
bl enddata

# Output location and max difference
.long 0x800001B0
.float 1.0

enddata:

# Load raceinfo
lis r3, RACEINFO@ha
lwz r3, RACEINFO@l(r3)

# Null pointer check (if raceinfo exists then racedata must anyway)
cmpwi r3, 0
beq end

# Get difference threshold and EVA address
mflr r11
lfs f0, 4(r11)
lwz r10, 0(r11)

# Load racedata
lis r11, RACEDATA@ha
lwz r11, RACEDATA@l(r11)

# TODO: This might crash if you're spectating and player id 0 dcs

# Load HUD pid and convert it to player array index
# racedata.main = 0x1c
# main.scenarios[0] = 0x4
# scenarios[0].settings = 0xb48
# settings.hudPlayerIds[0] = 0x1c
# total = 0xb84
lbz r9, 0xB84(r11)
rlwinm r9, r9, 2, 0, 29 # multiply by 4

# Get player id in 1st and multiply it by 4
# raceinfo->playerIdInEachPosition[0]
lwz r5, 0x18(r3)
lbz r5, 0(r5)
rlwinm r5, r5, 2, 0, 29

# Get raceinfo player pointers
lwz r3, 0xC(r3)
lwzx r5, r3, r5
lwzx r9, r3, r9

# Get lap progresses and calculate difference
lfs f2, 0xC(r5)
lfs f3, 0xC(r9)
fsubs f2, f2, f3

# If greater than threshold, output 1
li r3, 0
fcmpu cr0, f2, f0
ble+ end
li r3, 1

end:
stb r3, 0(r10)
mtlr r12
blr

#ENDCODE
