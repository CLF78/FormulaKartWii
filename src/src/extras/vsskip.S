.include "asm_setup.S"

.extern Racedata, VSMenuReturn2Func
.global VSMenuSkip, VSMenuSkip2, VSMenuReturn2

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
subic. r0, r3, 0x49

# Prevent array underflow
bgelr+
li r0, 2
blr

# Setup arguments for function and call it
VSMenuReturn2:
mr r5, r4
li r4, 0x41
b VSMenuReturn2Func
