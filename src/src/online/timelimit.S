.include "asm_setup.S"

.global NewTimeLimit
.set Timer, 0x36EE80

NewTimeLimit:
lis r4, Timer@h
ori r4, r4, Timer@l
