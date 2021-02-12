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

# Modified original instruction
RockFix2:
mulli r5, r4, 0x3C0

# Load X coordinate
lwz r12, 0x0114(r30)

# Check if it's the Ultra Shortcut rock
lis r4, 0xC6BE
ori r4, r4, 0x6EA1
cmpw r4, r12
beq setzero

# Check if it's the Rock Hop rock
lis r4, 0x4430
ori r4, r4, 0x22DC
cmpw r4, r12
bnelr+

setzero:
li r5, 0
blr
