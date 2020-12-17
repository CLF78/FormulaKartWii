# Original instruction
lbz r0, 0x29(r3)

# Get item
lwz r29, 0x4(r3)

# Check shock
cmpwi r29, 8
beq doReplacement

# Check pow
cmpwi r29, 0xD
bne+ end

doReplacement:
li r0, 1

end:
#ENDCODE
