.include "asm_setup.S"

.extern GameMode
.global GameModeMaster

# Original instruction
GameModeMaster:
stw r0, 0x48(r29)

# Initial setup for Sabotage
lis r31, GameMode@ha
lbz r31, GameMode@l(r31)
cmpwi r31, 1
bne+ doFPS

# Don't do anything on frame 0
cmpwi r3, 0
beq doFPS

# Check if the timer is a multiple of 30 seconds
li r31, 1800
divw r31, r3, r31
mulli r31, r31, 1800
subf. r31, r31, r3
bne+ doFPS

# Do it!
bl DoSabotage

# 30 FPS
doFPS:
bl ThirtyFPS

# Return
b TimerManagerHook+4
