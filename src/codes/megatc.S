.if (REGION == 'P')
	.set ADDR1, 0x807986B4
	.set ADDR2, 0x809C38B9
.elseif (REGION == 'U')
	.set ADDR1, 0x8078F6A8
	.set ADDR2, 0x809AF0B1
.elseif (REGION == 'J')
	.set ADDR1, 0x80797D20
	.set ADDR2, 0x809C2919
.elseif (REGION == 'K')
	.set ADDR1, 0x80776A74
	.set ADDR2, 0x809B1EF9
.else
    .err
.endif

lis r12, ADDR1@h
ori r12, r12, ADDR1@l
mtlr r12
blrl

lis r3, ADDR2@ha
lbz r0, ADDR2@l(r3)
cmpwi r0, 0
beq end

li r3, 0x8
li r4, 0xC

end:
#ENDCODE
