#.include "asm_setup.S"

#.extern Raceinfo
#.global MapHighlighter

# Original instruction
#MapHighlighter:
#mr r4, r31

# Get player id
#lbz r5, 0x1B4(r28)

# Check if player is in 1st
#lis r6, Raceinfo@ha
#lwz r6, Raceinfo@l(r6)
#lwz r6, 0x18(r6)
#lbz r6, 0(r6)
#cmpw r5, r6
#bnelr+

# If so, override animation
#li r4, 2
#blr
