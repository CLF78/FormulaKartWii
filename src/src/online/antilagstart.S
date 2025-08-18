.include "asm_setup.S"

.global AntiLagStart

# Wait for everyone to have sent the READY event, including yourself, before counting down.
AntiLagStart:
lwz		r12, -10456(r30)
lwz		r12, 2928(r12)
cmpwi	r12, 0x7
blt-	end
li		r3, 0x1

# Original Instruction
end:
cmpwi	r3, 0x0
blr
