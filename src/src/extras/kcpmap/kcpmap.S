.include "asm_setup.S"

.extern KMPdata, GetNKCPs, InsertKCPs, KCPMapHook, KCPMapHook1
.global KCPMap, KCPMap1

KCPMap:
mr r25, r3  #save r3
bl GetNKCPs
add r26, r27, r3
mr r3, r25  #restore r3
lis r4,-0x7f64 #restore r4 (redundant cause the compiler doesn't use it from testing but just in case)
b KCPMapHook+4

KCPMap1:
mr r3, r24
mr r4, r28
addi r5, r1, 0x20
bl InsertKCPs
mr r28, r3
lis r25, -0x7f64
b KCPMapHook1+4

