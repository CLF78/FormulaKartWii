.include "asm_setup.S"

.extern AlwaysWinVote
.global FlagReset

FlagReset:
li r12, 0
lis r11, AlwaysWinVote@ha
stw r12, AlwaysWinVote@l(r11)
blr
