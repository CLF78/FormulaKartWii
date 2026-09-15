.include "asm_setup.S"

.extern KartShrinkEnd
.global KartStarShrinkCancel

KartStarShrinkCancel:
lwz r3, 0(r31)
lwz r3, 4(r3)
lwz r0, 0xC(r3)
rlwinm. r0, r0, 0,24,24
beq end

mr r3, r31
li r4, 0
bl KartShrinkEnd

end:
lwz r4, 0(r31) # original instruction
b KartStarShrinkCancel_Hook+4