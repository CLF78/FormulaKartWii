.include "asm_setup.S"

.extern OriginalTextures, DoubleShroom, ItemAmounts, AmountRandomizer, ItemRouletteUpdate1Hook, ItemRouletteUpdate2Hook
.global ItemTextures, ItemRouletteUpdate1, ItemRouletteUpdate2, ItemRouletteUpdate3, ItemRouletteUpdate4, ItemRouletteUpdate5

#####################
# Item Texture Code #
#####################

# Load texture from the array
ItemTextures:
lis r5, ItemTextureArray@h
ori r5, r5, ItemTextureArray@l
subi r4, r4, 1
slwi r4, r4, 2
mulli r3, r3, 0xC
add r3, r3, r4
add r3, r3, r5
lwz r3, 0(r3)
blr

###########################
# Item Roulette Updater 1 #
###########################

# Original instruction
ItemRouletteUpdate1:
stw r3, 0x1C(r23)

# Call randomizer
li r4, 0xC
bl AmountRandomizer

# Get amount array
lis r4, ItemAmounts@h
ori r4, r4, ItemAmounts@l

# Get player id
lwz r5, 0(r23)
lbz r5, 0x18(r5)
add r4, r4, r5

# Move previous item amount
lbz r5, 0xC(r4)
stb r5, 0(r4)

# Store new item amount
stb r3, 0xC(r4)

# Restore clobbered condition register
cmpwi r30, 0
b ItemRouletteUpdate1Hook+4

###########################
# Item Roulette Updater 2 #
###########################

# Original instruction
ItemRouletteUpdate2:
stw r3, 0x1C(r31)

# Call randomizer
li r4, 0xC
bl AmountRandomizer

# Get amount array
lis r4, ItemAmounts@h
ori r4, r4, ItemAmounts@l

# Get player id
lwz r5, 0(r31)
lbz r5, 0x18(r5)
add r4, r4, r5

# Get previous item amount and copy it
lbz r5, 0xC(r4)
stb r5, 0(r4)

# Store new item amount
stb r3, 0xC(r4)
b ItemRouletteUpdate2Hook+4

##########################
# Item Roulette Update 3 #
##########################

# Get player id
ItemRouletteUpdate3:
lbz r4, 0x18(r3)

# Load randomized item amount
lis r5, ItemAmounts@h
ori r5, r5, ItemAmounts@l
lbzx r4, r4, r5

# Original instruction
lwz r3, 0x6C(r3)
blr

##########################
# Item Roulette Update 4 #
##########################

# Get player id
ItemRouletteUpdate4:
lbz r4, 0x18(r3)

# Load randomized item amount
lis r5, ItemAmounts@h
ori r5, r5, ItemAmounts@l+0xC
lbzx r4, r4, r5

# Original instruction
lwz r3, 0x70(r3)
blr

##########################
# Item Roulette Update 5 #
##########################

# Original instruction
ItemRouletteUpdate5:
stw r0, 0x1C(r3)

# Call randomizer with player id
lwz r4, 0(r3)
lbz r4, 0x18(r4)
mr r3, r0
bl AmountRandomizer

# Our deed was done, return immediately
b ItemRouletteUpdate2Hook+0xF8

######################
# Item Texture Array #
######################

# Green Shell
ItemTextureArray:
.long OriginalTextures
.long DoubleGreen
.long OriginalTextures+0xA4

# Red Shell
.long OriginalTextures+0xC
.long DoubleRed
.long OriginalTextures+0xB4

# Banana
.long OriginalTextures+0x18
.long DoubleBanana
.long OriginalTextures+0xC0

# FIB
.long OriginalTextures+0x20
.long DoubleFIB
.long TripleFIB

# Mushroom
.long OriginalTextures+0x2C
.long DoubleShroom
.long OriginalTextures+0x34

# Triple Mushroom
.long OriginalTextures+0x2C
.long DoubleShroom
.long OriginalTextures+0x34

# Bomb
.long OriginalTextures+0x40
.long DoubleBomb
.long TripleBomb

# Blue Shell
.long OriginalTextures+0x4C
.long DoubleBlue
.long TripleBlue

# Shock
.long OriginalTextures+0x58
.long DoubleShock
.long TripleShock

# Star
.long OriginalTextures+0x60
.long DoubleStar
.long TripleStar

# Golden
.long OriginalTextures+0x68
.long DoubleGolden
.long TripleGolden

# Mega
.long OriginalTextures+0x78
.long DoubleMega
.long TripleMega

# Feather
.long OriginalTextures+0x84
.long DoubleFeather
.long TripleFeather

# POW
.long OriginalTextures+0x8C
.long DoublePOW
.long TriplePOW

# Thundercloud
.long OriginalTextures+0x90
.long OriginalTextures+0x90
.long OriginalTextures+0x90

# Bullet Bill
.long OriginalTextures+0x9C
.long DoubleBill
.long TripleBill

# Triple Green Shell
.long OriginalTextures
.long DoubleGreen
.long OriginalTextures+0xA4

# Triple Red Shell
.long OriginalTextures+0xC
.long DoubleRed
.long OriginalTextures+0xB4

# Triple Banana
.long OriginalTextures+0x18
.long DoubleBanana
.long OriginalTextures+0xC0

# Empty reserved spots
.zero 24

#####################
# Item Pane Strings #
#####################

DoubleGreen:
.string "d-green"

DoubleRed:
.string "d-red"

DoubleBanana:
.string "d-banana"

DoubleFIB:
.string "d-fib"

DoubleBomb:
.string "d-bomb"

DoubleBlue:
.string "d-blue"

DoubleShock:
.string "d-shock"

DoubleStar:
.string "d-star"

DoubleGolden:
.string "d-golden"

DoubleMega:
.string "d-mega"

DoubleFeather:
.string "d-feather"

DoublePOW:
.string "d-pow"

DoubleBill:
.string "d-bill"

TripleFIB:
.string "t-fib"

TripleBomb:
.string "t-bomb"

TripleBlue:
.string "t-blue"

TripleShock:
.string "t-shock"

TripleStar:
.string "t-star"

TripleGolden:
.string "t-golden"

TripleMega:
.string "t-mega"

TripleFeather:
.string "t-feather"

TriplePOW:
.string "t-pow"

TripleBill:
.string "t-bill"

.align 2
