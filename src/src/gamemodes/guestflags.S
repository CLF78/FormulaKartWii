.include "asm_setup.S"

.extern RKNetController, GameMode, AlwaysWinVote, MirrorOn, TeamsOn, VehicleRestrict
.global GuestFlags

# Check if mainType is 1
GuestFlags:
srwi r11, r3, 24
cmpwi r11, 1
bnelr+

# Check if the sender is the host (prevents guests from starting rooms)
# Code by Seeky
lwz r11, RKNetController@l(r30)
lwz r12, 0x291C(r11)
mulli r12, r12, 0x58
add r11, r11, r12
lbz r11, 0x5A(r11)
cmpw r11, r4
bne fakeHost

# Load 0x8000 in r12
lis r12, GameMode@ha

# Store GameMode
rlwinm r11, r3, 24, 30, 31
stb r11, GameMode@l(r12)

# Store AlwaysWinVote
rlwinm r11, r3, 9, 31, 31
stb r11, AlwaysWinVote@l(r12)

# Store MirrorOn
rlwinm r11, r3, 10, 31, 31
stb r11, MirrorOn@l(r12)

# Store TeamsOn
rlwinm r11, r3, 11, 31, 31
stb r11, TeamsOn@l(r12)

# Store VehicleRestrict
rlwinm r11, r3, 13, 30, 31
stb r11, VehicleRestrict@l(r12)

# Finally, clean up the subType to remove any flag
rlwinm r3, r3, 0, 22, 7
blr

# Replace room message to prevent room from starting
fakeHost:
li r3, 0
blr
