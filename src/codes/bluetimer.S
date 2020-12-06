.if (REGION == 'P')
    .set ItemSlotData, 0x809C3670
.elseif (REGION == 'U')
    .set ItemSlotData, 0x809BEE68
.elseif (REGION == 'J')
    .set ItemSlotData, 0x809C26D0
.elseif (REGION == 'K')
    .set ItemSlotData, 0x809B1CB0
.else
    .err
.endif

lis r3, ItemSlotData@h
ori r3, r3, ItemSlotData@l
li r4, 1500
stw r4, 0x38(r3)

#ENDCODE
