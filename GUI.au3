#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=E:\GitHub\GuiConfig-AutoIt\Form1.kxf
Global $Form1 = GUICreate("Form1", 615, 437, 192, 124)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
Global $Input1 = GUICtrlCreateInput("", 78, 63, 121, 21)
Global $Input2 = GUICtrlCreateInput("", 78, 111, 121, 21)
GUICtrlCreateInput("", 78, 156, 121, 21)
Global $Checkbox1 = GUICtrlCreateCheckbox("Checkbox1", 255, 66, 97, 17)
Global $Checkbox2 = GUICtrlCreateCheckbox("Checkbox2", 255, 108, 97, 17)
Global $Checkbox3 = GUICtrlCreateCheckbox("Checkbox3", 255, 147, 97, 17)
Global $Radio1 = GUICtrlCreateRadio("Radio1", 438, 66, 113, 17)
Global $Radio2 = GUICtrlCreateRadio("Radio2", 438, 107, 113, 17)
Global $Combo1 = GUICtrlCreateCombo("", 405, 186, 145, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "item 1|item 2|item 3", "item 1")
Global $Button1 = GUICtrlCreateButton("Button1", 162, 264, 75, 25)
GUICtrlSetOnEvent(-1, "Button1Click")
Global $Button2 = GUICtrlCreateButton("Button2", 354, 267, 75, 25)
GUICtrlSetOnEvent(-1, "Button2Click")
GUICtrlCreateInput("", 78, 195, 121, 21)
Global $Radio3 = GUICtrlCreateRadio("Radio3", 438, 147, 113, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###