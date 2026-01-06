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

#########################
# Core Features Options #
#########################

clear
echo [1/4] FKW - Core Features
echo [1/3] Feather Cut Indicators?
echo 0. No
echo 1. Yes
echo -n " > "
read FCIS

clear
echo [1/4] FKW - Core Features
echo [2/3] Drift Orientation for Bikes?
echo 0. Original
echo 1. Inside Drift
echo 2. Outside Drift
echo -n " > "
read DRIFTBIKES

clear
echo [1/4] FKW - Core Features
echo [3/3] Drift Orientation for Karts?
echo 0. Original
echo 1. Inside Drift
echo -n " > "
read DRIFTKARTS

#########################
# Newbie Helper Options #
#########################

clear
echo [2/4] FKW - Newbie Helper
echo [1/6] Better Item Pool?
echo 0. No
echo 1. Yes
echo -n " > "
read BETTERITEMS

# Missing input validation
clear
echo [2/4] FKW - Newbie Helper
echo [2/6] Green Shell Replacement Item?
echo 0. No
echo 1. Red Shell
echo 2. Banana
echo 3. Fake Item Box
echo 6. Bob-omb
echo 7. Blue Shell
echo C. Golden Mushroom
echo D. Star
echo -n " > "
read GREENREPLACE

clear
echo [2/4] FKW - Newbie Helper
echo [3/6] Bullet Bill Thunderclouds?
echo 0. No
echo 1. Yes
echo -n " > "
read BILLTCS

clear
echo [2/4] FKW - Newbie Helper
echo [4/6] Instant Respawn?
echo 0. No
echo 1. Yes
echo -n " > "
read INSTARESPAWN

clear
echo [2/4] FKW - Newbie Helper
echo [5/6] Automatic Respawn Boost?
echo 0. No
echo 1. Yes
echo -n " > "
read AUTOBOOST

clear
echo [2/4] FKW - Newbie Helper
echo [6/6] Instant Slipstream?
echo 0. No
echo 1. Yes
echo -n " > "
read INSTADRAFT

##################
# Video Settings #
##################

clear
echo [3/4] FKW - Video Settings
echo [1/11] Force 30FPS?
echo 0. No
echo 1. Yes
echo -n " > "
read THIRTYFPS

clear
echo [3/4] FKW - Video Settings
echo [2/11] Faster Menu Navigation?
echo 0. No
echo 1. Yes
echo -n " > "
read FASTMENU

clear
echo [3/4] FKW - Video Settings
echo [3/11] Speedometer?
echo 0. No
echo 1. Yes
echo -n " > "
read SPEEDOMETER

clear
echo [3/4] FKW - Video Settings
echo [4/11] Minimap: Key Checkpoints?
echo 0. No
echo 1. Yes
echo -n " > "
read MINIMAPKCPS

clear
echo [3/4] FKW - Video Settings
echo [5/11] Minimap: Mii Heads?
echo 0. No
echo 1. Yes
echo -n " > "
read MINIMAPMII

clear
echo [3/4] FKW - Video Settings
echo [6/11] Nametags Distance?
echo 0. Never
echo 1. Normal
echo 2. Near
echo 3. Far
echo 4. Always
echo -n " > "
read TAGSDIST

clear
echo [3/4] FKW - Video Settings
echo [7/11] Time Difference?
echo 0. No
echo 1. To Player Ahead
echo 2. To Player in First Place
echo -n " > "
read TIMEDIFF

clear
echo [3/4] FKW - Video Settings
echo [8/11] Bloom and Depth of Field?
echo 0. No
echo 1. Yes
echo -n " > "
read BLOOM

clear
echo [3/4] FKW - Video Settings
echo [9/11] Lightning Flash?
echo 0. No
echo 1. Yes
echo -n " > "
read LIGHTFLASH

clear
echo [3/4] FKW - Video Settings
echo [10/11] Field of View?
echo 0. Original
echo 1. Narrow
echo 2. Very Narrow
echo 3. Wide
echo 4. Very Wide
echo -n " > "
read FOV

