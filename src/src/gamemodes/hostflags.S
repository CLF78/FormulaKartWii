.include "asm_setup.S"

.extern GameMode, AlwaysWinVote, MirrorOn, TeamsOn, VehicleRestrict, RandomCombos, HostFlagsHook
.global HostFlags

# Load 0x8000 in r5
HostFlags:
lis r5, GameMode@ha

# Move mainType to r12
srwi r12, r4, 24

# Check mainType 1 (ROOM START)
cmplwi r12, 1
bne+ continueMainCheck

##############
# Room Start #
##############

# Save game mode
ori r5, r5, GameMode@l
srwi r11, r4, 8
stb r11, 0(r5)

# Setup loop
li r12, 5
mtctr r12
lis r12, shifts@h
ori r12, r12, shifts@l-1

# Load flag and shift
loop:
lbzu r11, 1(r5)
lbzu r6, 1(r12)

# Shift and OR
slw r11, r11, r6
or r4, r4, r11

# Continue the loop
bdnz+ loop

# Go to end
b end

################
# Room Message #
################

# Check mainType 4 (ROOM MESSAGE)
continueMainCheck:
cmplwi r12, 4
bne+ end

# Move subtype to r12
rlwinm r12, r4, 24, 16, 31

# Store AlwaysWinVote
cmpwi r12, 1
bgt continueSubCheck

# Flag = !MSG
xori r12, r12, 1
stb r12, AlwaysWinVote@l(r5)
b end

# Store MirrorOn
continueSubCheck:
cmpwi r12, 3
bgt continueSubCheck2

# Flag = !(MSG & 1)
rlwinm r12, r12, 0, 31, 31
xori r12, r12, 1
stb r12, MirrorOn@l(r5)
b end

# Store AlwaysWinVote
continueSubCheck2:
cmpwi r12, 5
bgt continueSubCheck3

# Flag = !(MSG & 1)
rlwinm r12, r12, 0, 31, 31
xori r12, r12, 1
stb r12, TeamsOn@l(r5)
b end

# Store VehicleRestrict
continueSubCheck3:
cmpwi r12, 8
bgt continueSubCheck4

# Flag = (MSG - 6)
subi r12, r12, 6
stb r12, VehicleRestrict@l(r5)
b end

# Store Random Character/Vehicles
continueSubCheck4:
cmpwi r4, 10
bgt end

# Flag = (MSG & 1)
rlwinm r12, r12, 0, 31, 31
stb r12, RandomCombos@l(r5)

# Original instruction
end:
li r0, 2
b HostFlagsHook+4

########
# Data #
########

shifts:
.byte 23, 22, 21, 19, 18
.align 4
