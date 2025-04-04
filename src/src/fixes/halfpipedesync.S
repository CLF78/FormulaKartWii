.include "asm_setup.S"

.global HalfPipeFix

# Fix the half-pipe desync online when a player goes
# out of bounds directly from the half-pipe state
HalfPipeFix:
lwz     r11, 8(r4)
rlwinm. r12, r11, 0, 21, 21
beq-    end
lha     r0, 86(r31)
cmpwi   r0, 0x52
blt-    end
rlwinm  r11, r11, 0, 22, 20
stw     r11, 8(r4)

end:
mr      r4, r11
blr