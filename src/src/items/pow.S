.include "asm_setup.S"

.extern POWSelfHook
.global POWSelf, POWDelay

# Original instruction
POWSelf:
cmpw r4, r6
bne+ end

# Check if player who used the POW is in 1st (use cr7 to avoid overriding cr0)
cmpwi cr7, r31, 1
bne+ cr7, end

# If so clear cr0+EQ
crclr eq

# Return
end:
b POWSelfHook+4

# Written as array!
POWDelay:
nop
li r0, 0x80
