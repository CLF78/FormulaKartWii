#!/bin/bash
echo Formula Kart Wii ISO Builder
echo by damysteryman, edited by CLF78, converted by pixl_xip
echo Powered by WIT by Wiimm
read _ 

echo
echo Checking resources...

if [ ! -e "fkw" ]; then
	echo
	echo Cannot find the fkw folder.
	echo
	echo Please make sure you have it in the same directory
	echo as this script. Exiting...
	echo
	read _ 
	exit
fi

if [ ! -e mkw.d ]; then
	echo
	echo Unpacking the original game...
	wit extract -s ../ -1 -n RMC.01 . mkw.d --psel=DATA -ovv
fi

echo
GAMEID=NONE
LETTER=NONE
if [ -e mkw.d/files/Scene/UI/Race_E.szs ]; then
	GAMEID=RMCP01
	LETTER=P
	echo Detected version: PAL
fi
if [ -e mkw.d/files/Scene/UI/Race_U.szs ]; then
	GAMEID=RMCE01
	LETTER=E
	echo Detected version: NTSC-U
fi
if [ -e mkw.d/files/Scene/UI/Race_J.szs ]; then
	GAMEID=RMCJ01
	LETTER=J
	echo Detected version: NTSC-J
fi
if [ -e mkw.d/files/Scene/UI/Race_K.szs ]; then
	GAMEID=RMCK01
	LETTER=K
	echo Detected version: NTSC-K
fi

if [ ! -e mkw.d ]; then
	echo Cannot find a valid Mario Kart Wii ISO/WBFS file.
	echo
	echo Please make sure you have one in the same directory
	echo as this script. Exiting...
	read a
	exit
fi

echo
echo The script will now pause to let you replace any file on the disc.
echo If you want to install the Feather Cut Indicators, do it now by replacing the .szs files of the tracks.
echo DO NOT patch this game with the Wiimmfi patcher, or "it'll" break the game.
echo Press any button to resume the procedure.
read a

echo
echo Copying mod files...

