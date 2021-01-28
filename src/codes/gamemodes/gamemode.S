#################
# Scene Swapper #
#################
#INJECT 80621E1C, 805F0F68, 80621568, 80610214

.set GameMode, 0x800017C0
.set TeamsOn, 0x800017C1

.if (REGION == 'P')
	.set SaveGame, 0x809BD748
	.set MenuData, 0x809C1E38
.elseif (REGION == 'U')
	.set SaveGame, 0x809B8F88
	.set MenuData, 0x809BD508
.elseif (REGION == 'J')
	.set SaveGame, 0x809BC7A8
	.set MenuData, 0x809C0E98
.elseif (REGION == 'K')
    .set SaveGame, 0x809ABD88
	.set MenuData, 0x809B0478
.else
    .err
.endif

# Regs: r4 (scene)
# Free registers: r0, r5 to r12, r31
# C++ Code: https://godbolt.org/z/a9s595

# Check for scenes between 0x20 and 0x27 included (Offline VS)
subi r11, r4, 31
cmplwi r11, 7
bgt check2

# Load SaveGame
lis r9, SaveGame@ha
lwz r11, SaveGame@l(r9)
lwz r12, 0x14(r11)

# Load current license
lwz r11, MenuData@l(r9)
lwz r11, 0x98(r11)
lbz r9, 0x4E8(r11)

# Get SaveGame Offset
li r10, 0
ori r10, r10, 0x8CC0
mullw r10, r9, r10

# Load byte 0x81 if single player, else 0x85 (+ 8 because of the savefile header)
# Equivalent of "0x89 + 4 * bool(scene & 3)"
rlwinm r11, r4, 0, 30, 31
subic r11, r11, 1
subfe r11, r11, r11
rlwinm r11, r11, 0, 0, 29
addi r11, r11, 0x8D

# Load byte and get two highest bits
add r11, r10, r11
lbzx r12, r12, r11
srwi r12, r12, 6
b store

# Check for scenes between 0x61 and 0x67 included (Online Friend Room VS)
check2:
subi r11, r4, 0x61
cmplwi r11, 6
bgt+ check3

# This one does not need to store the mode byte, as it will be delivered via the ROOM start packet
# If we did it here, it would get reset after the first race, which is not good! Load TeamsOn while i finish this sentence
lis r11, TeamsOn@ha
lbz r11, TeamsOn@l(r11)

# Subtract "scene & 3" to the scene id, and add 1 if teams are on
rlwinm r4, r4, 0, 24, 29
add r4, r4, r11
b end

# Final check for scenes 0x58 and 0x5E (Online WW)
check3:
cmplwi r4, 0x58
beq- storezero
cmplwi r4, 0x5E
bne+ end

storezero:
li r12, 0

# Store game mode value
store:
lis r11, GameMode@ha
stb r12, GameMode@l(r11)

# Original instruction
end:
mr r31, r4
#ENDCODE

###################
# Host Flags Hook #
###################
#INJECT 8065AE70, 806569E8, 8065A4DC, 80649188

.set GameMode, 0x800017C0
.set TeamsOn, 0x800017C1
.set VehicleRestrict, 0x800017C2
.set CharRestrict, 0x800017C3
.set DriftRestrict, 0x800017C4

# Load 0x8000 in r5
lis r5, GameMode@ha

# Move mainType to r12 and subType to r11
srwi r12, r4, 24
srwi r11, r4, 8

# Check mainType 1 (ROOM START)
cmplwi r12, 1
bne+ continueMainCheck

##############
# Room Start #
##############

# Save game mode
stb r11, GameMode@l(r5)

# Load teams flag and OR it
lbz r11, TeamsOn@l(r5)
slwi r11, r11, 23
or r4, r4, r11

# Load vehicle flag and OR it
lbz r11, VehicleRestrict@l(r5)
slwi r11, r11, 21
or r4, r4, r11

# Load character flag and OR it
lbz r11, CharRestrict@l(r5)
slwi r11, r11, 19
or r4, r4, r11

# Load drift flag and OR it
lbz r11, DriftRestrict@l(r5)
slwi r11, r11, 18
or r4, r4, r11
b end

