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

echo
echo "Enable Faster Menu Navigation? (Y/N):"
read FASTMENU
if [ $FASTMENU = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004000=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004000=00 -q
fi

echo
echo "Enable Mii Heads on Minimap? (Y/N):"
read MIIHEADS
if [ $MIIHEADS = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004001=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004001=00 -q
fi

echo
echo "Disable Music? (Y/N):"
read NOMUS
if [ $NOMUS = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004002=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004002=00 -q
fi

echo
echo "Disable Character Voices? (Y/N):"
read NOCHARS
if [ $NOCHARS = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004003=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004003=00 -q
fi

echo
echo "Long Distance Names? (Y/N):"
read GTGLITC
if [ $BTGLITC = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004004=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004004=00 -q
fi

echo
echo "Enable Time Difference?:"
echo "0. No"
echo "1. Yes (distance to player ahead)"
echo "2. Yes (distance to player in 1st)"
echo "Enter the number corresponding to the option you want:"
read TIMEDIFF

TD=NONE
if [ $TIMEDIFF = 2 ]; then TD=1; fi
if [ $TIMEDIFF = 1 ]; then TD=0; fi
if [ $TD = 1 ]; then
	wit dolpatch mkw.d/sys/main.dol 80004005=$TIMEDIFF -q
else
	wit dolpatch mkw.d/sys/main.dol 80004005=00 -q
fi

echo
echo "Enable Speedometer? (Y/N):"
read SPEEDO
if [ $SPEEDO = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004006=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004006=00 -q
fi

echo
echo "Enable Gradually Faster Music? (Y/N):"
read FASTMUSIC
if [ $FASTMUSIC = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004007=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004007=00 -q
fi

echo
echo "Bikes' Drift Type?:"
echo "0. Original"
echo "1. All Inside Drift"
echo "2. All Outside Drift"
echo "Enter the number corresponding to the option you want:"
read BIKEDRIFT

BD=NONE
if [ $BIKEDRIFT = 2 ]; then BD=1; fi
if [ $BIKEDRIFT = 1 ]; then BD=0; fi
if [ $BD = 1 ]; then
	wit dolpatch mkw.d/sys/main.dol 80004008=$BIKEDRIFT -q
else
	wit dolpatch mkw.d/sys/main.dol 80004008=00 -q
fi

echo
echo "Enable Inside Drifting Karts? (Y/N):"
read KARTDRIFT
if [ $KARTDRIFT = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 80004009=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 80004009=00 -q
fi

echo
echo "Show KCPs on Minimap? (Y/N):"
read KCPMAP
if [ $KCPMAP = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 8000400A=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 8000400A=00 -q
fi

echo
echo "Enable Feather Cut Indicators? [Addon must be installed manually] (Y/N):"
read FCIS
if [ $FCIS = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 8000400E=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 8000400E=00 -q
fi

echo
echo "Force 30 FPS? (Y/N):"
read FRAMERATE
if [ $FRAMERATE = Y ]; then
	wit dolpatch mkw.d/sys/main.dol 8000400F=01 -q
else
	wit dolpatch mkw.d/sys/main.dol 8000400F=00 -q
fi

wit dolpatch mkw.d/sys/main.dol 8000629C=4BFFDF60 load=80004010,fkw/Loader.bin -q

echo
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
