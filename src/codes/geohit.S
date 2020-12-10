.if (REGION == 'P')
    .set GeoHitTableKartObj, 0x808D8044
    .set GeoHitTableKart, 0x808D805C
    .set GeoHitTableItemObj, 0x808D8070
    .set GeoHitTableItem, 0x808D8088
.elseif (REGION == 'U')
    .set GeoHitTableKartObj, 0x808D2664
    .set GeoHitTableKart, 0x808D267C
    .set GeoHitTableItemObj, 0x808D2690
    .set GeoHitTableItem, 0x808D26A8
.elseif (REGION == 'J')
    .set GeoHitTableKartObj, 0x808D7194
    .set GeoHitTableKart, 0x808D71AC
    .set GeoHitTableItemObj, 0x808D71C0
    .set GeoHitTableItem, 0x808D71D8
.elseif (REGION == 'K')
    .set GeoHitTableKartObj, 0x808C64DC
    .set GeoHitTableKart, 0x808C64F4
    .set GeoHitTableItemObj, 0x808C6508
    .set GeoHitTableItem, 0x808C6520
.else
    .err
.endif

# Original instruction
li r4, 0

# Move low 16 bits to r7
clrlwi r7, r6, 16

# Compare r7 to the addresses
cmpwi r7, GeoHitTableItem@l
beq doLoad

cmpwi r7, GeoHitTableItemObj@l
bne+ end

doLoad:
	li r4, 2

end:
#ENDCODE
