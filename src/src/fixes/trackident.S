.include "asm_setup.S"

.extern TrackIdentifierHook, CalcCRC32, TrackIdentifierLoad, AltKMP, delete
.global TrackIdentifier, TrackIdentifier2

# Hook from HNS
# Original instruction
TrackIdentifier:
stw r3, 0(r25)

# Calculate CRC
mr r3, r26
mulli r4, r27, 0x14
bl CalcCRC32

# Call C function
bl TrackIdentifierLoad

# Return
b TrackIdentifierHook+4

# Load AltKMP address
TrackIdentifier2:
lis r4, AltKMP@h
ori r4, r4, AltKMP@l

# Check if AltKMP exists
lwz r3, 0(r4)
cmpwi r3, 0
beqlr

# Store 0 to static instance
li r0, 0
stw r0, 0(r4)

# Delete the file allocation (does not return)
b delete
