.include "asm_setup.S"

.extern TrackIdentifierHook, CalcCRC32, TrackIdentifierLoad, AltKMP
.global TrackIdentifier, AltKMP1, AltKMP2

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

# Save LR
AltKMP1:
mflr r12

# Call C function
mr r3, r31
bl GetAltKMPSection

# Move result back
mr r31, r3

# Original instruction
cmpwi r31, 0

# Restore LR and return
mtlr r12
blr

# Save LR
AltKMP2:
mflr r12

# Call C function
mr r3, r23
bl GetAltKMPSection

# Move result back
mr r23, r3

# Original instruction
cmpwi r23, 0

# Restore LR and return
mtlr r12
blr
