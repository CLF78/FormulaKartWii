.include "asm_setup.S"

.global PauseMenuScreen
.extern CreateScreen

# Store LR over original r31 since it does not matter
PauseMenuScreen:
mflr r0
stw r0, 0xC(r1)

# Create "Are you sure you want to quit?" screen, the game handles the rest by itself
mr r3, r31
li r4, 0x2C
bl CreateScreen

# Original instruction
mr r3, r31

# Restore LR and return
lwz r0, 0xC(r1)
mtlr r0
blr
