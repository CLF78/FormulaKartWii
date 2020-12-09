.set LapFloat, 0x800014B0

.if (REGION == 'P')
	.set THING, 0x809C3618
	.set RACEINFO, 0x809BD730
.elseif (REGION == 'U')
	.set THING, 0x809BEE20
	.set RACEINFO, 0x809B8F70
.elseif (REGION == 'J')
	.set THING, 0x809C2678
	.set RACEINFO, 0x809BC790
.elseif (REGION == 'K')
	.set THING, 0x809B1C58
    .set RACEINFO, 0x809ABD70
.else
    .err
.endif

# Max lap diff
.float 1.0

# Push stack (4 registers without LR save)
__push_stack r28, 0x20, NONE

# Load raceinfo
lis r31, RACEINFO@ha
lwz r31, RACEINFO@l(r31)

# Get difference threshold
lis r30, LapFloat@ha
lfs f0, LapFloat@l(r30)

# Get the playerId from r23
mr r28, r23
subi r28, r28, 0x54

lis r30, THING@ha
lwz r30, THING@l(r30)
lwz r30, 0x14(r30)
sub r30, r28, r30
li r29, 0x248
divw r30, r30, r29

# Get player id in 1st and multiply it by 4
# raceinfo->playerIdInEachPosition[0]
lwz r28, 0x18(r31)
lbz r28, 0(r28)
rlwinm r28, r28, 2, 0, 29

# Get raceinfo player pointers
lwz r31, 0xC(r31)
lwzx r28, r31, r28
lwzx r29, r31, r29

# Get lap progresses and calculate difference
lfs f2, 0xC(r28)
lfs f3, 0xC(r29)
fsubs f2, f2, f3

# If greater than threshold, output 1
li r5, 0
fcmpu cr0, f2, f0
ble+ end
li r5, 1

# Pop the stack and return
end:
__pop_stack r28, 0x20, NONE
blr

#ENDCODE
