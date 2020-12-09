# Original instruction
lwz r30, 0x14(r6)

# Get current item amount
lwz r3, -0x24(r27)

# Check if it's more than 1. If not, skip
cmpwi r3, 1
ble+ end

# Get current item
lwz r3, -0x28(r27)

# Bananas will be set to trail mode
cmpwi r3, 1
beq doItemTrail

# Greens, Reds and FIBs will be set to circling mode instead
cmpwi r3, 3
ble doItemRotate

# Same for Bombs
cmpwi r3, 6
beq doItemRotate

# And finally, same for Blue Shells
cmpwi r3, 7
bne+ end

doItemRotate:
    li r30, 3
    b end

doItemTrail:
    li r30, 2

end:
#ENDCODE
