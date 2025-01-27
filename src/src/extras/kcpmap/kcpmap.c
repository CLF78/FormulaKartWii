#include "common.h"
#include "coursemap.h"
#include "stdlib.h"

typedef struct{
    void* vtable;
    u8 unk[0x198];
    f32 x;
    u8 unk1[0x4];
    f32 y;
    u8 unk2[0x4];
    f32 rotation;
} MapObject;

typedef struct{
    void* destination;
} CtrlLoader;

extern CourseMap* KMPdata;
extern void* CtrlRace2dMapObject_vt;
extern void* LayoutUIControl_construct(void* control);
extern void UIControl_insertChild(void* control, u32 index, void* child);
extern void ControlLoader_load(CtrlLoader* ControlLoader, char* dirname, char* filename, char* variantname, char** animations);
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

            kcp->x = checkpoint->mMidpoint.x;
            kcp->y = checkpoint->mMidpoint.y;

            kcp->rotation = mkw_atan2(checkpoint->mDir.x, checkpoint->mDir.y) * 57.2958;
        }
    }
    return prevChildIndex;
}