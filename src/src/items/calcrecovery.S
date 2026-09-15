.include "asm_setup.S"

.global CalcRecovery_Push, CalcRecovery_Pop

CalcRecovery_Push:
mr r29, r3
stw r28, 0x10(r1)
mr r28, r6
blr

CalcRecovery_Pop:
lwz r29, 0x14(r1)
lwz r28, 0x10(r1)
blr