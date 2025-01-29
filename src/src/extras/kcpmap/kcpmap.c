#include "common.h"
#include "coursemap.h"
#include "stdlib.h"

typedef struct{
    u8 unk[0x28];
    Vec3 translation;
    Vec3 rotation;
    Vec2 scale;
    float width;
    float height;
    u8 unk1[0x64];
    u8 alpha;
    u8 field23_0xb5;
    u8 originType;
    u8 flags;
    char name[17]; // Created by retype action
    char userInfo[9];
    u8 unk3[0x2];
} Pane_base;

typedef struct{
    void* vtable;
    Pane_base base;
} Pane;

typedef struct {
    Vec3 tranlate;
    Vec2 scale;
    u8 opacity;
    u8 padding[0x3];
} Element;

typedef struct{
    void* vtable;
    Element elements[4];
    u8 unk[0x134];
    Pane *pane;
    Vec3 position;
    Vec3 rotation;
} MapObject;

typedef struct{
    void* destination;
} CtrlLoader;

extern CourseMap* KMPdata;
extern void* CtrlRace2dMapObject_vt;
extern void* LayoutUIControl_construct(void* control);
extern void UIControl_insertChild(void* control, u32 index, void* child);
extern void ControlLoader_load(CtrlLoader* ControlLoader, char* dirname, char* filename, char* variantname, char** animations);
extern void CtrlRace2dMapObject_initSelf(MapObject *object);
extern f32 mkw_atan2(f32 x, f32 y);
extern char s_game_image; 
extern char s_map_start_line;
extern char s_start_line; 

u32 GetNKCPs() {
    u32 count;
    for(u32 i = 0; i < KMPdata->mpCheckPoint->count; i++){
        if(KMPdata->mpCheckPoint->entries[i]->mpData->type != 0xff){
            count++;
        }
    }
    return count;
}

f32 sqrt_ap(f32 a){
    f32 ig = a;
    for (int i = 0; i < 10; i++) {
        ig = 0.5 * (ig + a / ig);
    }
    return ig; 
}

u32 InsertKCPs(void* MapCtrl, u32 prevChildIndex, CtrlLoader* ctrlLoader){
    for(u32 i = 0; i < KMPdata->mpCheckPoint->count; i++){
        MapdataCheckPoint* checkpoint = KMPdata->mpCheckPoint->entries[i];
        if(checkpoint->mpData->type != 0xff){
            prevChildIndex++;

            MapObject* kcp = new(0x1b4,0x4);
            LayoutUIControl_construct(kcp);
            kcp->vtable = &CtrlRace2dMapObject_vt;

            UIControl_insertChild(MapCtrl, prevChildIndex, kcp);

            ctrlLoader->destination = kcp;
            ControlLoader_load(ctrlLoader, &s_game_image, &s_map_start_line, &s_start_line, 0); 

            kcp->position.x = checkpoint->mMidpoint.x; 
            kcp->position.z = checkpoint->mMidpoint.y; //accept the way of life

            kcp->rotation.y = mkw_atan2(checkpoint->mDir.x, checkpoint->mDir.y) * 57.2958;

            CtrlRace2dMapObject_initSelf(kcp); //normally it does this automatically later but I have to do it now if I want to modify the scale

            kcp->pane->base.width = fsqrt((checkpoint->mpData->p0.x - checkpoint->mpData->p1.x)*(checkpoint->mpData->p0.x - checkpoint->mpData->p1.x) + (checkpoint->mpData->p0.y - checkpoint->mpData->p1.y)*(checkpoint->mpData->p0.y - checkpoint->mpData->p1.y)) / 4000;

        }
    }
    return prevChildIndex;
}