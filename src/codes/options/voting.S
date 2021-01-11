280017B4 FF000001
#ENDCODE

#########################
# Always Win Track Vote #
#########################
#SETTYPE C2D2
#INJECT 80661E20, 80659EE4, 8066148C, 80650138

# Check that it's a friend room
lwz r12, 0(r31)
cmpwi r12, 3
bne end

# If so replace the PlayerID with the host's
li r4, 0

# Original instruction
end:
stb r4, 0x3E(r31)

#ENDCODE

#SETTYPE COMPILED
E0000000 80008000
#ENDCODE
