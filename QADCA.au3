#include <Array.au3>

Global $LOOP_MAXIMUM = 100

Global $aStorage[1]

ConsoleWrite("First encryption-decryption test cycle." & @CRLF)
$sEncrypt = _Encrypt(24811251, "Hello World!")
ConsoleWrite("Encrypted: " & $sEncrypt & @CRLF)
$sDecrypt = _Decrypt(24811251, $sEncrypt)
ConsoleWrite("Decrypted: " & $sDecrypt[1] & @CRLF & @CRLF)

ConsoleWrite("Second encryption-decryption test cycle." & @CRLF)
$sEncrypt = _Encrypt(24811251, "Hello World!")
ConsoleWrite("Encrypted: " & $sEncrypt & @CRLF)
$sDecrypt = _Decrypt(24811251, $sEncrypt)
ConsoleWrite("Decrypted: " & $sDecrypt[1] & @CRLF & @CRLF)

Func _Encrypt($iSharedID, $sMessage)
	Local $sReturn
	$sReturn = _Encrypt1($iSharedID, $sMessage)
	$sReturn = _Encrypt2($iSharedID, $sReturn)
	$sReturn = _Encrypt3($iSharedID, $sReturn)
	Return $sReturn
EndFunc   ;==>_Encrypt

Func _Decrypt($iSharedID, $sMessage)
	Local $aReturn[1]
	If (_IIH($sMessage)) Then
		$aReturn[0] = False
		Return $aReturn
	EndIf
	$sMessage = _Decrypt3($iSharedID, $sMessage)
	$sMessage = _Decrypt2($iSharedID, $sMessage)
	$aReturn = _Decrypt1($iSharedID, $sMessage)
	Return $aReturn
EndFunc   ;==>_Decrypt

Func _Encrypt1($iSharedID, $sMessage)
	Local $sReturn
	$sReturn = _EncryptMod($iSharedID) & $sMessage & _EncryptMod($iSharedID)
	Return $sReturn
EndFunc   ;==>_Encrypt1

Func _EncryptMod($iSharedID)
	Local $iReturn
	$iReturn = (Mod($iSharedID, 80)) + 19
	Return $iReturn
EndFunc   ;==>_EncryptMod

Func _Decrypt1($iSharedID, $sMessage)
	Local $aSplit, $sPop1, $sPop2, $fBool
	$aSplit = StringSplit($sMessage, "", 2)
	$sPop1 = _ArrayPop($aSplit)
	_ArrayPop($aSplit)
	_ArrayReverse($aSplit)
	$sPop2 = _ArrayPop($aSplit)
	_ArrayPop($aSplit)
	$fBool = False
	If (($sPop2 & "" & $sPop1) == _EncryptMod($iSharedID)) Then $fBool = True
	_ArrayReverse($aSplit)
	$aReturn = _ArrayCreate($fBool, _ArrayToString($aSplit, ""))
	Return $aReturn
EndFunc   ;==>_Decrypt1

Func _Encrypt2($iSharedID, $sMessage)
	Local $aTemporary[1]
	Local $aSplit, $iCounter, $sReturn
	$aSplit = StringSplit($sMessage, "", 2)
	$iCounter = 0
	While ($iCounter < StringLen($sMessage))
		If (Mod($iCounter, 3) == Mod($iSharedID, 3)) Then _
				_ArrayAdd($aTemporary, Chr(Round(Random() * 200) + 33))
		_ArrayAdd($aTemporary, $aSplit[$iCounter])
		$iCounter += 1
	WEnd
	$sReturn = _ArrayToString($aTemporary, "")
	Return $sReturn
EndFunc   ;==>_Encrypt2

Func _Decrypt2($iSharedID, $sMessage)
	Local $aTemporary[1]
	Local $aCounter[2] = [0, 0]
	Local $aSplit
	$aSplit = StringSplit($sMessage, "", 2)
	While ($aCounter[0] < StringLen($sMessage))
		If (Mod($aCounter[0], 3) == Mod($iSharedID, 3)) Then
			If (($aCounter[0] + $aCounter[1]) >= StringLen($sMessage)) Then
				_ArrayAdd($aSplit, "")
			Else
				$aSplit[$aCounter[0] + $aCounter[1]] = ""
			EndIf
			$aCounter[1] += 1
		EndIf
		$aCounter[0] += 1
	WEnd
	$aCounter[0] = 0
	While ($aCounter[0] < StringLen($sMessage))
		If ($aSplit[$aCounter[0]] <> "") Then _
				_ArrayAdd($aTemporary, $aSplit[$aCounter[0]])
		$aCounter[0] += 1
	WEnd
	$sReturn = _ArrayToString($aTemporary, "")
	Return $sReturn
EndFunc   ;==>_Decrypt2

Func _Encrypt3($iSharedID, $sMessage)
	Local $aSplit, $iCounter, $iCalculation
	$aSplit = StringSplit($sMessage, "", 2)
	$iCounter = 0
	While ($iCounter < UBound($aSplit))
		$iCalculation = (Asc($aSplit[$iCounter])) - (Mod($iSharedID, 10) + 10)
		$aSplit[$iCounter] = Chr($iCalculation)
		$iCounter += 1
	WEnd
	$aReturn = _ArrayToString($aSplit, "")
	Return $aReturn
EndFunc   ;==>_Encrypt3

Func _Decrypt3($iSharedID, $sMessage)
	Local $aSplit, $iCounter, $iCalculation, $aReturn
	$aSplit = StringSplit($sMessage, "", 2)
	$iCounter = 0
	While ($iCounter < UBound($aSplit))
		$iCalculation = (Asc($aSplit[$iCounter])) + (Mod($iSharedID, 10) + 10)
		$aSplit[$iCounter] = Chr($iCalculation)
		$iCounter += 1
	WEnd
	$aReturn = _ArrayToString($aSplit, "")
	Return $aReturn
EndFunc   ;==>_Decrypt3

Func _IIH($sMessage)
	Local $fBool, $iCounter
	$fBool = False
	$iCounter = 0
	If UBound($aStorage) >= 2 Then
		While ($iCounter < $LOOP_MAXIMUM)
			If ($aStorage[$iCounter] == $sMessage) Then $fBool = True
			$iCounter += 1
		WEnd
	EndIf
	$aStorage[Mod(0, $LOOP_MAXIMUM)] = $sMessage
	Return $fBool
EndFunc   ;==>_IIH