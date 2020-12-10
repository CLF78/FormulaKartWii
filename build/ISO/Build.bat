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
	SET LETTER=p
	echo Detected version: PAL
	GOTO COPY
	)
IF EXIST mkw.d\files\Scene\UI\Race_U.szs (
	SET GAMEID=RMCE01
	SET LETTER=e
	echo Detected version: NTSC-U
	GOTO COPY
	)
IF EXIST mkw.d\files\Scene\UI\Race_J.szs (
	SET GAMEID=RMCJ01
	SET LETTER=j
	echo Detected version: NTSC-J
	GOTO COPY
	)
IF EXIST mkw.d\files\Scene\UI\Race_K.szs (
	SET GAMEID=RMCK01
	SET LETTER=k
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
copy /b fkw\Title.szs mkw.d\files\Scene\UI\Title.szs >nul
copy /b fkw\main%LETTER%.dol mkw.d\sys\main.dol >nul
copy /b fkw\codes\main%LETTER%.bin fkw\codes\tmp.bin >nul
copy /b fkw\tracks\*.szs mkw.d\files\Race\Course >nul

IF %LETTER%==p (
	copy /b fkw\Race_E.szs mkw.d\files\Scene\UI\Race_E.szs >nul
	copy /b fkw\Race_F.szs mkw.d\files\Scene\UI\Race_F.szs >nul
	copy /b fkw\Race_G.szs mkw.d\files\Scene\UI\Race_G.szs >nul
	copy /b fkw\Race_I.szs mkw.d\files\Scene\UI\Race_I.szs >nul
	copy /b fkw\Race_S.szs mkw.d\files\Scene\UI\Race_S.szs >nul
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
	copy /b fkw\Common_S.szs mkw.d\files\Race\Common_M.szs >nul
	copy /b fkw\Common_F.szs mkw.d\files\Race\Common_Q.szs >nul
	copy /b fkw\Common_E.szs mkw.d\files\Race\Common_U.szs >nul
)

IF %LETTER%==j (
	copy /b fkw\Race_J.szs mkw.d\files\Scene\UI\Race_J.szs >nul
	copy /b fkw\Common_J.szs mkw.d\files\Race\Common_J.szs >nul
)

IF %LETTER%==k (
	copy /b fkw\Race_K.szs mkw.d\files\Scene\UI\Race_K.szs >nul
	copy /b fkw\Common_J.szs mkw.d\files\Race\Common_J.szs >nul
)

echo.
SET /P VOTING=Enable Always Win Track Vote? (Y/N):
IF /i %VOTING%==Y copy /b fkw\codes\tmp.bin+fkw\codes\voting%LETTER%.bin fkw\codes\tmp.bin >nul

echo.
SET /P FASTMENU=Enable Faster Menu Navigation? (Y/N):
IF /i %FASTMENU%==Y copy /b fkw\codes\tmp.bin+fkw\codes\fastmenu%LETTER%.bin fkw\codes\tmp.bin >nul

echo.
SET /P MIIHEADS=Enable Mii Heads on Minimap? (Y/N):
IF /i %MIIHEADS%==Y copy /b fkw\codes\tmp.bin+fkw\codes\miiheads%LETTER%.bin fkw\codes\tmp.bin >nul

echo.
SET /P NOMUS=Disable Music? (Y/N):
IF /i %NOMUS%==Y copy /b fkw\codes\tmp.bin+fkw\codes\nomus%LETTER%.bin fkw\codes\tmp.bin >nul

echo.
SET /P NOCHARS=Disable Character Voices? (Y/N):
IF /i %NOCHARS%==Y copy /b fkw\codes\tmp.bin+fkw\codes\nochars%LETTER%.bin fkw\codes\tmp.bin >nul

echo.
SET /P BTGLITCH=Force Battle Glitch? (Y/N):
IF /i %BTGLITCH%==Y copy /b fkw\codes\tmp.bin+fkw\codes\btglitch%LETTER%.bin fkw\codes\tmp.bin >nul

echo.
SET /P FRAMERATE=Force 30 FPS? (Y/N):
IF /i %FRAMERATE%==Y copy /b fkw\codes\tmp.bin+fkw\codes\framerate%LETTER%.bin fkw\codes\tmp.bin >nul

mkdir mkw.d\files\codes
copy /b fkw\codes\tmp.bin + fkw\codes\ending.bin mkw.d\files\codes\%GAMEID%.gct >nul
del /f fkw\codes\tmp.bin

echo.
echo Format Selection:
echo 1. WBFS
echo 2. ISO
echo 3. Extracted Filesystem (ADVANCED USERS ONLY)
echo Enter the number corresponding to the format you want
SET /P EXTINPUT=Enter Number and press Enter:

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