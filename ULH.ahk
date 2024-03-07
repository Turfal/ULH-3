#NoEnv
#persistent
#MaxThreadsPerHotkey 2
#KeyHistory 0

;bindings
key_stay_on	 := 	"XButton1"
key_off	 := 	"XButton2"
key_bunny_on 	 := 	"Left"
key_bunny_off 	 := 	"RIGHT"
shoot_key		:= "P"

hotkey, %key_stay_on%, stayon
hotkey, %key_off%, offloop
hotkey, %key_bunny_on%, bunny_on
hotkey, %key_bunny_off%, bunny_off

;settings
pixel_box	:=	5
pixel_sens	:=	5
pixel_color	:=	0xFEFE40
tap_time	:=	20

;shoot boundary
leftbound:= A_ScreenWidth/2-pixel_box
rightbound:= A_ScreenWidth/2+pixel_box
topbound:= A_ScreenHeight/2-(pixel_box*1.25)
bottombound:= A_ScreenHeight/2+pixel_box

start:
bunny_on:
settimer, loop2, 100
return
bunny_off:
settimer, loop2, off
return
stayon:
settimer, loop1, 100
return
offloop:
settimer, loop1, off
return
loop1:
PixelSearch()
return

loop2:
GetKeyState,state,space,P
If state != U
Send,{space}
Sleep,10
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
