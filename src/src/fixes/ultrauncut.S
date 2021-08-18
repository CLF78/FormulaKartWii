.include "asm_setup.S"

.extern CKPTCheck
.global UltraUncut

# Original instruction
UltraUncut:
lhz r0, 0x1A(r3)

# Load Key CKPT count and check if it's more than 1
lbz r3, 0x1C(r29)
cmplwi r3, 1
ble+ end

# Force compare to be true if so
mr r0, r30

# Skipped instruction
end:
cmplw r30, r0
b CKPTCheck+8
