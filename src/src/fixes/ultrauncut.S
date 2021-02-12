.include "asm_setup.S"

.global UltraUncut

# Load Key CKPT count
UltraUncut:
lbz r3, 0x1C(r29)
cmplwi r3, 1
ble+ end

# Force compare to be true
mr r0, r30

# Original instruction
end:
cmplw r30, r0
blr
