; Uncomment one of following lines, if you haven't checked "Add IDP include path to ISPPBuiltins.iss" option during IDP installation:
;#pragma include __INCLUDE__ + ";" + ReadReg(HKLM, "Software\Mitrich Software\Inno Download Plugin", "InstallDir")
;#pragma include __INCLUDE__ + ";" + "c:\lib\InnoDownloadPlugin"


#define APP_NAME "BeansLauncher"
#define APP_VERSION "1.27"
#define APP_PUBLISHER "FiftyOne"
#define APP_URL "http://fiftyone.info"
#define APP_MAINEXEC "BeansLauncher.exe"

;#define UPDATE_URL        "ftp://ArmaBEANS_FTP:ArmaBohne1@138.201.227.120/Launcher
#define UPDATE_URL        "ftp://138.201.227.120/Launcher"
#define UPDATE_USER       "ArmaBEANS_FTP"
#define UPDATE_PASSWORD   "ArmaBohne1"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{13849FF9-A097-4F89-A9B8-C0AB91053D04}
AppName={#APP_NAME}
AppVersion={#APP_VERSION}
;AppVerName={#APP_NAME} {#APP_VERSION}
AppPublisher={#APP_PUBLISHER}
AppPublisherURL={#APP_URL}
AppSupportURL={#APP_URL}
AppUpdatesURL={#APP_URL}
DefaultDirName={pf}\{#APP_NAME}
DisableDirPage=yes
DefaultGroupName={#APP_NAME}
OutputBaseFilename=ArmaBeans_UNSTABLE
Compression=lzma
SolidCompression=yes

#include <idp.iss>
DisableReadyPage=True
DisableReadyMemo=True

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Icons]
Name: "{group}\{#APP_NAME}"; Filename: "{app}\{#APP_MAINEXEC}"
Name: "{group}\{cm:ProgramOnTheWeb,{#APP_NAME}}"; Filename: "{#APP_URL}"
Name: "{commondesktop}\{#APP_NAME}"; Filename: "{app}\{#APP_MAINEXEC}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#APP_NAME}"; Filename: "{app}\{#APP_MAINEXEC}"; Tasks: quicklaunchicon



; Uncomment one of following lines, if you haven't checked "Add IDP include path to ISPPBuiltins.iss" option during IDP installation:
;#pragma include __INCLUDE__ + ";" + ReadReg(HKLM, "Software\Mitrich Software\Inno Download Plugin", "InstallDir")
;#pragma include __INCLUDE__ + ";" + "c:\lib\InnoDownloadPlugin"

[Code]
procedure InitializeWizard();
begin
    idpDownloadAfter(wpReady);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  // if the user just reached the ready page, then...
  if CurPageID = wpReady then
//    if ForceDirectories(ExpandConstant('{app}')) then
    begin
      ForceDirectories(ExpandConstant('{app}'))
      // because the user can move back and forth in the wizard, this code branch can
      // be executed multiple times, so we need to clear the file list first
      idpClearFiles;
      // and add the files to the list; at this time, the {app} directory is known
      idpSetLogin('{#UPDATE_USER}', '{#UPDATE_PASSWORD}')
      idpAddFtpDir('{#UPDATE_URL}', '', ExpandConstant('{app}'), true);
      idpAddFile('{#UPDATE_URL}/libEGL.dll', ExpandConstant('{app}\libEGL.dll'));
      idpAddFile('{#UPDATE_URL}/libgcc_s_dw2-1.dll', ExpandConstant('{app}\libgcc_s_dw2-1.dll'));
      idpAddFile('{#UPDATE_URL}/libstdc++-6.dll', ExpandConstant('{app}\libstdc++-6.dll'));
      idpAddFile('{#UPDATE_URL}/libwinpthread-1.dll', ExpandConstant('{app}\libwinpthread-1.dll'));
      idpAddFile('{#UPDATE_URL}/Qt5Core.dll', ExpandConstant('{app}\Qt5Core.dll'));
      idpAddFile('{#UPDATE_URL}/Qt5Gui.dll', ExpandConstant('{app}\Qt5Gui.dll'));
      idpAddFile('{#UPDATE_URL}/Qt5Widgets.dll', ExpandConstant('{app}\Qt5Widgets.dll'));
    end
end;
