program Poe;

uses
  Vcl.Forms,
  uCEFApplication,
  uPoe in 'uPoe.pas' {Form1},
  uAbout in 'uAbout.pas' {Form2},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  GlobalCEFApp := TCefApplication.Create;
  GlobalCEFApp.RootCache              := 'C:\Users\Public\Documents\Poe\cef\rootcache';
  GlobalCEFApp.cache                  := 'C:\Users\Public\Documents\Poe\cef\rootcache\cache';
  //GlobalCEFApp.UserDataPath           := 'C:\Users\Public\Documents\Poe\cef\userdata';
  GlobalCEFApp.PersistUserPreferences := True;
  GlobalCEFApp.PersistSessionCookies  := True;

  if GlobalCEFApp.StartMainProcess then
    begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := 'Poe - Unofficial';
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
    end;

  GlobalCEFApp.Free;
  GlobalCEFApp := nil;
end.
