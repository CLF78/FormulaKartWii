.include "asm_setup.S"

.global KCL

# Original instruction
KCL:
mr r29, r3

# Get offset of section we want to edit
lwz r3, 0x8(r29)

# Get total count of triangles we need to check
lwz r4, 0xC(r29)
sub r5, r4, r3
srwi r5, r5, 4
mtctr r5

# Set initial offset for the loop
add r3, r3, r29
addi r3, r3, 0xE

# Loop!
loop:

# Get kcl flag
lhzu r4, 0x10(r3)

# Check if the triangle is an invisible wall
rlwinm r5, r4, 0, 27, 31
cmpwi r5, 0xD
beq invisWall
cmpwi r5, 0x14
bne+ notInvisWall

# If so replace base type with 0x1C
invisWall:
rlwinm r4, r4, 0, 0, 26
ori r4, r4, 0x1C
sth r4, 0(r3)

# Continue loop
notInvisWall:
bdnz+ loop

# Return
blr
