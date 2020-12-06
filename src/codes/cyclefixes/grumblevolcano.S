###########################
# Grumble Volcano Geysers #
###########################
#INJECT 806C3B28, 806E5814, 806C3194, 806B1ED0

# Check for the specific GV geysers delay values
cmpwi r0, 0xAF0
beq multiply

cmpwi r0, 0x122A
beq multiply

cmpwi r0, 0x16A8
bne+ end

# Multiply by 16
multiply:
mulli r0, r0, 16

# Original instruction
end:
stw r0, 0xE0(r30)

#########################
# Grumble Volcano Rocks #
#########################

#ENDCODE

#SETTYPE COMPILED
#SETREGION P
026E3B52 000003C0
02817F22 000003C0
#ENDCODE

#SETREGION U
026EE98E 000003C0
02805176 000003C0
#ENDCODE

#SETREGION J
026E31BE 000003C0
0281758E 000003C0
#ENDCODE

#SETREGION K
026D1EFA 000003C0
028062E2 000003C0
#ENDCODE
