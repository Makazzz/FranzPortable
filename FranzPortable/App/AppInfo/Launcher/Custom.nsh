${SegmentFile}
Var CustomFirstRunDone

${SegmentPre}
	ReadINIStr $0 "$EXEDIR\Data\settings\FranzPortableFirstRun.ini" "FirstRun" "Done"
	${If} $0 != true
		ClearErrors
		MessageBox MB_ICONINFORMATION|MB_OK "IMPORTANT PORTABILITY NOTE!$\r$\n$\r$\nYou need to create/sign in your account and go to settings and uncheck the option 'Launch Franz on start' because this option do not use the FranzPortable.exe but the Franz.exe."		
		StrCpy $CustomFirstRunDone true
	${EndIf}
	${If} ${FileExists} "$EXEDIR\App\franz\resources\app-update.yml"
		Rename "$EXEDIR\App\franz\resources\app-update.yml" "$EXEDIR\App\franz\resources\app-update.yml-Disabled"
	${EndIf}
!macroend
${SegmentPost}
	${If} $CustomFirstRunDone == true
		WriteINIStr "$EXEDIR\Data\settings\FranzPortableFirstRun.ini" "FirstRun" "Done" "true"
	${EndIf}
	${If} ${FileExists} "$EXEDIR\App\franz\resources\app-update.yml-Disabled"
		Rename "$EXEDIR\App\franz\resources\app-update.yml-Disabled" "$EXEDIR\App\franz\resources\app-update.yml"
	${EndIf}
!macroend