mkdir -p mkw.d/files/fkw
mkdir -p mkw.d/files/Race/Course/Patches
cp fkw/code/FormulaKartWii$LETTER.bin mkw.d/files/fkw
cp fkw/tracks/*.kmp mkw.d/files/Race/Course/Patches
cp fkw/Patch.szs mkw.d/files/Scene/UI
cp fkw/drift_select.thp mkw.d/files/thp/button

if [ $LETTER = P ]; then
	cp fkw/Patch_E.szs mkw.d/files/Scene/UI
	cp fkw/Patch_F.szs mkw.d/files/Scene/UI
	cp fkw/Patch_G.szs mkw.d/files/Scene/UI
	cp fkw/Patch_I.szs mkw.d/files/Scene/UI
	cp fkw/Patch_S.szs mkw.d/files/Scene/UI
	cp fkw/Common_E.szs mkw.d/files/Race
	cp fkw/Common_F.szs mkw.d/files/Race
	cp fkw/Common_G.szs mkw.d/files/Race
	cp fkw/Common_I.szs mkw.d/files/Race
	cp fkw/Common_S.szs mkw.d/files/Race
fi

if [ $LETTER = E ]; then
	cp fkw/Patch_M.szs mkw.d/files/Scene/UI
	cp fkw/Patch_Q.szs mkw.d/files/Scene/UI
	cp fkw/Patch_U.szs mkw.d/files/Scene/UI
	cp fkw/Common_S.szs mkw.d/files/Race/Common_M.szs
	cp fkw/Common_F.szs mkw.d/files/Race/Common_Q.szs
	cp fkw/Common_E.szs mkw.d/files/Race/Common_U.szs
fi

if [ $LETTER = J ]; then
	cp fkw/Patch_J.szs mkw.d/files/Scene/UI
	cp fkw/Common_J.szs mkw.d/files/Race
fi

if [ $LETTER = K ]; then
	cp fkw/Patch_K.szs mkw.d/files/Scene/UI
	cp fkw/Common_K.szs mkw.d/files/Race/
fi

clear
echo "[01/17] Enable Faster Menu Navigation? (0=No, 1=Yes) ~ "
read FASTMENU
wit dolpatch mkw.d/sys/main.dol 800017B0=$FASTMENU -q

clear
echo "[02/17] Enable Mii Heads on Minimap? (0=No, 1=Yes) ~ "
read MIIHEADS
wit dolpatch mkw.d/sys/main.dol 800017B1=$MIIHEADS -q

clear
echo "[03/17] Disable Music? (0=No, 1=Yes) ~ "
read NOMUS
wit dolpatch mkw.d/sys/main.dol 800017B2=$NOMUS -q

clear
echo "[04/17] Disable Character Voices? (0=No, 1=Yes) ~ "
read NOCHARS
wit dolpatch mkw.d/sys/main.dol 800017B3=$NOCHARS -q

clear
echo "[05/17] Enable Long Distance Names? (0=No, 1=Yes) ~ "
read BTGLITCH
wit dolpatch mkw.d/sys/main.dol 800017B4=$BTGLITCH -q

clear
echo "[06/17] Time Difference?"
echo "0. Disabled"
echo "1. Difference to player ahead"
echo "2. Difference to player in first"
echo "~ "
read TIMEDIFF
wit dolpatch mkw.d/sys/main.dol 800017B5=$TIMEDIFF -q

clear
echo "[07/17] Enable Speedometer? (0=No, 1=Yes) ~ "
read SPEEDO
wit dolpatch mkw.d/sys/main.dol 800017B6=$SPEEDO -q

clear
echo "[08/17] Race Music?"
echo "0. Disabled"
echo "1. Normal"
echo "2. Accelerating"
echo "~ "
read FASTMUSIC
wit dolpatch mkw.d/sys/main.dol 800017B7=$FASTMUSIC -q

clear
echo "[09/17] Bikes' Drift Type?"
echo "0. Original"
echo "1. All Inside Drift"
echo "2. All Outside Drift"
echo "~ "
read BIKEDRIFT
wit dolpatch mkw.d/sys/main.dol 800017B8=$BIKEDRIFT -q

clear
echo "[10/17] Enable Inside Drifting Karts? (0=No, 1=Yes) ~ "
read KARTDRIFT
wit dolpatch mkw.d/sys/main.dol 800017B9=$KARTDRIFT -q

clear
echo "[11/17] Show Key Checkpoints on Minimap? (0=No, 1=Yes) ~ "
read KCPMAP
wit dolpatch mkw.d/sys/main.dol 800017BA=$KCPMAP -q

clear
echo "[12/17] Enable Lightning Flash? (0=No, 1=Yes) ~ "
read LGHTFLSH
wit dolpatch mkw.d/sys/main.dol 800017BB=$LGHTFLSH -q

clear
echo "[13/17] Enable Bloom and Depth of Field? (0=No, 1=Yes) ~ "
read BLMDOF
wit dolpatch mkw.d/sys/main.dol 800017BC=$BLMDOF -q

clear
echo "[14/17] Field of View?"
echo "0. Original"
echo "1. Narrow"
echo "2. Very Narrow"
echo "3. Wide"
echo "4. Very Wide"
echo "~ "
read FOV
wit dolpatch mkw.d/sys/main.dol 800017BD=$FOV -q

clear
echo "[15/17] Enable Feather Cut Indicators? [Addon must be installed manually] (0=No, 1=Yes) ~ "
read FCIS
wit dolpatch mkw.d/sys/main.dol 800017BE=$FCIS -q

clear
echo "[16/17] Force 30 FPS? (0=No, 1=Yes) ~ "
read FRAMERATE
wit dolpatch mkw.d/sys/main.dol 800017BF=$FRAMERATE -q

clear
SET "[17/17] Force Low-Angled Camera? (0=No, 1=Yes) ~ "
read LOWCAM
wit dolpatch mkw.d/sys/main.dol 800017C0=$LOWCAM -q

wit dolpatch mkw.d/sys/main.dol 8000629C=4BFFDF60 load=80004010,fkw/Loader.bin -q

clear
echo "Format Selection:"
echo "1. WBFS"
echo "2. ISO"
echo "3. Extracted Filesystem (ADVANCED USERS ONLY)"
echo "Enter the number corresponding to the format you want:"
read EXTINPUT

FILEEXT=NONE
if [ $EXTINPUT = 1 ]; then
	FILEEXT=wbfs
fi
if [ $EXTINPUT = 2 ]; then
	FILEEXT=iso
fi
if [ $EXTINPUT = 3 ]; then
  echo All done"^!"
  read a
  exit
fi
if [ $FILEEXT = NONE ]; then
	echo
	echo Invalid option selected.
	exit
fi

DESTPATH="Formula Kart Wii [$GAMEID].$FILEEXT"
echo
echo Rebuilding game...
wit copy mkw.d "$DESTPATH" -ovv --id=....01 --name="Formula Kart Wii"

echo
echo File saved as $DESTPATH
echo Cleaning up...
rm -r mkw.d

echo
echo "All done!"
read a
