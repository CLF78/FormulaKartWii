#pragma once

#include "common.h"

typedef struct {
    Vec2 p0; 
    Vec2 p1; 
    u8 jgptId; 
    u8 type;
    u8 prev; // Previous checkpoint in this group's sequence; 0xFF for the first point of the group. 
    u8 next; // Next checkpoint in this group's sequence; 0xFF for the first point of the group. 
} CKPT;

typedef struct {
    CKPT *mpData;
    u16 mNextCount;
    u16 mPrevCount;
    Vec2 mMidpoint;
    Vec2 mDir;
    u16 mFlags; // Information stored by recursive functions (e.g. indicate that a checkpoint has been visited to prevent infinite recursion)
    u16 mId;
    u16 prevKcpId; // Index of previous key checkpoint. If this checkpoint is key, it is its own id==prevKcpId
    u8 unk[0x3 + 0x18 + 0x90];
} MapdataCheckPoint;

typedef struct {
    MapdataCheckPoint **entries;
    u16 count;
    u8 unk[0x2];
    void *raw;
    s8 lastKcpType; // checkpoint type of final key checkpoint along a lap
    u8 unk1[0x1];
    u16 finishLineCheckpointId;
    f32 meanTotalDistance; // Created by retype action
} MapdataCheckPointAccessor;

typedef struct {
    void *__vt;
    struct MapdataFileAccessor *mpCourse;
    struct MapdataStartPointAccessor *mpStartPoint;
    struct MapdataEnemyPathAccessor *mpEnemyPath;
    struct MapdataEnemyPointAccessor *mpEnemyPoint;
    struct MapdataItemPathAccessor *mpItemPath;
    struct MapdataItemPointAccessor *mpItemPoint;
    struct MapdataCheckPathAccessor *mpCheckPath;
    MapdataCheckPointAccessor *mpCheckPoint;
    struct MapdataPointInfoAccessor *mpPointInfo;
    struct MapdataGeoObjAccessor *mpGeoObj;
    struct MapdataAreaAccessor *mpArea;
    struct MapdataCameraAccessor *mpCamera;
    struct MapdataJugemPointAccessor *mpJugemPoint;
    struct MapdataCannonPointAccessor *mpCannonPoint;
    struct MapdataStageInfoAccessor *mpStageInfo;
    struct MapdataMissionPointAccessor *mpMissionPoint;
    struct MapdataCamera *goalCamera;
    struct MapdataCamera *field18_0x48;
    struct MapdataCamera *field19_0x4c;
    u32 _50; // unused
} CourseMap;