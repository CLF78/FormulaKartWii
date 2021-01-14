#############
# Color Fix #
#############
#INJECT 807EF7E8, 807E54D8, 807EEE54, 807DDBA8

.if (REGION == 'P')
	.set SetColorThing, 0x807EBF20
.elseif (REGION == 'U')
	.set SetColorThing, 0x807E2674
.elseif (REGION == 'J')
	.set SetColorThing, 0x807EB58C
.elseif (REGION == 'K')
    .set SetColorThing, 0x807DA2E0
.else
    .err
.endif

# First call
mr r3, r28
bl trick

.string "lap_lefft"
.align 2

trick:
mflr r4
li r5, 1

lis r12, SetColorThing@h
ori r12, r12, SetColorThing@l
mtctr r12
bctrl

# Second call
mr r3, r28
bl trick2

.string "lap_riighter"
.align 2

trick2:
mflr r4
li r5, 1

lis r12, SetColorThing@h
ori r12, r12, SetColorThing@l
mtctr r12
bctrl

# Original instruction
mr r3, r28

#ENDCODE

#################
# Fix Lap Count #
#################
#SETTYPE 0414
#INJECT 807EF76C, 807E545C, 807EEDD8, 807DDB2C

li r3, 50

#ENDCODE
