.include "asm_setup.S"

.extern WiiWheel
.global InstantDC

# Replace default instruction
InstantDC:
li r0, 0

# Load address
lis r30, WiiWheel@h
ori r30, r30, WiiWheel@l

# Check Wii Wheel/Nunchuck
lhz r29, 0(r30)
cmpwi r29, 0x710
beq doDc

# Check classic
lhz r29, 0x60(r30)
cmpwi r29, 0x2610
beq doDc

# Check gcn
lhz r29, 0x2A1E(r30)
cmpwi r29, 0x11E0
beq doDc

# Check for wavebird
cmpwi r29, 0x1160
bnelr+

# Disconnect!
doDc:
li r0, 0x5466
blr
