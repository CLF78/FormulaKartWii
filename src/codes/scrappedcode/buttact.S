.set PlayerArray, 0x800001B0

.if (REGION == 'P')
	.set InputData, 0x809BD70C
	.set AnalogStick, 0x80350580
	.set PeripheralType, 0x8034583C
.elseif (REGION == 'U')
	.set InputData, 0x809B8F4C
	.set AnalogStick, 0x8034C200
	.set PeripheralType, 0x803414BC
.elseif (REGION == 'J')
	.set InputData, 0x809BC76C
	.set AnalogStick, 0x8034FF00
	.set PeripheralType, 0x803451BC
.elseif (REGION == 'K')
	.set InputData, 0x809ABD4C
	.set AnalogStick, 0x8033E580
	.set PeripheralType, 0x8033383C
.else
    .err
.endif

# Register Info
# r12 = PlayerArray
# r11 = InputData
# r10 = Current player
# r3 = Current player's button
# r4 = Current player's quantised stick Y

# Initialize array
li r10, 0
lis r12, PlayerArray@h
ori r12, r12, PlayerArray@l
stw r10, 0(r12)

# Load InputData class in r12
lis r11, InputData@ha
lwz r11, InputData@l(r11)
b finishLoop

# Loop starts here!
beginLoop:

###########
# Generic #
###########
# Load rawinput value and quantisedStickY from inputData (used for all controllers)
mulli r9, r10, 0xEC
addi r9, r9, 0x32
lhzx r3, r9, r11
addi r9, r9, 0xC
lbzx r4, r9, r11

####################
# Peripheral Check #
####################
# Load peripheral type
lis r9, PeriperhalType@h
ori r9, r9, PeripheralType@l
mulli r8, r10, 0x538
lbzx r8, r8, r9

cmpwi r8, 2
beq Classic

cmpwi r8, 1
beq Nunchuck

cmpwi r8, 0
bne invalid

# This is for both the GCN and Wiimote
# Determine if L is being pressed. This input does not exist on the Wiimote, so we can definitely check if the player is using Wheel or GCN
andi. r8, r3, 0x40
bne 



# Store 1 to the current player
valid:
li r9, 1
stbx r9, r10, r12

# Add 1 for next player
invalid:
addi r10, r10, 1

# Check that we reached the end of the loop
finishLoop:
cmpwi r10, 3
blt+ beginLoop
blr