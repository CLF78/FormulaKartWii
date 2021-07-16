.include "asm_setup.S"

.extern GameMode, TeamsOn, Racedata
.global GameModeSelector, BattleFix

# Check for scene 0x1A (Offline VS)
GameModeSelector:
cmpwi r4, 0x1A
bne+ check2

# Load item setting and store it
lis r12, Racedata@ha
lwz r12, Racedata@l(r12)
lwz r12, 0xB80(r12)
b store

# Check for scenes between 0x60 and 0x67 included (Online Friend Room VS)
check2:
subi r11, r4, 0x60
cmplwi r11, 7
bgt+ check3

# This one does not need to store the mode byte, as it will be delivered via the ROOM start packet.
# If we did it here, it would get reset after the first race, which is not good!
lis r11, TeamsOn@ha
lbz r11, TeamsOn@l(r11)

# Subtract (scene & 3) to the scene id, and add 1 if teams are on
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
blr

BattleFix:
li r3, 0
blr
