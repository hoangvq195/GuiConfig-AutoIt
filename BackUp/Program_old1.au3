#include <GUI.au3>
#include <guiconfig.au3>
_LoadConfig($Form1)

While 1
	Sleep(100)
WEnd

Func Button1Click()

EndFunc

Func Button2Click()

EndFunc

Func Form1Close()
	_SaveConfig($Form1)
	Exit
EndFunc
