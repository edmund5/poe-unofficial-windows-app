object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 698
  ClientWidth = 1076
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ChromiumWindow1: TChromiumWindow
    Left = 0
    Top = 0
    Width = 1076
    Height = 698
    Align = alClient
    TabOrder = 0
    OnClose = ChromiumWindow1Close
    OnAfterCreated = ChromiumWindow1AfterCreated
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 16
    object File1: TMenuItem
      Caption = 'File'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Customize1: TMenuItem
      Caption = 'Customize'
      object HideMenu1: TMenuItem
        Caption = 'Hide Menu'
        OnClick = HideMenu1Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 88
    Top = 16
  end
  object Chromium1: TChromium
    Left = 144
    Top = 16
  end
end
