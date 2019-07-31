${SegmentFile}
Var CustomFirstRunDone

${SegmentPre}
	${If} ${FileExists} "$APPDATA\Franz\*.*"
		Rename "$APPDATA\Franz" "$APPDATA\Franz-BackupByFranzPortable"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\Data\Franz\*.*"
		Rename "$EXEDIR\Data\Franz" "$APPDATA\Franz"
	${EndIf}
	ReadINIStr $0 "$EXEDIR\Data\settings\FranzPortableFirstRun.ini" "FirstRun" "Done"
	${If} $0 != true
		CopyFiles "$EXEDIR\App\DefaultData\Franz\config\settings.json" "$APPDATA\Franz\config"
		ClearErrors
		MessageBox MB_ICONINFORMATION|MB_OK "IMPORTANT PORTABILITY NOTE!$\r$\n$\r$\nYou need to create/sign in your account and go to settings and uncheck the option 'Launch Franz on start' because this option do not use the FranzPortable.exe but the Franz.exe."		
		StrCpy $CustomFirstRunDone true
	${EndIf}
!macroend
${SegmentPost}
	${If} ${FileExists} "$APPDATA\Franz\*.*"
		Rename "$APPDATA\Franz" "$EXEDIR\Data\Franz"
	${EndIf}
	${If} ${FileExists} "$APPDATA\Franz-BackupByFranzPortable\*.*"
		Rename "$APPDATA\Franz-BackupByFranzPortable" "$APPDATA\Franz"
	${EndIf}
	${If} $CustomFirstRunDone == true
		WriteINIStr "$EXEDIR\Data\settings\FranzPortableFirstRun.ini" "FirstRun" "Done" "true"
	${EndIf}
!macroend
