.include "asm_setup.S"

.extern FirstCall, NoMultiChannelHook
.global NoMultiChannel

# Get address of earliest call in memory we want to kill
NoMultiChannel:
lis r6, FirstCall@h
ori r6, r6, FirstCall@l+4

# Get caller
mflr r7

# Exit function if the caller is in the range FirstCall+0x1464
sub r7, r7, r6
cmplwi r7, 0x1464
blelr+

# Original instruction
stwu sp, -0x20(sp)
b NoMultiChannelHook+4
