.include "asm_setup.S"

.extern WiiWheel
.global InstantDC

# Replace default instruction
InstantDC:
li r0, 0

# Load address
lis r31, WiiWheel@h
ori r31, r31, WiiWheel@l

# Check Wii Wheel/Nunchuck
lhz r30, 0(r31)
andi. r30, r30, 0x710
beq doDc

# Check classic
lhz r30, 0x60(r31)
andi. r30, r30, 0x2610
beq doDc

# Check gcn
lhz r30, 0x2A1E(r31)
andi. r31, r30, 0x11E0
beq doDc

# Check for wavebird
andi. r30, r30, 0x1160
bnelr+

# Disconnect!
doDc:
li r0, -1
blr
