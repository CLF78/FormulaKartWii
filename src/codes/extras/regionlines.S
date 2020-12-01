# Grab Disc/ISO Version
lbz r4, 0x0184 (r3)

# Disc/ISO Byte Checks
cmpwi r4, 0x45
beq- usa_regid

cmpwi r4, 0x4A
beq- jpn_ortwn

cmpwi r4, 0x4B
beq- kor_regid

cmpwi r4, 0x50
beq- euro_oraus

# White Line Label
# This label will apply white line as a safety net if the disc/iso byte is not recognized
# If somebody has a Taiwan white line, they will also get navigated to this label
white_line:
	li r4, 0xF
	b the_end

# Blue Line Label
usa_regid:
	li r4, 0x1
	b the_end

# Purple Line Label
kor_regid:
	li r4, 0x5
	b the_end

# Japan Game Country Code Check
# Since Taiwan region is part of the Japan disc/ISO, we need to check the person's country code
# If the user hasn't set their flag, their country code will be 0xFF, meaning we will later need to check their globe position
jpn_ortwn:
	lbz r12, 0x0178 (r3)

	cmpwi r12, 0x80
	beq- white_line

	cmpwi r12, 0xFF
	beq- check_globe1

# Red Line Label
its_jpn:
	li r4, 0x0
	b the_end

# PAL Game Country Code Check
# Since AUS/NZ region is part of the PAL disc/ISO, we need to check the person's country code to see if they have the AUS or NZ country code
# If the user hasn't set their flag, their country code will be 0xFF, meaning we will later need to check their globe position
euro_oraus:
	lbz r12, 0x178 (r3)

	cmpwi r12, 0x41
	beq- its_aus

	cmpwi r12, 0x5F
	beq- its_aus

	cmpwi r12, 0xFF
	beq- check_globe2

# Green Line Label
its_eur:
	li r4, 0x2
	b the_end

# Globe Position Checks for Japan game
check_globe1:
	lbz r12, 0x017C (r3)

	cmpwi r12, 0x11
	beq- white_line

	b its_jpn

# Globe Position Checks for PAL Game
check_globe2:
	lbz r12, 0x17C (r3)

	cmpwi r12, 0xE6
	beq- its_aus

	b its_eur

# Yellow Line Label
its_aus:
	li r4, 0x3

# Default instruction not needed
the_end:

#ENDCODE
