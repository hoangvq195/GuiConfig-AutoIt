#include <WinAPISysWin.au3>
#include <GUIConstants.au3>
#include <GuiComboBox.au3>

Local $lastConfig = @ScriptDir & '\saveconfig.ini'

Func _SaveConfig($FormHandle, $filePath = $lastConfig)
	Local $pos = WinGetPos($FormHandle)
	IniWrite($filePath, 'config', 'left', $pos[0])
	IniWrite($filePath, 'config', 'top', $pos[1])

	$dummy = GUICtrlCreateDummy()
	For $i = 0 To $dummy - 1
		Local $controlID = $i + 3
		Local $controlType = _GetCtrlClass($controlID)
		Local $value
		Select
			Case $controlType == 'Checkbox' Or $controlType == 'Radio'
				IniWrite($filePath, 'config', $controlType & '_' & $controlID, GUICtrlRead($controlID) = 1 ? 'True' : 'Fasle')
			Case $controlType == 'Input' Or $controlType == 'Edit'
				IniWrite($filePath, 'config', $controlType & '_' & $controlID, BinaryToString(StringToBinary(GUICtrlRead($controlID), 4), 1))
			Case $controlType == 'Combo'
				IniWrite($filePath, 'config', $controlType & '_' & $controlID, _GUICtrlComboBox_GetCurSel($controlID))
		EndSelect
	Next
EndFunc   ;==>_SaveConfig

Func _LoadConfig($FormHandle, $filePath = $lastConfig)
	If Not FileExists($filePath) Then Return

	Local $left = IniRead($filePath, 'config', 'left', '')
	Local $top = IniRead($filePath, 'config', 'top', '')
	If $left <> '' And $top <> '' Then WinMove($FormHandle, '', $left, $top)

	Local $section = IniReadSection($filePath, 'config')
	For $i = 1 To $section[0][0]
		Local $str = StringSplit($section[$i][0], '_', 2)
		If @error Then ContinueLoop
		Local $controlType = $str[0]
		Local $controlID = $str[1]
		Local $value = $section[$i][1]
		Select
			Case $controlType == 'Checkbox' Or $controlType == 'Radio'
				GUICtrlSetState($controlID, $value == 'True' ? 1 : 4)
			Case $controlType == 'Input' Or $controlType == 'Edit'
				GUICtrlSetData($controlID, BinaryToString(StringToBinary($value, 1), 4))
			Case $controlType == 'Combo'
				_GUICtrlComboBox_SetCurSel($controlID, Number($value))
		EndSelect
	Next
EndFunc   ;==>_LoadConfig

Func _GetCtrlClass($hHandle)
	Local Const $GWL_STYLE = -16
	Local $iLong, $sClass
	If IsHWnd($hHandle) = 0 Then
		$hHandle = GUICtrlGetHandle($hHandle)
		If IsHWnd($hHandle) = 0 Then
			Return SetError(1, 0, "Unknown")
		EndIf
	EndIf

	$sClass = _WinAPI_GetClassName($hHandle)
	If @error Then
		Return "Unknown"
	EndIf

	$iLong = _WinAPI_GetWindowLong($hHandle, $GWL_STYLE)
	If @error Then
		Return SetError(2, 0, 0)
	EndIf

	Switch $sClass
		Case "Button"
			Select
				Case BitAND($iLong, $BS_GROUPBOX) = $BS_GROUPBOX
					Return "Group"
				Case BitAND($iLong, $BS_CHECKBOX) = $BS_CHECKBOX
					Return "Checkbox"
				Case BitAND($iLong, $BS_AUTOCHECKBOX) = $BS_AUTOCHECKBOX
					Return "Checkbox"
				Case BitAND($iLong, $BS_RADIOBUTTON) = $BS_RADIOBUTTON
					Return "Radio"
				Case BitAND($iLong, $BS_AUTORADIOBUTTON) = $BS_AUTORADIOBUTTON
					Return "Radio"
			EndSelect

		Case "Edit"
			Select
				Case BitAND($iLong, $ES_WANTRETURN) = $ES_WANTRETURN
					Return "Edit"
				Case Else
					Return "Input"
			EndSelect

		Case "Static"
			Select
				Case BitAND($iLong, $SS_BITMAP) = $SS_BITMAP
					Return "Pic"
				Case BitAND($iLong, $SS_ICON) = $SS_ICON
					Return "Icon"
				Case BitAND($iLong, $SS_LEFT) = $SS_LEFT
					If BitAND($iLong, $SS_NOTIFY) = $SS_NOTIFY Then
						Return "Label"
					EndIf
					Return "Graphic"
			EndSelect

		Case "ComboBox"
			Return "Combo"
		Case "ListBox"
			Return "List"
		Case "msctls_progress32"
			Return "Progress"
		Case "msctls_trackbar32"
			Return "Slider"
		Case "SysDateTimePick32"
			Return "Date"
		Case "SysListView32"
			Return "ListView"
		Case "SysMonthCal32"
			Return "MonthCal"
		Case "SysTabControl32"
			Return "Tab"
		Case "SysTreeView32"
			Return "TreeView"

	EndSwitch
	Return $sClass
EndFunc   ;==>_GetCtrlClass

