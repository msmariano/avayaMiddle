[Setup]
AppName=AvayaMiddle
AppVersion=1.0.4 TAPI
DefaultDirName=C:\AvayaMiddle
DefaultGroupName=AvayaMiddle
UninstallDisplayIcon=C:\AvayaMiddle.exe
Compression=lzma2
SolidCompression=yes

[Languages]                      
Name: "BrazilianPortuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Files]
Source: ".\Files\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{group}\AvayaMiddle"; Filename: "{app}\AvayaMiddle.exe"
Name: "{userdesktop}\AvayaMiddle"; Filename: "{app}\AvayaMiddle.exe"
Name: "{commonstartup}\AvayaMiddle"; Filename: "{app}\AvayaMiddle.exe"; WorkingDir: {app}; IconFilename: "{app}\AvayaMiddle.exe"; IconIndex: 0; Tasks: iniciaricon 

[Tasks]
Name: iniciaricon; Description: Criar atalho no menu inicializar; GroupDescription: Atalhos adicionais: