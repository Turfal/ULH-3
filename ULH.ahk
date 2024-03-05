#NoEnv
#persistent
#MaxThreadsPerHotkey 2
#KeyHistory 0

;bindings
key_stay_on	    := 	"Up"
key_off		    := 	"Down"
shoot_key		:= "P"

hotkey, %key_stay_on%, stayon
hotkey, %key_off%, offloop

;setings
pixel_box	:=	11
pixel_sens	:=	50
pixel_color	:=	0xFEFE40
tap_time	:=	10

;shoot boundery
leftbound:= A_ScreenWidth/2-pixel_box
rightbound:= A_ScreenWidth/2+pixel_box
topbound:= A_ScreenHeight/2-(pixel_box*1.25)
bottombound:= A_ScreenHeight/2+pixel_box

start:
stayon:
settimer, loop1, 100
return
offloop:
settimer, loop1, off
return
loop1:
PixelSearch()
return

PixelSearch() {
global
PixelSearch, FoundX, FoundY, leftbound, topbound, rightbound, bottombound, pixel_color, pixel_sens, Fast RGB
If !(ErrorLevel){
If !GetKeyState("LButton"){
Send {%shoot_key%}
sleep %tap_time%
}
}
return
}
Delete::ExitApp
