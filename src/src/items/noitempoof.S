.include "asm_setup.S"

.extern GameMode
.global NoItemPoof

# Check if game mode is item rain
NoItemPoof:
lis r3, GameMode@ha
lbz r3, GameMode@l(r3)
cmpwi r3, 1
beq end

# Override r31 so the cmpwi fails
li r31, 1

# Original instruction
end:
cmpwi r31, 0
blr
