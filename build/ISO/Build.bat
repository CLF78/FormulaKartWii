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
	exit
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
exit

:COPY
echo.
echo The script will now pause to let you replace any file on the disc.
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

echo.
SET /P FASTMENU=Enable Faster Menu Navigation? (Y/N):
IF /i %FASTMENU%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004000=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004000=00 -q)

echo.
SET /P MIIHEADS=Enable Mii Heads on Minimap? (Y/N):
IF /i %MIIHEADS%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004001=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004001=00 -q)

echo.
SET /P NOMUS=Disable Music? (Y/N):
IF /i %NOMUS%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004002=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004002=00 -q)

echo.
SET /P NOCHARS=Disable Character Voices? (Y/N):
IF /i %NOCHARS%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004003=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004003=00 -q)

echo.
SET /P BTGLITCH=Long Distance Names? (Y/N):
IF /i %BTGLITCH%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004004=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004004=00 -q)

echo.
echo Enable Time Difference?:
echo 0. No
echo 1. Yes (distance to player ahead)
echo 2. Yes (distance to player in 1st)
SET /P TIMEDIFF=Enter the number corresponding to the option you want:

if %TIMEDIFF% leq 2 set TD=1
if %TIMEDIFF% lss 1 set TD=0
IF %TD%==1 (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004005=%TIMEDIFF% -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004005=00 -q)

echo.
SET /P SPEEDO=Enable Speedometer? (Y/N):
IF /i %SPEEDO%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004006=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004006=00 -q)

echo.
SET /P FASTMUSIC=Enable Gradually Faster Music? (Y/N):
IF /i %FASTMUSIC%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004007=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004007=00 -q)

echo.
echo Bikes' Drift Type?:
echo 0. Original
echo 1. All Inside Drift
echo 2. All Outside Drift
SET /P BIKEDRIFT=Enter the number corresponding to the option you want:

if %BIKEDRIFT% leq 2 set BD=1
if %BIKEDRIFT% lss 1 set BD=0
IF %BD%==1 (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004008=%BIKEDRIFT% -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004008=00 -q)

echo.
SET /P KARTDRIFT=Enable Inside Drifting Karts? (Y/N):
IF /i %KARTDRIFT%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004009=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 80004009=00 -q)

echo.
SET /P KCPMAP=Show KCPs on Minimap? (Y/N):
IF /i %KCPMAP%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 8000400A=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 8000400A=00 -q)

echo.
SET /P FCIS=Enable Feather Cut Indicators? [Addon must be installed manually] (Y/N):
IF /i %FCIS%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 8000400E=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 8000400E=00 -q)

echo.
SET /P FRAMERATE=Force 30 FPS? (Y/N):
IF /i %FRAMERATE%==Y (wit\wit.exe dolpatch mkw.d/sys/main.dol 8000400F=01 -q) ELSE (wit\wit.exe dolpatch mkw.d/sys/main.dol 8000400F=00 -q)

wit\wit.exe dolpatch mkw.d/sys/main.dol 8000629C=4BFFDF60 load=80004010,fkw/Loader.bin -q

echo.
echo Format Selection:
echo 1. WBFS
echo 2. ISO
echo 3. Extracted Filesystem (ADVANCED USERS ONLY)
SET /P EXTINPUT=Enter the number corresponding to the format you want:

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
echo All done"^!"
pause
