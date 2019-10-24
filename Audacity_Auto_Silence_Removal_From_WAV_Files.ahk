/*
"Dependent Requirements Before Running"
1. Audacity "Truncate Silence (Effect)" short-cut being "Shift+P"
2. Audacity "Amplify (Effect)" short-cut being "Shift+Y"
3. Audacity "Export as WAV" short-cut being "Shift+W"
4. Audacity "Close (File)" short-cut being "Ctrl+W"
5. Audacity "Exit (Window) short-cut being "Shift+L"
6. Before Every use of script, you have to Export something in the folder you wish to read files from, otherwise the directories will be all messed up at the end.
*/
#SingleInstance,Force
#Include C:\Users\KirkO\Desktop\Coding Repository\AutoHotKey\AHK_Library_Files\Vista_Audio_Control_Functions_V2.3.ahk


MsgBox Make sure that "Audacity" is running before hitting enter. Also make sure Audacity is currently pointing to your desired .WAV input directory before hitting enter (Before Every use of script, you have to Export something in the folder you wish to read files from, otherwise the directories will be all messed up at the end).
sleep, 400

WAV_File_Names := []

Loop, Files, C:\Users\KirkO\Desktop\Kirk Backup Files\zSaved Audio Files\Getting Edited\WAV\*.wav*, F	;- Used to get files names from destination folder where WAV files have been saved.
{
	WAV_File_Names.push(a_loopfilename)
}

Loop ;-- Main Script loop, calls all important functions and loops until a specific time.
{
	Fold_Chk := A_Index
	WinActivate, ahk_class wxWindowNR
	Sleep, 1000
	SendInput {Control down}
    SendInput {o}+{Control up}
	Sleep, 1000
	Fil_Nam := WAV_File_Names[A_Index]
	SendInput %Fil_Nam%
	Sleep, 1000
	SendInput {Enter}
	Sleep, 500
	WinActivate, ahk_class wxWindowNR
	Sleep, 500
	Audio_Cropper() ;- Function that will crop the audio of the current opened file, possibly lower volume as well after, may do that in separate function though.
	Audio_Amplify_Down() ;- Function that will "Amplify" the current opened file audio by -2 dB, essentially slightly reducing volume to be less ear-blasting from Raw file.
	Edited_File_Save(Fold_Chk) ;- Function that will save or "Export" the newly edited file as a .WAV file into another folder.
	Close_Project() ;- Closes the current project to start next one.
}Until (WAV_File_Names[A_Index+1] = "") ;-- Checks for the Array holding file names for a blank result, if it comes up, the script "finishes" and terminates.

Sleep, 400                      ;- Closes Audacity
WinActivate, ahk_class wxWindowNR
Sleep, 1000
SendInput {Shift down}
SendInput {l}+{Shift up} ; Closes Audacity Window Custom Short-Cut
Sleep, 2000

MsgBox Files are finished being converted! Make sure to compress and convert these .WAV files for proper use in play-lists. ;- Testing Purpose.
;DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)       ;- Puts the PC into Hibernate Mode, keep only if I want PC to Hibernate after script is done, like if I run while sleeping.
ExitApp ;- Unless I add more scripts to this for whatever reason, this is the end of the recording "chain" of scripts, only two for now it seems.



; +-------------------------------------------Functions---------------------------------------------------+

Audio_Cropper()
{
	WinActivate, ahk_class wxWindowNR
	Sleep, 500
	SendInput {Control down}
    SendInput {a}+{Control up}
	Sleep, 1000
	SendInput {Shift down}
    SendInput {p}+{Shift up}
	Sleep, 1500
	SendInput {Enter}
	Sleep, 1500
}


Audio_Amplify_Down()
{
	SendInput {Shift down}
    SendInput {y}+{Shift up}
	Sleep, 1500
	SendInput {-}
	Sleep, 50
	SendInput {2}
	Sleep, 200
	SendInput {Enter}
	Sleep, 4000
}


Edited_File_Save(Fold_Chk)
{
	SendInput {Shift down}
    SendInput {w}+{Shift up}
	Sleep, 1000
	if (Fold_Chk = 1)
	{	SendInput {.} ;- Brings file directory currently selected file directory back one or "Up".
		Sleep, 50
		SendInput {.}
		SendInput {Enter}
		Sleep, 100
	}
	SendInput {Enter}
	Sleep, 200
	SendInput {Enter}
	Sleep, 5000
	WinActivate, ahk_class wxWindowNR
    Sleep, 200
}


Close_Project()
{
	SendInput {Control down}
    SendInput {w}+{Control up}
    Sleep, 700
    SendInput {NumpadRight}
    Sleep, 50
    SendInput {Enter}
    Sleep, 500
    WinActivate, ahk_class wxWindowNR
    Sleep, 300
}