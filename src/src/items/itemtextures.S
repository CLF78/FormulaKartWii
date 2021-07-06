.include "asm_setup.S"

.extern ItemTexturesHook, OriginalTextures, DoubleShroom
.global ItemTextures

#####################
# Item Texture Code #
#####################

# Check if we have the item
ItemTextures:
cmpwi r4, -1
beq doOriginal

# If so, load from the array
lis r5, ItemTextureArray@h
ori r5, r5, ItemTextureArray@l
mulli r3, r3, 12
subi r4, r4, 1
slwi r4, r4, 2
add r3, r3, r4
add r3, r3, r5
lwz r3, 0(r3)
blr

# Original instruction
doOriginal:
cmpwi r3, 0x5
b ItemTexturesHook+4

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
