@echo off
Setlocal EnableDelayedExpansion

cls
echo Formula Kart Wii ISO Builder
echo by damysteryman, edited by CLF78
echo Powered by WIT by Wiimm
pause

echo.
echo Checking resources...

IF NOT EXIST "fkw" (
	echo.
	echo Cannot find the fkw folder.
	echo.
	echo Please make sure you have it in the same directory
	echo as this script. Exiting...
	echo.
	pause
	EXIT
	)

IF EXIST mkw.d (
	GOTO CHECK
	)

echo.
echo Unpacking the original game...
wit\wit.exe extract -s ../ -1 -n RMC.01 . mkw.d --psel=DATA -ovv

:CHECK
echo.
IF EXIST mkw.d\files\Scene\UI\Race_E.szs (
	SET GAMEID=RMCP01
	SET LETTER=P
	echo Detected version: PAL
	GOTO COPY
	)
IF EXIST mkw.d\files\Scene\UI\Race_U.szs (
	SET GAMEID=RMCE01
	SET LETTER=E
	echo Detected version: NTSC-U
	GOTO COPY
	)
IF EXIST mkw.d\files\Scene\UI\Race_J.szs (
	SET GAMEID=RMCJ01
	SET LETTER=J
	echo Detected version: NTSC-J
	GOTO COPY
	)
IF EXIST mkw.d\files\Scene\UI\Race_K.szs (
	SET GAMEID=RMCK01
	SET LETTER=K
	echo Detected version: NTSC-K
	GOTO COPY
	)

echo Cannot find a valid Mario Kart Wii ISO/WBFS file.
echo.
echo Please make sure you have one in the same directory
echo as this script. Exiting...
pause
EXIT

:COPY
echo.
echo The script will now pause to let you replace any file on the disc.
echo If you want to install the Feather Cut Indicators, do it now by replacing the .szs files of the tracks.
echo DO NOT patch this game with the Wiimmfi patcher, or it'll break the game.
echo Press any button to resume the procedure.
pause

echo.
echo Copying mod files...

mkdir mkw.d\files\fkw
mkdir mkw.d\files\Race\Course\Patches
copy /y fkw\code\FormulaKartWii%LETTER%.bin mkw.d\files\fkw >nul
copy /y fkw\tracks\*.kmp mkw.d\files\Race\Course\Patches >nul
copy /y fkw\Patch.szs mkw.d\files\Scene\UI >nul
copy /y fkw\drift_select.thp mkw.d\files\thp\button >nul

IF %LETTER%==P (
	copy /y fkw\Patch_E.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Patch_F.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Patch_G.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Patch_I.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Patch_S.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Common_E.szs mkw.d\files\Race >nul
	copy /y fkw\Common_F.szs mkw.d\files\Race >nul
	copy /y fkw\Common_G.szs mkw.d\files\Race >nul
	copy /y fkw\Common_I.szs mkw.d\files\Race >nul
	copy /y fkw\Common_S.szs mkw.d\files\Race >nul
)

IF %LETTER%==E (
	copy /y fkw\Patch_M.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Patch_Q.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Patch_U.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Common_S.szs mkw.d\files\Race\Common_M.szs >nul
	copy /y fkw\Common_F.szs mkw.d\files\Race\Common_Q.szs >nul
	copy /y fkw\Common_E.szs mkw.d\files\Race\Common_U.szs >nul
)

IF %LETTER%==J (
	copy /y fkw\Patch_J.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Common_J.szs mkw.d\files\Race >nul
)

IF %LETTER%==K (
	copy /y fkw\Patch_K.szs mkw.d\files\Scene\UI >nul
	copy /y fkw\Common_K.szs mkw.d\files\Race\ >nul
)

CLS
SET /P FASTMENU=[01/17] Enable Faster Menu Navigation? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B0=%FASTMENU% -q

CLS
SET /P MIIHEADS=[02/17] Enable Mii Heads on Minimap? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B1=%MIIHEADS% -q

CLS
SET /P NOMUS=[03/17] Enable Music? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B2=%NOMUS% -q

CLS
SET /P NOCHARS=[04/17] Enable Character Voices? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B3=%NOCHARS% -q

CLS
SET /P BTGLITCH=[05/17] Enable Long Distance Names? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B4=%BTGLITCH% -q

CLS
echo [06/17] Time Difference?
echo 0. Disabled
echo 1. Difference to player ahead
echo 2. Difference to player in first
SET /P TIMEDIFF=~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B5=%TIMEDIFF% -q

CLS
SET /P SPEEDO=[07/17] Enable Speedometer? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B6=%SPEEDO% -q

CLS
echo [08/17] Race Music?
echo 0. Disabled
echo 1. Normal
echo 2. Accelerating
SET /P FASTMUSIC=~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B7=%FASTMUSIC% -q

CLS
echo [09/17] Bikes' Drift Type?
echo 0. Original
echo 1. All Inside Drift
echo 2. All Outside Drift
SET /P BIKEDRIFT=~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B8=%BIKEDRIFT% -q

CLS
SET /P KARTDRIFT=[10/17] Enable Inside Drifting Karts? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017B9=%KARTDRIFT% -q

CLS
SET /P KCPMAP=[11/17] Show Key Checkpoints on Minimap? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017BA=%KCPMAP% -q

CLS
SET /P LGHTFLSH=[12/17] Enable Lightning Flash? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017BB=%LGHTFLSH% -q

CLS
SET /P BLMDOF=[13/17] Enable Bloom and Depth of Field? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017BC=%BLMDOF% -q

CLS
echo [14/17] Field of View?
echo 0. Original
echo 1. Narrow
echo 2. Very Narrow
echo 3. Wide
echo 4. Very Wide
SET /P FOV=~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017BD=%FOV% -q

CLS
SET /P FCIS=[15/17] Enable Feather Cut Indicators? [Addon must be installed separately] (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017BE=%FCIS% -q

CLS
SET /P FRAMERATE=[16/17] Force 30 FPS? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017BF=%FRAMERATE% -q

CLS
SET /P LOWCAM=[17/17] Force Low-Angled Camera? (0=No, 1=Yes) ~ 
wit\wit.exe dolpatch mkw.d/sys/main.dol 800017C0=%LOWCAM% -q

wit\wit.exe dolpatch mkw.d/sys/main.dol 8000629C=4BFFDF60 load=80004010,fkw/Loader.bin -q

CLS
echo Format Selection:
echo 1. WBFS
echo 2. ISO
echo 3. Extracted Filesystem (ADVANCED USERS ONLY)
SET /P EXTINPUT=Enter the number corresponding to the format you want ~ 

IF %EXTINPUT%==1 (
	SET FILEEXT=wbfs
	GOTO BUILD
	)
IF %EXTINPUT%==2 (
	SET FILEEXT=iso
	GOTO BUILD
	)
IF %EXTINPUT%==3 (
	GOTO END
	)

echo.
echo Invalid option selected.
GOTO FORMSEL

:BUILD
SET DESTPATH=Formula Kart Wii [%GAMEID%].%FILEEXT%
echo.
echo Rebuilding game...
wit\wit.exe copy mkw.d "%DESTPATH%" -ovv --id=....01 --name="Formula Kart Wii"

echo.
echo File saved as %DESTPATH%
echo Cleaning up...
rmdir mkw.d /s /q
GOTO END

:END
echo.
echo All done^!
pause
