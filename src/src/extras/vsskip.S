.include "asm_setup.S"

.extern Racedata
.global VSMenuSkip, VSMenuSkip2

# Load Racedata
VSMenuSkip:
lis r3, Racedata@ha
lwz r3, Racedata@l(r3)

# Gamemode = VS
li r0, 0x1
stw r0, 0x1760(r3)

# Gametype = CPU Race
li r0, 0x5
stw r0, 0x1764(r3)

# Original instruction
mr r3, r29
blr

# Original instruction
VSMenuSkip2:
lwz r3, 0x0(r3)

# Prevent array underflow
cmpwi r3, 0x48
bnelr+
li r3, 0x4B
blr
