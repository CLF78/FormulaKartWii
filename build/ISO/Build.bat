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

:::::::::::::::::::::::::::
:: Core Features Options ::
:::::::::::::::::::::::::::

CLS
echo [1/4] FKW - Core Features
echo [1/3] Feather Cut Indicators?
echo 0. No
echo 1. Yes
SET /P FCIS="> "

CLS
echo [1/4] FKW - Core Features
echo [2/3] Drift Orientation for Bikes?
echo 0. Original
echo 1. Inside Drift
echo 2. Outside Drift
SET /P DRIFTBIKES="> "

CLS
echo [1/4] FKW - Core Features
echo [3/3] Drift Orientation for Karts?
echo 0. Original
echo 1. Inside Drift
SET /P DRIFTKARTS="> "

:::::::::::::::::::::::::::
:: Newbie Helper Options ::
:::::::::::::::::::::::::::

CLS
echo [2/4] FKW - Newbie Helper
echo [1/6] Better Item Pool?
echo 0. No
echo 1. Yes
SET /P BETTERITEMS="> "

:ItemSel
CLS
echo [2/4] FKW - Newbie Helper
echo [2/6] Green Shell Replacement Item?
echo 0. No
echo 1. Red Shell
echo 2. Banana
echo 3. Fake Item Box
echo 6. Bob-omb
echo 7. Blue Shell
echo C. Golden Mushroom
echo D. S"tar
SET /P GREENREPLACE="> "
if "%GREENREPLACE%"=="0" goto AfterItemSel
if "%GREENREPLACE%"=="1" goto AfterItemSel
if "%GREENREPLACE%"=="2" goto AfterItemSel
if "%GREENREPLACE%"=="3" goto AfterItemSel
if "%GREENREPLACE%"=="6" goto AfterItemSel
if "%GREENREPLACE%"=="7" goto AfterItemSel
if "%GREENREPLACE%"=="C" goto AfterItemSel
if "%GREENREPLACE%"=="D" goto AfterItemSel
goto ItemSel

:AfterItemSel
CLS
echo [2/4] FKW - Newbie Helper
echo [3/6] Bullet Bill Thunderclouds?
echo 0. No
echo 1. Yes
SET /P BILLTCS="> "

CLS
echo [2/4] FKW - Newbie Helper
echo [4/6] Instant Respawn?
echo 0. No
echo 1. Yes
SET /P INSTARESPAWN="> "

CLS
echo [2/4] FKW - Newbie Helper
echo [5/6] Holdable Respawn Boost?
echo 0. No
echo 1. Yes
SET /P HOLDBOOST="> "

CLS
echo [2/4] FKW - Newbie Helper
echo [6/6] Instant Slipstream?
echo 0. No
echo 1. Yes
SET /P INSTADRAFT="> "

::::::::::::::::::::
:: Video Settings ::
::::::::::::::::::::

CLS
echo [3/4] FKW - Video Settings
echo [1/11] Force 30FPS?
echo 0. No
echo 1. Yes
SET /P THIRTYFPS="> "

CLS
echo [3/4] FKW - Video Settings
echo [2/11] Faster Menu Navigation?
echo 0. No
echo 1. Yes
SET /P FASTMENU="> "

CLS
echo [3/4] FKW - Video Settings
echo [3/11] Speedometer?
echo 0. No
echo 1. Yes
SET /P SPEEDOMETER="> "

CLS
echo [3/4] FKW - Video Settings
echo [4/11] Minimap: Key Checkpoints?
echo 0. No
echo 1. Yes
SET /P MINIMAPKCPS="> "

CLS
echo [3/4] FKW - Video Settings
echo [5/11] Minimap: Mii Heads?
echo 0. No
echo 1. Yes
SET /P MINIMAPMII="> "

CLS
echo [3/4] FKW - Video Settings
echo [6/11] Nametags Distance?
echo 0. Never
echo 1. Normal
echo 2. Near
echo 3. Far
echo 4. Always
SET /P TAGSDIST="> "

CLS
echo [3/4] FKW - Video Settings
echo [7/11] Time Difference?
echo 0. No
echo 1. To Player Ahead
echo 2. To Player in First Place
SET /P TIMEDIFF="> "

CLS
echo [3/4] FKW - Video Settings
echo [8/11] Bloom and Depth of Field?
echo 0. No
echo 1. Yes
SET /P BLOOM="> "

CLS
echo [3/4] FKW - Video Settings
echo [9/11] Lightning Flash?
echo 0. No
echo 1. Yes
SET /P LIGHTFLASH="> "

CLS
echo [3/4] FKW - Video Settings
echo [10/11] Field of View?
echo 0. Original
echo 1. Narrow
echo 2. Very Narrow
echo 3. Wide
echo 4. Very Wide
SET /P FOV="> "

CLS
echo [3/4] FKW - Video Settings
echo [11/11] Low-angled Camera?
echo 0. No
echo 1. Yes
SET /P LOWCAM="> "

::::::::::::::::::::
:: Audio Settings ::
::::::::::::::::::::

CLS
echo [4/4] FKW - Audio Settings
echo [1/5] Character Voices?
echo 0. No
echo 1. Yes
SET /P CHARVOICES="> "

CLS
echo [4/4] FKW - Audio Settings
echo [2/5] Music: Race
echo 0. Off
echo 1. Normal
echo 2. Accelerating
SET /P MUSICRACE="> "

CLS
echo [4/4] FKW - Audio Settings
echo [3/5] Music: Transformation
echo 0. Off
echo 1. Normal
echo 2. Overlayed
SET /P MUSICTRANS="> "

CLS
echo [4/4] FKW - Audio Settings
echo [4/5] Music: Distortion
echo 0. No
echo 1. Yes
SET /P MUSICDIST="> "

CLS
echo [4/4] FKW - Audio Settings
echo [5/5] Automatic BRSAR Patching?
echo 0. No
echo 1. Yes
SET /P AUTOBRSAR="> "

:: FKW - Core Features
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004030=%FCIS% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004031=%DRIFTBIKES% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004032=%DRIFTKARTS% -q

:: FKW - Newbie Helper
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004040=%BETTERITEMS% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004041=%GREENREPLACE% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004042=%BILLTCS% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004043=%INSTARESPAWN% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004044=%HOLDBOOST% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004045=%INSTADRAFT% -q

:: FKW - Video Settings
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004050=%THIRTYFPS% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004051=%FASTMENU% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004052=%SPEEDOMETER% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004053=%MINIMAPKCPS% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004054=%MINIMAPMII% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004055=%TAGSDIST% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004056=%TIMEDIFF% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004057=%BLOOM% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004058=%LIGHTFLASH% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004059=%FOV% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 8000405A=%LOWCAM% -q

:: FKW - Audio Settings
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004060=%CHARVOICES% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004061=%MUSICRACE% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004062=%MUSICTRANS% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004063=%MUSICDIST% -q
wit\wit.exe dolpatch mkw.d/sys/main.dol 80004064=%AUTOBRSAR% -q

:: Inject loader

wit\wit.exe dolpatch mkw.d/sys/main.dol 8000629C=4BFFDF60 load=80004010,fkw/Loader.bin -q

echo Choose in which format you want to save the game:
echo 1. WBFS
echo 2. ISO
echo 3. Extracted Filesystem (ADVANCED USERS ONLY)
SET /P EXTINPUT="> "

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
