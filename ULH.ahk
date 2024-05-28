; #NoEnv
#SingleInstance force
#Persistent
boxSize := 3
sensitivity := 50
targetColor := 0xFEFE40
clickDelay := 120
holdKey := "SPACE"
currentMode := "lightmode"

clickMode := false
holdMode := false

clickModeHotkey := "Left"
holdModeHotkey := "Right"
turnOffHotkey := "Up"
terminateHotkey := "Down"

Hotkey, %clickModeHotkey%, ToggleClickMode
Hotkey, %holdModeHotkey%, ToggleHoldMode
Hotkey, %turnOffHotkey%, TurnOff
Hotkey, %terminateHotkey%, Terminate

ToggleClickMode:
clickMode := !clickMode
if (clickMode) {
    SetTimer, ClickLoop, 1
} else {
    SetTimer, ClickLoop, Off
}
return

ToggleHoldMode:
holdMode := !holdMode
if (holdMode) {
    SetTimer, HoldLoop, 1
} else {
    SetTimer, HoldLoop, Off
}
return

TurnOff:
clickMode := false
holdMode := false
SetTimer, ClickLoop, Off
SetTimer, HoldLoop, Off
return

Terminate:
SoundBeep, 300, 200
SoundBeep, 200, 200
Sleep 400
ExitApp

ClickLoop:
PixelSearch()
if (!(ErrorLevel)) {
    if (!GetKeyState("LButton")) {
        Click, %FoundX%, %FoundY%
        Sleep, %clickDelay%
    }
}
return

HoldLoop:
if GetKeyState(holdKey, "P") {
    PixelSearch()
    if (!(ErrorLevel)) {
        if (!GetKeyState("LButton")) {
            Click, %FoundX%, %FoundY%
            Sleep, %clickDelay%
        }
    }
}
return

PixelSearch() {
    global boxSize, sensitivity, targetColor, clickDelay
    startX := A_ScreenWidth // 2 - boxSize
    startY := A_ScreenHeight // 2 - boxSize
    endX := A_ScreenWidth // 2 + boxSize
    endY := A_ScreenHeight // 2 + boxSize
    PixelSearch, FoundX, FoundY, startX, startY, endX, endY, targetColor, sensitivity, Fast RGB
    if (!(ErrorLevel)) {
        if (!GetKeyState("LButton")) {
            Click, FoundX, FoundY
            Sleep clickDelay
        }
    }
    return
}
