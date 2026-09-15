.include "asm_setup.S"

.extern UMTEffectPointer, ArchiveRoot, new2, new_a, delete, delete_a, GetFile, EffectConstruct, PlayerEffectConstruct, EffectDrawer, EffectBind, EffectBCTRL, EGGEffectConstruct, getPlayerById, PlayerHolder, Racedata 
.global EffectCreateHook, EffectDestroyHook, EffectLoadHook, EffectBCTRLfuckoff

EffectCreateHook:
stwu r1, -0x30(r1)
mflr r0
stw r0, 0x34(r1)
stmw r25, 0x14(r1)
mr r31, r3
 lis r3, ArchiveRoot@ha
 lis r5, resourceStrings@h
 lwz r26, ArchiveRoot@l(r3)
ori r5, r5, resourceStrings@l
 li r4, 0
 li r6, 0
 mr r3, r26
 bl GetFile
 lis r5, resourceStrings@h
 mr r27, r3
 mr r3, r26
 li r4, 0
ori r5, r5, resourceStrings@l+0x18
 li r6, 0
 bl GetFile
 mr r26, r3
 li r3, 0x20
 bl new2
 cmpwi r3, 0
 beq- .loc_0x7C
 mr r4, r27
 mr r5, r26
 bl EffectConstruct

.loc_0x7C:
 lhz r0, 0x12(r31)
 cmplwi  r0, 0x9
 beq- .loc_0x98
 rlwinm  r0,r0,2,14,29
 add r4, r31, r0
 stw r3, 0x44(r4)
 b  .loc_0xA0

.loc_0x98:
 lis r4, UMTEffectPointer@ha
 stw r3, UMTEffectPointer@l(r4)

.loc_0xA0:
 lis r29, UMTEffectPointer@h
 li r25, 0
 ori r29, r29, UMTEffectPointer@l+0x24
 li r26, 0
 lis r28, PlayerHolder@ha
 lis r30, Racedata@ha
 b  .loc_0xFC

.loc_0xBC:
 li r3, 0xAEC
 bl new2
 cmpwi r3, 0
 mr r27, r3
 beq- .loc_0xEC
 lwz r3, PlayerHolder@l(r28)
 mr r4, r25
 bl getPlayerById
 mr r4, r3
 mr r3, r27
 bl PlayerEffectConstruct
 stw r29, 0x0(r27)

.loc_0xEC:
 lwz r3, 0x68(r31)
 addi r25, r25, 0x1
 stwx r27, r3, r26
 addi r26, r26, 0x4

.loc_0xFC:
 lwz r3, Racedata@l(r30)
 lbz r0, 0x24(r3)
 cmpw r25, r0
 blt+ .loc_0xBC
 lmw r25, 0x14(r1)
 lwz r0, 0x34(r1)
 mtlr r0
 addi r1, r1, 0x30
 blr 

EffectDestroyHook:
  stwu      r1, -0x10(r1)
  mflr      r0
  lis       r4, UMTEffectPointer@ha
  stw       r0, 0x14(r1)
  stw       r31, 0xC(r1)
  mr        r31, r3
  lwz       r3, UMTEffectPointer@l(r4)
  cmpwi     r3, 0
  beq-      .loc_0x38
  lwz       r12, 0x0(r3)
  li        r4, 0x1
  lwz       r12, 0x8(r12)
  mtctr     r12
  bctrl     

.loc_0x38:
  lis       r3, UMTEffectPointer@ha
  li        r0, 0
  stw       r0, UMTEffectPointer@l(r3)
  mr        r3, r31
  bl        EffectDrawer
  lwz       r0, 0x14(r1)
  lwz       r31, 0xC(r1)
  mtlr      r0
  addi      r1, r1, 0x10
  blr       

EffectLoadHook:
  stwu      r1, -0x20(r1)
  mflr      r0
  stw       r0, 0x24(r1)
  stw       r31, 0x1C(r1)
  stw       r30, 0x18(r1)
  stw       r29, 0x14(r1)
  stw       r28, 0x10(r1)
  mr        r28, r3
  bl        EffectBind
  li        r3, 0x20
  bl        new_a
  lis       r31, UMTEffectPointer@h
  stw       r3, 0xAE8(r28)
  ori      r31, r31, UMTEffectPointer@l+4
  lwz       r0, 0x124(r28)
  cmpwi     r0, 0
  beq-      purpleStrings
  addi r31, r31, 0x10C
  purpleStrings:
  li        r29, 0
  li        r30, 0

.loc_0x58:
  li        r3, 0x7C
  bl        new2
  cmpwi     r3, 0
  beq-      .loc_0x74
  lwz       r4, 0x0(r31)
  lwz       r5, 0x134(r28)
  bl        EGGEffectConstruct

.loc_0x74:
  lwz       r4, 0xAE8(r28)
  addi      r29, r29, 0x1
  cmpwi     r29, 0x8
  addi      r31, r31, 0x4
  stwx      r3, r4, r30
  addi      r30, r30, 0x4
  blt+      .loc_0x58

.loc_0x90:
  lwz       r0, 0x24(r1)
  lwz       r31, 0x1C(r1)
  lwz       r30, 0x18(r1)
  lwz       r29, 0x14(r1)
  lwz       r28, 0x10(r1)
  mtlr      r0
  addi      r1, r1, 0x20
  blr       

EffectBCTRLfuckoff:
  stwu      r1, -0x20(r1)
  mflr      r0
  cmpwi     r3, 0
  stw       r0, 0x24(r1)
  stmw      r27, 0xC(r1)
  mr        r27, r3
  mr        r28, r4
  beq-      .loc_0xA0
  lwz       r30, 0xAE8(r3)
  lis       r4, UMTEffectPointer@h
  ori      r4, r4, UMTEffectPointer@l+0x24
  stw       r4, 0x0(r3)
  cmpwi     r30, 0
  beq-      .loc_0x84
  lwz       r0, 0x124(r3)
  cmpwi     r0, 0
  bne-      .loc_0x84
  mr        r31, r30
  li        r29, 0

.loc_0x4C:
  lwz       r3, 0x0(r31)
  cmpwi     r3, 0
  beq-      .loc_0x6C
  lwz       r12, 0x0(r3)
  li        r4, 0x1
  lwz       r12, 0x8(r12)
  mtctr     r12
  bctrl     

.loc_0x6C:
  addi      r29, r29, 0x1
  addi      r31, r31, 0x4
  cmpwi     r29, 0x8
  blt+      .loc_0x4C
  mr        r3, r30
  bl        delete_a

.loc_0x84:
  mr        r3, r27
  li        r4, 0
  bl        EffectBCTRL
  cmpwi     r28, 0
  ble-      .loc_0xA0
  mr        r3, r27
  bl        delete

.loc_0xA1:
  mr        r3, r27
  lmw       r27, 0xC(r1)
  lwz       r0, 0x24(r1)
  mtlr      r0
  addi      r1, r1, 0x20
  blr       


resourceStrings:
.string "/Effect/RKForm.breff"
.align 2
.string "/Effect/RKForm.breft"
.align 2