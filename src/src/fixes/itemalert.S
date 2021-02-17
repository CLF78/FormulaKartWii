.include "asm_setup.S"

.extern TimeDiff, Speedometer, ItemAlertFixHook, TimerInstance
.global ItemAlertFix

# Load current screen
ItemAlertFix:
lwz r5, 0x4(r3)

# Check for Offline VS
cmpwi r5, 0xE
beq+ increment

# Check for Online WW
cmpwi r5, 0x40
beq increment

# Check for Online Froom
subi r12, r5, 0x42
cmplwi r12, 1
bgt+ end

# Load 0x8000 in r5
increment:
lis r5, TimeDiff@ha

# Add 1 for Time Difference
lbz r0, TimeDiff@l(r5)
cmpwi r0, 'w'
beq+ continue
addi r4, r4, 1

# Also reset TimerInstance (class size = 0xC)
li r0, 0
stw r0, TimerInstance@l(r5)
stw r0, TimerInstance@l+4(r5)
stw r0, TimerInstance@l+8(r5)

# Add 1 for Speedometer
continue:
lbz r0, Speedometer@l(r5)
cmpwi r0, 1
bne+ end
addi r4, r4, 1

# Original instruction
end:
mr r5, r4
b ItemAlertFixHook+4
