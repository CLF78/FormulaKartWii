.include "asm_setup.S"

.extern MirrorOn
.global ForceCC

# Force 150cc or Mirror depending on the flag
ForceCC:
lis r5, MirrorOn@ha
lbz r5, MirrorOn@l(r5)
addi r5, r5, 2

# Store it directly
stb r5, 0x3F(r3)
blr
