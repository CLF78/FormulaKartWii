###########
# Patch 1 #
###########
#INJECT 8085242C, 80857FB4, 80851A98, 808407EC

.if (REGION == 'P')
	.set RaceData, 0x809BD728
	.set MenuData, 0x809C1E38
.elseif (REGION == 'U')
	.set RaceData, 0x809B8F68
	.set MenuData, 0x809BD508
.elseif (REGION == 'J')
	.set RaceData, 0x809BC788
	.set MenuData, 0x809C0E98
.elseif (REGION == 'K')
    .set RaceData, 0x809ABD68
	.set MenuData, 0x809B0478
.else
    .err
.endif

# Check if scene is Single Player
lis r3, MenuData@ha
lwz r3, MenuData@l(r3)
lwz r3, 0(r3)
lwz r0, 0(r3)
cmpwi r0, 0x48
bne end

# Store some flags in Racedata
lis r3, RaceData@ha
lwz r3, RaceData@l(r3)
li r0, 1
stw r0, 0x1760(r3)
li r0, 5
stw r0, 0x1764(r3)

# Original instruction
end:
mr r3, r29
#ENDCODE

###########
# Patch 2 #
###########
#INJECT 805FB788, 8063BE1C, 805FB064, 805E9BA8

# Original instruction
lwz r3, 0(r3)

# Check if scene is single player
cmpwi r3, 0x48
bne end

# Replace r3
li r3, 0x4B

end:
###########
# Patch 3 #
###########
#ENDCODE

#SETTYPE COMPILED
#SETREGION P
0862D25C 60000000
20020044 00000000
0462D730 60000000
006306F3 00000072
C6852B1C 8084FB38
#ENDCODE

#SETREGION U
085FC3A8 60000000
20020044 00000000
045FC87C 60000000
005FF83F 00000072
C6821870 80830524
#ENDCODE

#SETREGION J
0862C9A8 60000000
20020044 00000000
0462CE7C 60000000
0062FE3F 00000072
C6852188 8084F1A4
#ENDCODE

#SETREGION K
0861B654 60000000
20020044 00000000
0461BB28 60000000
0061EAEB 00000072
C6840EDC 8083DEF8
#ENDCODE
