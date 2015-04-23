#SingleInstance force
#InstallKeybdHook

;# WIN
;! ALT
;^ CTRL

UI:
  Title = Stream Helper
  Menu , Tray , Icon , %A_ScriptDir%\stream_helper.ico ,, 1
  Menu , Tray , Tip , %Title%

  GoSub InitConfig
  GoSub LoadConfig
Return

InitConfig:
  ConfigFileDir = %A_ScriptDir%
  ConfigFilePath = %ConfigFileDir%\stream_helper_settings.ini
  AudioRepeaterPID := (-1)
  ; AudioRepeaterWithParams = %AudioRepeater% /AutoStart /Input:"Microfono (USB PnP Sound Device" /Output:"Uscita Digitale (USB PnP Sound "
Return

LoadConfig:
  IniRead AudioRepeaterPath , %ConfigFilePath% , AudioRepeater , Path , D:\Program Files\Virtual Audio Cable\audiorepeater.exe
  IniRead AudioRepeaterInput , %ConfigFilePath% , AudioRepeater , InputDevice , Speakers (2- Sirus Headset)
  IniRead AudioRepeaterOutput , %ConfigFilePath% , AudioRepeater , OutputDevice , Altoparlanti (XSplit Stream A 
  IniRead ToggleHotkey , %ConfigFilePath% , Hotkeys , Toggle , Numpad8
  If (ToggleHotkey)
  {
    Hotkey %ToggleHotkey%, OnToggleAudioRepeater
  }
  AudioRepeaterWithParams = %AudioRepeaterPath% /AutoStart /Input:"%AudioRepeaterInput%" /Output:"%AudioRepeaterOutput%"
Return

OnToggleAudioRepeater:
  ToggleAudioRepeater()
Return

ToggleAudioRepeater()
{
  global AudioRepeaterPID
  global AudioRepeaterWithParams

  If (AudioRepeaterPID = (-1)) {
    Run %AudioRepeaterWithParams%,, Min, AudioRepeaterPID
  } Else {
    Process Close, %AudioRepeaterPID%
    AudioRepeaterPID := (-1)
  }

  Return
}

GuiClose:
  ExitApp