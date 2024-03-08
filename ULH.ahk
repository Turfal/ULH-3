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
brightness_tolerance := 200 ; Порог отклонения яркости (от 0 до 255)

;shoot boundary
leftbound:= A_ScreenWidth/2-pixel_box
rightbound:= A_ScreenWidth/2+pixel_box
topbound:= A_ScreenHeight/2-(pixel_box*1.25)
bottombound:= A_ScreenHeight/2+pixel_box

; Функция для получения яркости цвета
GetColorBrightness(color) {
    red := (color >> 16) & 0xFF
    green := (color >> 8) & 0xFF
    blue := color & 0xFF
    return Round((red * 0.299) + (green * 0.587) + (blue * 0.114))
}

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
    if (!(ErrorLevel)) {
        PixelGetColor, current_color, FoundX, FoundY
        target_brightness := GetColorBrightness(pixel_color)
        current_brightness := GetColorBrightness(current_color)
        if (Abs(target_brightness - current_brightness) <= brightness_tolerance) {
            if (!GetKeyState("LButton")) {
                Send, {%shoot_key%}
                Sleep, %tap_time%
            }
        }
    }
    return
}
Delete::ExitApp
