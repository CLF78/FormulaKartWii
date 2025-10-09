.include "asm_setup.S"

.global ItemChances, ItemPool, NewbieItemPool

# Regular Items
ItemChances:

# Green Shell
.byte 34,67

# Red Shell
.byte 34,67

# Banana
.byte 34,67

# FIB
.byte 34,67

# Mushroom
.byte 34,67

# Salty Six (UNUSED)
.byte -1,-1

# Bomb
.byte 85,95

# Blue Shell
.byte 95,99

# Shock
.byte 95,99

# Star
.byte 95,99

# Golden
.byte 95,99

# Mega
.byte 85,95

# Feather
.byte 34,67

# POW
.byte 95,99

# TC (SINGLE ONLY)
.byte -1,-1

# Bullet Bill
.byte 95,99

# Triple Banana (UNUSED)
.byte -1,-1

# Triple Green (UNUSED)
.byte -1,-1

# Triple Red (UNUSED)
.byte -1,-1

# Newbie Helper Items

# Green Shell (TRIPLE ONLY)
.byte 0,0

# Red Shell (TRIPLE ONLY)
.byte 0,0

# Banana (TRIPLE ONLY)
.byte 0,0

# FIB (TRIPLE ONLY)
.byte 0,0

# Mushroom (TRIPLE ONLY)
.byte 0,0

# Salty Six (UNUSED)
.byte -1,-1

# Bomb
.byte 85,95

# Blue Shell
.byte 85,95

# Shock
.byte 85,95

# Star
.byte 34,67

# Golden (SINGLE ONLY)
.byte -1,-1

# Mega
.byte 34,67

# Feather (TRIPLE ONLY)
.byte 0,0

# POW
.byte 85,95

# TC (SINGLE ONLY)
.byte -1,-1

# Bullet Bill
.byte 85,95

# Triple Banana (UNUSED)
.byte -1,-1

# Triple Green (UNUSED)
.byte -1,-1

# Triple Red (UNUSED)
.byte -1,-1
.align 2

# Item Pools
ItemPool:
.byte 0x00, 0x01, 0x02, 0x03, 0x04, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x00, 0x01, 0x02, 0x03, 0xFF

NewbieItemPool:
.byte 0x04, 0x08, 0x09, 0x0A, 0x0B, 0x0E, 0x0F, 0xFF