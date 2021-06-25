.include "asm_setup.S"

.global GeyserFix, RockFix2

###########
# Geysers #
###########

# Check for the specific GV geysers delay values
GeyserFix:
cmpwi r0, 0xAF0
beq multiply

cmpwi r0, 0x122A
beq multiply

cmpwi r0, 0x16A8
bne+ end

# Multiply by 16
multiply:
slwi r0, r0, 4

# Original instruction
end:
stw r0, 0xE0(r30)
blr

#########################
# Grumble Volcano Rocks #
#########################

# Load rock type
RockFix2:
lha r12, 0x2A(r5)

# Modified original instruction
mulli r5, r4, 0x3C0

# Sink if type is 1 or 13
cmpwi r12, 1
beq setZero

cmpwi r12, 13
bnelr+

setZero:
li r5, 0
blr
