.include "asm_setup.S"

.extern GetNKCPs, InsertKCPs, KCPMapHook, KCPMapHook1
.global KCPMapInject, KCPMapInject1

KCPMapInject:
bl GetNKCPs
add r26, r26, r3

mr r3, r24  #original instruction
b KCPMapHook+4

KCPMapInject1:
mr r3, r24
mr r4, r28
addi r5, r1, 0x20
bl InsertKCPs
mr r28, r3

lis r25, -0x7f64 #original instruction
b KCPMapHook1+4