clear
echo [3/4] FKW - Video Settings
echo [11/11] Low-angled Camera?
echo 0. No
echo 1. Yes
echo -n " > "
read LOWCAM

##################
# Audio Settings #
##################

clear
echo [4/4] FKW - Audio Settings
echo [1/5] Character Voices?
echo 0. No
echo 1. Yes
echo -n " > "
read CHARVOICES

clear
echo [4/4] FKW - Audio Settings
echo [2/5] Music: Race
echo 0. Off
echo 1. Normal
echo 2. Accelerating
echo -n " > "
read MUSICRACE

clear
echo [4/4] FKW - Audio Settings
echo [3/5] Music: Transformation
echo 0. Off
echo 1. Normal
echo 2. Overlayed
echo -n " > "
read MUSICTRANS

clear
echo [4/4] FKW - Audio Settings
echo [4/5] Music: Distortion
echo 0. No
echo 1. Yes
echo -n " > "
read MUSICDIST

clear
echo [4/4] FKW - Audio Settings
echo [5/5] Automatic BRSAR Patching?
echo 0. No
echo 1. Yes
echo -n " > "
read AUTOBRSAR

# FKW - Core Features
wit dolpatch mkw.d/sys/main.dol 80004030=$FCIS -q
wit dolpatch mkw.d/sys/main.dol 80004031=$DRIFTBIKES -q
wit dolpatch mkw.d/sys/main.dol 80004032=$DRIFTKARTS -q

# FKW - Newbie Helper
wit dolpatch mkw.d/sys/main.dol 80004040=$BETTERITEMS -q
wit dolpatch mkw.d/sys/main.dol 80004041=$GREENREPLACE -q
wit dolpatch mkw.d/sys/main.dol 80004042=$BILLTCS -q
wit dolpatch mkw.d/sys/main.dol 80004043=$INSTARESPAWN -q
wit dolpatch mkw.d/sys/main.dol 80004044=$AUTOBOOST -q
wit dolpatch mkw.d/sys/main.dol 80004045=$INSTADRAFT -q

# FKW - Video Settings
wit dolpatch mkw.d/sys/main.dol 80004050=$THIRTYFPS -q
wit dolpatch mkw.d/sys/main.dol 80004051=$FASTMENU -q
wit dolpatch mkw.d/sys/main.dol 80004052=$SPEEDOMETER -q
wit dolpatch mkw.d/sys/main.dol 80004053=$MINIMAPKCPS -q
wit dolpatch mkw.d/sys/main.dol 80004054=$MINIMAPMII -q
wit dolpatch mkw.d/sys/main.dol 80004055=$TAGSDIST -q
wit dolpatch mkw.d/sys/main.dol 80004056=$TIMEDIFF -q
wit dolpatch mkw.d/sys/main.dol 80004057=$BLOOM -q
wit dolpatch mkw.d/sys/main.dol 80004058=$LIGHTFLASH -q
wit dolpatch mkw.d/sys/main.dol 80004059=$FOV -q
wit dolpatch mkw.d/sys/main.dol 8000405A=$LOWCAM -q

# FKW - Audio Settings
wit dolpatch mkw.d/sys/main.dol 80004060=$CHARVOICES -q
wit dolpatch mkw.d/sys/main.dol 80004061=$MUSICRACE -q
wit dolpatch mkw.d/sys/main.dol 80004062=$MUSICTRANS -q
wit dolpatch mkw.d/sys/main.dol 80004063=$MUSICDIST -q
wit dolpatch mkw.d/sys/main.dol 80004064=$AUTOBRSAR -q

# Inject loader

wit dolpatch mkw.d/sys/main.dol 8000629C=4BFFDF60 load=80004010,fkw/Loader.bin -q

clear
echo Choose in which format you want to save the game:
echo 1. WBFS
echo 2. ISO
echo 3. Extracted Filesystem (ADVANCED USERS ONLY)
echo -n " > "
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
