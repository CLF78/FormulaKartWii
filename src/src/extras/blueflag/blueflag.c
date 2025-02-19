#include "common.h"
#include "racedata.h"

extern void setPaneVisible(void* control, void* panename, bool);
bool NewbieHelper(u32 pid);

typedef struct
{
    u8 unk[0x178];
    u32 pid;
} ctrlRaceNameBalloon;


void BlueFlag_ToggleVisibility(ctrlRaceNameBalloon* CtrlRaceNameBalloon){
    if(MODE_6 < Racedata->main.scenarios[0].settings.gamemode && Racedata->main.scenarios[0].settings.gamemode > MODE_PUBLIC_BATTLE){return;} //return when not in an online vs race
    setPaneVisible(CtrlRaceNameBalloon, "blue_flag", NewbieHelper(CtrlRaceNameBalloon->pid));
}