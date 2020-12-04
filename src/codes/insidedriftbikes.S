# Original instruction
lwz r5, 4(r4)

# Check if type is 1
cmpwi r5, 1
bne+ end
li r5, 2

end:
#ENDCODE
