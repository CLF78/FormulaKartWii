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

# Load byte 0x81 if single player, else 0x85
# Equivalent of "0x81 + 4 * bool(scene & 3)"
rlwinm r11, r4, 0, 30, 31
subic r11, r11, 1
subfe r11, r11, r11
rlwinm r11, r11, 0, 0, 29
addi r11, r11, 0x85

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
rlwinm r4, r4, 0, 0xFF
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
#INJECT 8065AEC0, 80656A38, 8065A52C, 806491D8

.set TeamsOn, 0x800017C1
.set CharRestrict, 0x800017C2
.set VehicleRestrict, 0x800017C3

# Get message main type
srwi r12, r4, 24

# Type 1, start room
cmpwi r12, 1
beq startEvent

# Type 4, normal room message
cmpwi r12, 4
bne end

#######################
# Normal Message Type #
#######################

# Get message subtype and check if we should change any local flag
extrwi r11, r4, 16, 8
lis r10, TeamsOn@ha

# Team enable/disable (0x4F-0x50)
subi r12, r11, 0x4F
cmplwi r12, 1
bgt+ check2
rlwinm r11, r11, 0, 31, 31
stb r11, TeamsOn@l(r10)
b end

# Character restriction (0x19-0x1C)
check2:
subi r12, r11, 0x19
cmplwi r12, 3
bgt+ check3
rlwinm r11, r11, 0, 30, 31
stb r11, CharRestrict@l(r10)
b end

# Vehicle restriction (0x1E-0x20)
check3:
subi r12, r11, 0x1E
cmplwi r12, 2
bgt+ end
subfic r11, r11, 0x20
stb r11, VehicleRestrict@l(r10)
b end

###################
# Start Room Type #
###################

# Load teams
startEvent:
lis r12, TeamsOn@ha
lbz r11, TeamsOn@l(r12)
inslwi r4, r11, 1, 9

# Load vehicle restriction
lbz r11, VehicleRestrict@l(r12)
inslwi r4, r11, 2, 10

# Load character restriction
lbz r11, CharRestrict@l(r12)
inslwi r4, r11, 2, 12

# Original instruction
end:
stw r4, 0xC(r3)

#ENDCODE
