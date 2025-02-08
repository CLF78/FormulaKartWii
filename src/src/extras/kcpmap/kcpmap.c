#include "common.h"
#include "coursemap.h"
#include "stdlib.h"
#include "math.h"

typedef struct{
    void* vtable;
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
} Pane;

typedef struct{
    void* vtable;
    u8 unk[0x194];
    Pane *pane;
    Vec3 position;
    Vec3 rotation;
} MapObject;

typedef struct{
    void* destination;
} CtrlLoader;

extern CourseMap* KMPdata;
extern void* CtrlRace2dMapObject_vt;
extern void* Map2DRenderer;
extern void* LayoutUIControl_construct(void* control);
extern void UIControl_insertChild(void* control, u32 index, void* child);
extern void ControlLoader_load(CtrlLoader* ControlLoader, char* dirname, char* filename, char* variantname, char** animations);
extern void CtrlRace2dMapObject_initSelf(MapObject *object);
extern void TranslateCoordinates(void* somepointer, Vec3* realpos, Vec2* mappos);
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

            kcp->position.x = checkpoint->mMidpoint.x; 
            kcp->position.z = checkpoint->mMidpoint.y; //accept the way of life

            kcp->rotation.y = rd_atan2(checkpoint->mDir.x, checkpoint->mDir.y) * 57.2958;

            CtrlRace2dMapObject_initSelf(kcp); //normally it does this automatically later but I have to do it now if I want to modify the scale

            Vec3 p0real; 
            p0real.x = checkpoint->mpData->p0.x;
            p0real.y = 0;
            p0real.z = checkpoint->mpData->p0.y;

            Vec3 p1real; 
            p1real.x = checkpoint->mpData->p1.x;
            p1real.y = 0;
            p1real.z = checkpoint->mpData->p1.y;

            Vec2 p0map;
            TranslateCoordinates(Map2DRenderer, &p0real, &p0map);
            p0map.x = 220 * (p0map.x - 0.5);
            p0map.y = 220 * (p0map.y - 0.5);

            Vec2 p1map;
            TranslateCoordinates(Map2DRenderer, &p1real, &p1map);
            p1map.x = 220 * (p1map.x - 0.5);
            p1map.y = 220 * (p1map.y - 0.5);

            float scaledlength = sqrt((p0map.x - p1map.x)*(p0map.x - p1map.x) + (p0map.y - p1map.y)*(p0map.y - p1map.y));
            kcp->pane->width = scaledlength;

        }
    }
    return prevChildIndex;
}