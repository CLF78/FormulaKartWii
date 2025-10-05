.include "asm_setup.S"

.global AntiLagStart
.extern Racedata

# Instantly start the countdown if you're late to the party!
AntiLagStart:
lwz		r12, Racedata@l(r30)
lwz		r12, 0xB70(r12)
cmpwi	r12, 0x7
blt-	end
li		r3, 0x1

# Original Instruction
end:
cmpwi	r3, 0x0
blr
