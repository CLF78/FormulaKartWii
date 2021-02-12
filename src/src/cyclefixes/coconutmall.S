.include "asm_setup.S"

.global EscalatorFix, PiantaFix

#################
# Escalator Fix #
#################

# Subtract 324 frames to let the animation play
EscalatorFix:
lwz r0, 0x174(r30)
subi r3, r31, 324
cmplw r0, r3
bnelr+

# Calculate the difference between the timers
mr r4, r0
lwz r3, 0x170(r30)
sub r3, r4, r3

# Add it once to the first timer
add r4, r4, r3
stw r4, 0x170(r30)

# Add it twice to the second
add r4, r4, r3
stw r4, 0x174(r30)
blr

##############
# Pianta Fix #
##############

# Subtract 324 frames to let the animation play
PiantaFix:
lwz r3, 0xBC(r30)
subi r12, r29, 324
cmpw r3, r12
bnelr+

# Calculate the difference between the timers
mr r11, r3
lwz r12, 0xB8(r30)
sub r12, r11, r12

# Add it once to the first timer
add r11, r11, r12
stw r11, 0xB8(r30)

# Add it twice to the second
add r11, r11, r12
stw r11, 0xBC(r30)
blr
