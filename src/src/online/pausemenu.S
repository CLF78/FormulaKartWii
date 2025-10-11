.include "asm_setup.S"

.extern CreateScreen, DisconnectFromMatch, RKNetController, Menudata, Racedata, OPM_CreateOnlinePauseMenu, OPM_ReturnToOnlineMenu, OPM_ClosePauseOnEndOfRace3
.global CreateOnlinePauseMenu, ReplaceInvalidPauseID, AvoidDisconnectOnQuit, ReturnToOnlineMenu, PreventFreezeOnlinePause, KeepSoundsAndMusic, ClosePauseOnEndOfRace3, ShowControllerImage1, ShowControllerImage2

# Create VS pause menu and Quit confirmation screen for online race
# All other modes (2P VS, 1-2P Battle, 1-2P Live View etc etc) will jump to here with branch

# Create VS Pause menu
CreateOnlinePauseMenu:
mr r3, r31
li r4, 0x18
lis r12, CreateScreen@h
ori r12, r12, CreateScreen@l
mtctr r12
bctrl

# Create Quit Confirmation menu
mr r3, r31
li r4, 0x2C
lis r12, CreateScreen@h
ori r12, r12, CreateScreen@l
mtctr r12
bctrl
mr r3, r31
b OPM_CreateOnlinePauseMenu+4

# Replace invalid pause ID with VS pause ID

# Condition is r3 == -1, if not -1, continue as normal, else set pause ID to VS Pause
ReplaceInvalidPauseID:
bne end1
li r31, 0x18
end1:
blr


# Avoid closing connection when clicking "Quit" (Both quits from before and after Quit Confirmation)
# When you click Quit, the game calls a function to close the connection causing you to disconnect and having to reconnect
# So if you click Quit, you'd go to Quit Confirmation but you were already disconnected, so this has to be avoided
# This hook makes it so the "Quit" button skips the disconnection
# It also skips it when clicking "Quit" on Quit Confirmation so you don't disconnect and are forced to reconnect

# Check if online race/battle/live/froom section
AvoidDisconnectOnQuit:
lwz r12, 0 (r3)
cmpwi r12, 0x68
blt end2
cmpwi r12, 0x77
bgt end2

# Check if caller is "Quit" button and return if it is, to avoid connection close
cmpwi r0, 4
beqlr
cmpwi r0, 0x60
beqlr

# Original instruction
end2:
li r0, 0x1
blr

# Go to online main menu instead of single player menu and force disconnecting from match

# Original instruction (single player menu section)
ReturnToOnlineMenu:
li r4, 0x41

# Check if playing online, if not, end the code
lis r29, RKNetController@ha
lwz r29, RKNetController@l (r29)
lwz r0, 0x28 (r29)
cmpwi r0, 0
beq end3

# Call function to disconnect from match (So you instantly DC for others instead of stopping sending data for 3 seconds until you DC for them by timeout)
stwu r1,-128(r1)
stmw r3,8(r1)
mr r3, r29
lis r12, DisconnectFromMatch@h
ori r12, r12, DisconnectFromMatch@l
mtctr r12
bctrl
lmw r3,8(r1)
addi r1,r1,128

# Set menu section to online main menu
li r4, 0x55

# Check if local player count is 2, if it is, it's online multiplayer, set menu section to 2P online main menu instead
lis r29, Menudata@ha
lwz r29, Menudata@l (r29)
lwz r29, 0x98 (r29)
lwz r29, 0x124 (r29)
cmpwi r29, 0x2
bne end3

# Set menu section to 2P online main menu
li r4, 0x5B

# END THE CODE
end3:
b OPM_ReturnToOnlineMenu+4

# Prevent game stop/freeze/pause in online pause

# Check if online race/battle/live/froom section, if it is, force game to not be stop/frozen from pause
PreventFreezeOnlinePause:
lwz r12, 0 (r3)
lbz r3, 0x38B (r3)
cmpwi r12, 0x68
blt end4
cmpwi r12, 0x77
bgt end4

# Force to not be stopped/frozen
li r3, 0

# THE END
end4:
blr

# Sounds and music play in online pause

# Check if online race/battle/live/froom section, if it is, allow sound playing
KeepSoundsAndMusic:
lwz r3, 0 (r28)
cmpwi r3, 0x68
blt end5
cmpwi r3, 0x77
bgt end5

# Allow sound playing
li r3, 0

# THE END
end5:
blr

# Close Pause Menu when race ends to avoid a softlock

# If race state is less or equal to racing (2), end the code, else close pause menu
ClosePauseOnEndOfRace3:
lwz r29, 8 (r4)
lis r12, Racedata@ha
lwz r12, Racedata@l (r12)
lwz r12, 0x28 (r12)
cmpwi r12, 2
ble end6

# Check if pause menu is open, if not, end the code
cmpwi r29, 4
bne end6

# Close pause menu
li r12, 0
stb r12, 0x389 (r5)
li r12, 5
stw r12, 8 (r4)
li r12, 1
stw r12, 0x10 (r4)

# Play pause menu close SFX
stwu r1,-128(r1)
stmw r3,8(r1)
mr r3, r4
lwz r12, 0 (r4)
lwz r12, 0x40 (r12)
mtctr r12
bctrl
lmw r3,8(r1)
addi r1,r1,128

# End the code and restore r4 (which is originally loaded as r29 in the code)
end6:
mr r4, r29
b OPM_ClosePauseOnEndOfRace3+4

# Construct and show controller image in online pause part 1 (two parts are needed or else it'll crash)

# Check if online race/battle/live/froom section, if it is, force section to be Time Trials (to show controller image)
ShowControllerImage1:
lwz r3, 0 (r3)
cmpwi r3, 0x68
blt end7
cmpwi r3, 0x77
bgt end7

# Force Time Attack section
li r3, 0x1E

# THE END
end7:
blr

# Construct and show controller image in online pause part 2 (two parts are needed or else it'll crash)

# Check if online race/battle/live/froom section, if it is, force section to be Time Trials (to show controller image)
ShowControllerImage2:
lwz r0, 0(r3)
cmpwi r0, 0x68
blt end8
cmpwi r0, 0x77
bgt end8

# Force Time Attack Section
li r0, 0x1E

# THE END
end8:
blr