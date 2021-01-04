#SETREGION P
# This code is PAL-only, so no need for address ports
.set SCGetLanguage, 0x801B1D0C

# First, store r3 (original instruction)
stw r3, 0x20(r1)

# Call SCGetLanguage
lis r12, SCGetLanguage@h
ori r12, r12, SCGetLanguage@l
mtlr r12
blrl

# Check if language is Spanish
cmpwi r3, 4
li r4, 55
beq messageChecks2

# Check if language is English
cmpwi r3, 1
li r4, 57
bne+ end

# Check that the messages match
cmpwi r14, 0x14C7
beq doReplacement

cmpwi r14, 0x14C8
beq doReplacement

messageChecks2:
cmpwi r14, 0x14BF
beq doReplacement

cmpwi r14, 0x14C0
bne+ end

# Load character we want to replace
li r12, '2'

# Reload pointer
doReplacement:
lwz r3, 0x20(r1)

# Store byte at index
stbx r12, r4, r3

end:
#ENDCODE

#SETREGION U
# This code is NTSC-U only, so no need for address ports
.set SCGetLanguage, 0x801B1C6C

# First, store r3 (original instruction)
stw r3, 0x20(r1)

# Call SCGetLanguage
lis r12, SCGetLanguage@h
ori r12, r12, SCGetLanguage@l
mtlr r12
blrl

# Check Spanish
cmpwi r3, 4
bne+ end

# Check that the message matches
cmpwi r14, 0x14BF
beq doReplacement

cmpwi r14, 0x14C0
bne+ end

# Load character we want to replace
li r12, '2'

# Reload pointer
doReplacement:
lwz r3, 0x20(r1)

# Store byte at index
stb r12, 53(r3)

end:
#ENDCODE
