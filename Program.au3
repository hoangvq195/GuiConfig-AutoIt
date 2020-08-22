#include <GUI.au3>
#include <GuiConfig.au3>
_LoadConfig($Form1)

While 1
	Sleep(100)
WEnd

Func Button1Click()

EndFunc   ;==>Button1Click

Func Button2Click()

EndFunc   ;==>Button2Click

Func Form1Close()
	_SaveConfig($Form1)
	Exit
EndFunc   ;==>Form1Close
