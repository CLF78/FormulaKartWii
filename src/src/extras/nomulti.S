.include "asm_setup.S"

.extern FirstCall, NoMultiChannelHook, CurrentStrmChannels
.global NoMultiChannel, NoMultiChannel2

# Get address of earliest call in memory we want to kill
NoMultiChannel:
lis r6, FirstCall@h
ori r6, r6, FirstCall@l+4

# Get caller
mflr r7

# Execute function if the caller is not in the range FirstCall+0x1464
sub r7, r7, r6
cmplwi r7, 0x1464
bgt execute

# Check if the chosen stream exists at all, and if not return
lis r6, CurrentStrmChannels@ha
lbz r6, CurrentStrmChannels@l(r6)
cmpw r4, r6
bgtlr

# Original instruction
execute:
stwu sp, -0x20(sp)
b NoMultiChannelHook+4

# Original instruction
NoMultiChannel2:
lbz r0, 0x2(r3)

# Store number of channels in the exception vector
srwi r5, r0, 1
subi r5, r5, 1
lis r4, CurrentStrmChannels@ha
stb r5, CurrentStrmChannels@l(r4)
blr
