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
echo Copying mod files...

mkdir mkw.d\files\fkw
copy /b fkw\code\FormulaKartWii%LETTER%.bin mkw.d\files\fkw >nul
copy /b fkw\tracks\*.szs mkw.d\files\Race\Course >nul
copy /b fkw\tracks\*_Dif.szs mkw.d\files\Race\Course\*_d_Dif.szs >nul

IF %LETTER%==p (
	copy /b fkw\Race_E.szs mkw.d\files\Scene\UI\Race_E.szs >nul
	copy /b fkw\Race_F.szs mkw.d\files\Scene\UI\Race_F.szs >nul
	copy /b fkw\Race_G.szs mkw.d\files\Scene\UI\Race_G.szs >nul
	copy /b fkw\Race_I.szs mkw.d\files\Scene\UI\Race_I.szs >nul
	copy /b fkw\Race_S.szs mkw.d\files\Scene\UI\Race_S.szs >nul
	copy /b fkw\Title_E.szs mkw.d\files\Scene\UI\Title_E.szs >nul
	copy /b fkw\Title_F.szs mkw.d\files\Scene\UI\Title_F.szs >nul
	copy /b fkw\Title_G.szs mkw.d\files\Scene\UI\Title_G.szs >nul
	copy /b fkw\Title_I.szs mkw.d\files\Scene\UI\Title_I.szs >nul
	copy /b fkw\Title_S.szs mkw.d\files\Scene\UI\Title_S.szs >nul
	copy /b fkw\Common_E.szs mkw.d\files\Race\Common_E.szs >nul
	copy /b fkw\Common_F.szs mkw.d\files\Race\Common_F.szs >nul
	copy /b fkw\Common_G.szs mkw.d\files\Race\Common_G.szs >nul
	copy /b fkw\Common_I.szs mkw.d\files\Race\Common_I.szs >nul
	copy /b fkw\Common_S.szs mkw.d\files\Race\Common_S.szs >nul
)

IF %LETTER%==e (
	copy /b fkw\Race_M.szs mkw.d\files\Scene\UI\Race_M.szs >nul
	copy /b fkw\Race_Q.szs mkw.d\files\Scene\UI\Race_Q.szs >nul
	copy /b fkw\Race_U.szs mkw.d\files\Scene\UI\Race_U.szs >nul
	copy /b fkw\Title_M.szs mkw.d\files\Scene\UI\Title_M.szs >nul
	copy /b fkw\Title_Q.szs mkw.d\files\Scene\UI\Title_Q.szs >nul
	copy /b fkw\Title_U.szs mkw.d\files\Scene\UI\Title_U.szs >nul
	copy /b fkw\Common_S.szs mkw.d\files\Race\Common_M.szs >nul
	copy /b fkw\Common_F.szs mkw.d\files\Race\Common_Q.szs >nul
	copy /b fkw\Common_E.szs mkw.d\files\Race\Common_U.szs >nul
)

IF %LETTER%==j (
	copy /b fkw\Race_J.szs mkw.d\files\Scene\UI\Race_J.szs >nul
	copy /b fkw\Title_J.szs mkw.d\files\Scene\UI\Title_J.szs >nul
	copy /b fkw\Common_J.szs mkw.d\files\Race\Common_J.szs >nul
)

IF %LETTER%==k (
	copy /b fkw\Race_K.szs mkw.d\files\Scene\UI\Race_K.szs >nul
	copy /b fkw\Title_K.szs mkw.d\files\Scene\UI\Title_K.szs >nul
	copy /b fkw\Common_J.szs mkw.d\files\Race\Common_J.szs >nul
)

echo.
SET /P FASTMENU=Enable Faster Menu Navigation? (Y/N):
IF /i %FASTMENU%==Y wit\wit.exe dolpatch mkw.d/sys/main.dol 80004000=01 -q

echo.
SET /P MIIHEADS=Enable Mii Heads on Minimap? (Y/N):
IF /i %MIIHEADS%==Y wit\wit.exe dolpatch mkw.d/sys/main.dol 80004001=01 -q

echo.
SET /P NOMUS=Disable Music? (Y/N):
IF /i %NOMUS%==Y wit\wit.exe dolpatch mkw.d/sys/main.dol 80004002=01 -q

echo.
SET /P NOCHARS=Disable Character Voices? (Y/N):
IF /i %NOCHARS%==Y wit\wit.exe dolpatch mkw.d/sys/main.dol 80004003=01 -q

echo.
SET /P BTGLITCH=Force Battle Glitch? (Y/N):
IF /i %BTGLITCH%==Y wit\wit.exe dolpatch mkw.d/sys/main.dol 80004004=01 -q

echo.
echo Enable Time Difference?:
echo 0. No
echo 1. Yes (distance to player in front)
echo 2. Yes (distance to player in 1st)
SET /P TIMEDIFF=Enter the number corresponding to the option you want:

if %TIMEDIFF% leq 2 set TD=1
if %TIMEDIFF% geq 1 set TD=1
IF %TD%==1 wit\wit.exe dolpatch mkw.d/sys/main.dol 80004005=%TIMEDIFF% -q

echo.
SET /P SPEEDO=Enable Speedometer? (Y/N):
IF /i %SPEEDO%==Y wit\wit.exe dolpatch mkw.d/sys/main.dol 80004006=01 -q

echo.
SET /P FRAMERATE=Force 30 FPS? (Y/N):
IF /i %FRAMERATE%==Y wit\wit.exe dolpatch mkw.d/sys/main.dol 8000400F=01 -q

wit\wit.exe dolpatch mkw.d/sys/main.dol 8000629C=4BFFDE1C load=80004010,fkw/Loader%LETTER%.bin -q

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