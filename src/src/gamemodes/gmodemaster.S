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
bne+ end

# Don't do anything on frame 0
cmpwi r3, 0
beq end

# Check if the timer is a multiple of 30 seconds
li r31, 1800
divw r31, r3, r31
mulli r31, r31, 1800
subf. r31, r31, r3
bne+ end

# Do it!
bl DoSabotage

# Return
end:
b TimerManagerHook+4
