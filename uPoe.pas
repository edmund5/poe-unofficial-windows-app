unit uPoe;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  System.Variants,
  uCEFChromium,
  uCEFChromiumCore,
  uCEFChromiumWindow,
  uCEFInterfaces,
  uCEFLinkedWinControlBase,
  uCEFWinControl,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Winapi.Messages,
  Winapi.Windows;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ChromiumWindow1: TChromiumWindow;
    Timer1: TTimer;
    Customize1: TMenuItem;
    HideMenu1: TMenuItem;
    Chromium1: TChromium;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure HideMenu1Click(Sender: TObject);
    procedure ChromiumWindow1AfterCreated(Sender: TObject);
    procedure ChromiumWindow1Close(Sender: TObject);
  private
    FIsMenuVisible: Boolean;
    procedure ExecuteJavaScript(const JSCode: string);
    procedure ToggleSidebarVisibility;
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
    procedure WMEnterMenuLoop(var aMessage: TMessage); message WM_ENTERMENULOOP;
    procedure WMExitMenuLoop(var aMessage: TMessage); message WM_EXITMENULOOP;
  protected
    FCanClose : boolean;
    FClosing  : boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uCEFApplication, uAbout;

procedure TForm1.ExecuteJavaScript(const JSCode: string);
begin
  if ChromiumWindow1.ChromiumBrowser.Initialized and
     (ChromiumWindow1.ChromiumBrowser.Browser <> nil) then
      ChromiumWindow1.ChromiumBrowser.Browser.MainFrame.ExecuteJavaScript(JSCode, '', 0);
end;

procedure TForm1.ToggleSidebarVisibility;
var
  JSCode: string;
begin
  if FIsMenuVisible then
  begin
    JSCode := 'document.querySelector(".SidebarLayout_sidebar__SXeDJ").style.display = "none";';
    HideMenu1.Caption := 'Show Menu';
  end
  else
  begin
    JSCode := 'document.querySelector(".SidebarLayout_sidebar__SXeDJ").style.display = "block";';
    HideMenu1.Caption := 'Hide Menu';
  end;

  ExecuteJavaScript(JSCode);

  FIsMenuVisible := not FIsMenuVisible;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FCanClose;

  if not(FClosing) then
    begin
      FClosing := True;
      Visible  := False;
      ChromiumWindow1.CloseBrowser(True);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FIsMenuVisible := True;

  FCanClose := False;
  FClosing  := False;

  Caption := 'Initializing the Poe.com platform';

  ChromiumWindow1.ChromiumBrowser.DefaultURL := 'https://poe.com';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if not(ChromiumWindow1.CreateBrowser) then Timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  if not(ChromiumWindow1.CreateBrowser) and not(ChromiumWindow1.Initialized) then
    Timer1.Enabled := True;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Exit1Click(Sender: TObject);
var CanClose: Boolean;
begin
  CanClose := True;
  FormCloseQuery(Self, CanClose);
  Application.Terminate;
end;

procedure TForm1.HideMenu1Click(Sender: TObject);
begin
  ToggleSidebarVisibility;
end;

procedure TForm1.ChromiumWindow1AfterCreated(Sender: TObject);
begin
  Caption := 'Poe - Unofficial';
end;

procedure TForm1.ChromiumWindow1Close(Sender: TObject);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TForm1.WMMove(var aMessage : TWMMove);
begin
  inherited;

  if (ChromiumWindow1 <> nil) then ChromiumWindow1.NotifyMoveOrResizeStarted;
end;

procedure TForm1.WMMoving(var aMessage : TMessage);
begin
  inherited;

  if (ChromiumWindow1 <> nil) then ChromiumWindow1.NotifyMoveOrResizeStarted;
end;

procedure TForm1.WMEnterMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := True;
end;

procedure TForm1.WMExitMenuLoop(var aMessage: TMessage);
begin
  inherited;

  if (aMessage.wParam = 0) and (GlobalCEFApp <> nil) then GlobalCEFApp.OsmodalLoop := False;
end;

end.
