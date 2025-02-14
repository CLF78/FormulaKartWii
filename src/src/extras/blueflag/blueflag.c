#include "common.h"

extern void setPaneVisible(void* control, void* panename, bool);
bool NewbieHelper(u32 pid);

typedef struct
{
    u8 unk[0x178];
    u32 pid;
} ctrlRaceNameBalloon;


void BlueFlag_ToggleVisibility(ctrlRaceNameBalloon* CtrlRaceNameBalloon){
    setPaneVisible(CtrlRaceNameBalloon, "blue_flag", NewbieHelper(CtrlRaceNameBalloon->pid));
}