################
# Room Message #
################

# Check mainType 4 (ROOM MESSAGE)
continueMainCheck:
cmplwi r12, 4
bne+ end

# Clear out bits > 16
addi r11, r11, 1
rlwinm r12, r11, 0, 0xFFFF

# Check subType 0x4F-0x50 (TEAMS FLAG)
subi r10, r12, 0x4F
cmplwi r10, 1
bgt+ continueSubCheck

# Value &= 1
rlwinm r11, r11, 0, 31, 31
stb r11, TeamsOn@l(r5)
b end

# Check subType 0x19-0x1C (CHAR FLAG)
continueSubCheck:
subi r10, r12, 0x19
cmplwi r10, 3
bgt+ continueSubCheck2

# Value &= 3
rlwinm r11, r11, 0, 30, 31
stb r11, CharRestrict@l(r5)
b end

# Check subType 0x1E-0x20 (KART FLAG)
continueSubCheck2:
subi r10, r12, 0x1E
cmplwi r10, 2
bgt+ continueSubCheck3

# Value = (value & 3) - bool(value & 3) // This is awkward because of the shitty message IDs
rlwinm r11, r11, 0, 30, 31
neg r12, r11
srwi r12, r12, 31
subf r11, r12, r11
stb r11, VehicleRestrict@l(r5)
b end

# Check subType 0x13-0x14 (DRIFT FLAG)
continueSubCheck3:
subi r12, r12, 0x13
cmplwi r12, 1
bgt+ end

# Value &= 1
rlwinm r11, r11, 0, 31, 31
stb r11, DriftRestrict@l(r5)

# Original instruction
end:
li r0, 2
#ENDCODE

###############
# Guest Flags #
###############
#INJECT 8065AF70, 80656AE8, 8065A5DC, 80649288

.set GameMode, 0x800017C0
.set TeamsOn, 0x800017C1
.set VehicleRestrict, 0x800017C2
.set CharRestrict, 0x800017C3
.set DriftRestrict, 0x800017C4

.if (REGION == 'P')
	.set RKNetController, 0x809C20D8
.elseif (REGION == 'U')
	.set RKNetController, 0x809BD918
.elseif (REGION == 'J')
	.set RKNetController, 0x809C1138
.elseif (REGION == 'K')
	.set RKNetController, 0x809B0718
.else
    .err
.endif

# Check if mainType is 1
srwi r11, r3, 24
cmpwi r11, 1
bnelr+

# Check if the sender is the host (prevents guests from starting rooms)
lwz r11, RKNetController@l(r30)
lwz r12, 0x291C(r11)
mulli r12, r12, 0x58
add r11, r11, r12
lbz r11, 0x5A(r11)
cmpw r11, r4
bne fakeHost

# Load 0x8000 in r12
lis r12, GameMode@ha

# Get message subType
srwi r11, r3, 8
rlwinm r11, r11, 0, 16, 31

# Store GameMode
rlwinm r10, r11, 0, 30, 31
stb r10, GameMode@l(r12)

# Store TeamsOn
srwi r10, r11, 15
stb r10, TeamsOn@l(r12)

# Store VehicleRestrict
rlwinm r10, r11, 19, 30, 31
stb r10, VehicleRestrict@l(r12)

# Store CharRestrict
rlwinm r10, r11, 21, 30, 31
stb r10, CharRestrict@l(r12)

# Store DriftRestrict
rlwinm r11, r11, 22, 31, 31
stb r11, DriftRestrict@l(r12)

# Finally, clean up the subType to remove any flag
rlwinm r3, r3, 0, 22, 7
blr

# Replace room message to prevent room from starting
fakeHost:
li r3, 0
blr
#ENDCODE

###############
# Clear Flags #
###############
#INJECT 800D1AB0, 800D1A10, 800D19D0, 800D1B10

.set EVArray, 0x800017C1

# Set all flags to 0 when starting a new room (also clears them from any previous room)
li r12, 0
lis r11, EVArray@ha
stw r12, EVArray@l(r11)
blr
#ENDCODE
