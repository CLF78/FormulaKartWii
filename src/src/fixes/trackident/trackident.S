.include "asm_setup.S"

.extern TrackIdentifierHook, CalcCRC32, TrackIdentifierLoad, AltKMP
.global TrackIdentifier, AltKMP1, AltKMP2, FCIAltKMP

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

FCIAltKMP:
lis r12, FCIs@ha
lbz r12, FCIs@l(r12)
cmpwi r12, 1
bne end

# Save LR
AltKMP1:
mflr r12

# Call C function
mr r3, r31
bl GetAltKMPSection

# Move result back
mr r31, r3

# Restore LR
mtlr r12

end:
# Original instruction and return
cmpwi r31, 0
blr

# Save LR
AltKMP2:
mflr r12

# Call C function
mr r3, r23
bl GetAltKMPSection

# Move result back
mr r23, r3

# Restore LR
mtlr r12

# Original instruction and return
cmpwi r23, 0
blr
