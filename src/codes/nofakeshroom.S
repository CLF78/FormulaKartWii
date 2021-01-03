######################
# Item Check Patch 1 #
######################
#INJECT 807BA480, 807ABA20, 807B9AEC, 807A8840

# Original instruction
li r3, 0
lwz r0, 0x20(r31)

# Check for POW and Shock
cmpwi r0, 8
beq doReplacement

cmpwi r0, 0xD
bne+ end

doReplacement:
li r3, 1

end:
#ENDCODE
#SETTYPE 0616

######################
# Item Check Patch 2 #
######################
#INJECT 807BA484, 807ABA24, 807B9AF0, 807A8844

cmpwi r3, 1
beq 20
li r0, 5

#ENDCODE
