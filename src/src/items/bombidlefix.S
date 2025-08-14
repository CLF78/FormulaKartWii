.include "asm_setup.S"

.global BombIdleFix

# Check if bomb was spawned by external means and would be idling
BombIdleFix:
lwz		r4, 4(r30)
cmpwi	r4, 0x9
bne-	end

# Set explosion timer to 30 seconds
li		r0, 0x708
stw		r0, 476(r30)

# Fix r0
lwz		r0, -252(r5)

# Original instruction
end:
stw		r0, 368(r30)
blr