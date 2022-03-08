object frExportacao: TfrExportacao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frExportacao'
  ClientHeight = 463
  ClientWidth = 826
  Color = cl3DDkShadow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 826
    Height = 463
    Align = alClient
    BevelKind = bkFlat
    TabOrder = 0
    object Label1: TLabel
      Left = 392
      Top = 189
      Width = 216
      Height = 16
      Caption = 'Choose a file to import the words'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 392
      Top = 211
      Width = 171
      Height = 16
      Caption = 'or enter one word per line'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 392
      Top = 410
      Width = 119
      Height = 16
      Caption = 'imported words: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 392
      Top = 371
      Width = 164
      Height = 16
      Caption = 'words in transfer area: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 614
      Top = 39
      Width = 106
      Height = 24
      BevelKind = bkFlat
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = -5
        Top = -2
        Width = 112
        Height = 24
        Caption = 'Search'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clLime
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton1Click
      end
    end
    object pnCaminho: TPanel
      Left = 66
      Top = 40
      Width = 542
      Height = 22
      BevelInner = bvLowered
      Caption = 'Insert file (.txt)'
      Color = clBackground
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object Panel4: TPanel
      Left = 383
      Top = 112
      Width = 106
      Height = 25
      BevelKind = bkFlat
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object SpeedButton3: TSpeedButton
        Left = -2
        Top = -1
        Width = 105
        Height = 24
        Caption = 'Import'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clLime
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton3Click
      end
    end
    object Panel5: TPanel
      Left = 383
      Top = 143
      Width = 106
      Height = 25
      BevelKind = bkFlat
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object SpeedButton4: TSpeedButton
        Left = -2
        Top = -2
        Width = 105
        Height = 24
        Caption = 'Clear'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clLime
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton4Click
      end
    end
    object GroupBox1: TGroupBox
      Left = 56
      Top = 104
      Width = 321
      Height = 329
      Caption = 'Transfer area'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Memo1: TMemo
        Left = 5
        Top = 17
        Width = 311
        Height = 305
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Memo1')
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssVertical
        ShowHint = True
        TabOrder = 0
        OnKeyUp = Memo1KeyUp
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 632
    Top = 104
  end
end
