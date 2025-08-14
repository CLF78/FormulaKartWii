.include "asm_setup.S"

.global UnBeanCorner

# Lower dem wallz
UnBeanCorner:
ori r25, r25, 0x400
stw r25, 120(r28)
blr