unit uPoe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uCEFWinControl,
  uCEFLinkedWinControlBase, uCEFChromiumWindow, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ChromiumWindow1: TChromiumWindow;
    Timer1: TTimer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ChromiumWindow1AfterCreated(Sender: TObject);
    procedure ChromiumWindow1Close(Sender: TObject);
  private
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
  CanClose := True; // Initialize the variable
  FormCloseQuery(Self, CanClose);
  Application.Terminate;
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
