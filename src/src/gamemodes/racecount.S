.include "asm_setup.S"

.global RaceCountFix

# Add 1 to r0
RaceCountFix:
mr r31, r0
addi r0, r31, 1
blr
