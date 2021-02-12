.include "asm_setup.S"

.global ExceptionRecovery

# Preserve r3 in SPRG0
ExceptionRecovery:
mtsprg0 r3

# Move on to the next instruction
mfsrr0 r3
addi r3, r3, 4
mtsrr0 r3

# Restore r3
mfsprg0 r3

# Return to the program
rfi
