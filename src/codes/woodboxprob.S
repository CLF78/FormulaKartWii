.if (REGION == 'P')
	.set CallAddress, 0x80767328
.elseif (REGION == 'U')
	.set CallAddress, 0x8077705C
.elseif (REGION == 'J')
	.set CallAddress, 0x80766994
.elseif (REGION == 'K')
	.set CallAddress, 0x807556E8
.else
    .err
.endif

# Load address of previous BL
lwz r4, 0xA4(r1)
lis r8, CallAddress@h
ori r8, r8, CallAddress@l+4

# Check that it's for the bushes
cmpw r4, r8
beq isBush

# Else set probability to 100
li r28, 100
b end

isBush:
li r28, 65

end:
#ENDCODE
