unit uThread;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.StdCtrls,
  Vcl.Samples.Gauges, Vcl.Samples.Spin,uExportacao,uControleSQL,Vcl.DBGrids,uConexaoBanco,
  Datasnap.Provider, Datasnap.DBClient;

type
  TThreadExportacao = class(TThread)
  private

    Value:String;
    FValue: string;
    FMemo: TMemo;
    FPath: String;
    Flabel1: TLabel;
    Fcontador:integer;
    procedure SincronizarMemo;
    procedure SetValue(const Value: string);
    procedure SetMemo(const Value: TMemo);
    procedure SetPath(const Value: String);
    procedure Setlabel1(const Value: TLabel);
  protected
    procedure Execute; override;
    constructor Create; reintroduce;
  public
   property Memo : TMemo read FMemo write SetMemo;
   property caminho :String read FPath write SetPath;
   property label1:TLabel read Flabel1 write Setlabel1;
//   property Value:string read FValue write SetValue;
  end;
 TThreadGravaDados = class(TThread)
   private
    prword:string;
    TSQL: TExecSQL;
    FStringFULLREVValue: TStringList;
    FStringFULLORDValue: TStringList;
    FStringREVValue: TStringList;
    FStringORDValue: TStringList;
    FMemo: TMemo;
    FContador:integer;
    FLabel1: TLabel;
    procedure insertnw;
    procedure SetStringFULLORDValue(const Value: TStringList);
    procedure SetStringFULLREVValue(const Value: TStringList);
    procedure SetStringORDValue(const Value: TStringList);
    procedure SetStringREVValue(const Value: TStringList);
    function  ValorOrd(pword:String):integer;
    function  ValorRev(pword:String):integer;
    function  ValorFULLOrd(pword:String):integer;
    function  ValorFULLRev(pword:String):integer;
    procedure SetMemo(const Value: TMemo);
    procedure SetLabel1(const Value: TLabel);
   protected
    procedure Execute; override;
    constructor Create; reintroduce;

   public
    property StringORDValue:TStringList read FStringORDValue write SetStringORDValue;
    property StringREVValue:TStringList read FStringREVValue write SetStringREVValue;
    property StringFULLORDValue:TStringList read FStringFULLORDValue write SetStringFULLORDValue;
    property StringFULLREVValue:TStringList read FStringFULLREVValue write SetStringFULLREVValue;
     property Memo : TMemo read FMemo write SetMemo;
     property Label1:TLabel read FLabel1 write SetLabel1;
 end;
  TThreadCalcula = class(TThread)
    private
     StringORDValue:TStringList;
     StringREVValue:TStringList;
     StringFULLORDValue:TStringList;
     StringFULLREVValue:TStringList;
     FFULLORDlabel: TLabel;
     FREVlabel: TLabel;
     FORDlabel: TLabel;
     FFULLREVlabel: TLabel;
     Finputext: string;
     FFREVVALUE: String;
     FFORDVALUE: String;
     FFFULLREVVALUE: String;
     FFFULLORDVALUE: String;
      procedure SyncronizaLabel;
      procedure populaStringListORD;
      procedure populaStringListREV;
      procedure populaStringListFULLORD;
      procedure populaStringListFULLREV;
      procedure SetFULLORDlabel(const Value: TLabel);
      procedure SetFULLREVlabel(const Value: TLabel);
      procedure SetORDlabel(const Value: TLabel);
      procedure SetREVlabel(const Value: TLabel);
      procedure Setinputext(const Value: string);
      procedure SetFFULLORDVALUE(const Value: String);
      procedure SetFFULLREVVALUE(const Value: String);
      procedure SetFORDVALUE(const Value: String);
      procedure SetFREVVALUE(const Value: String);
      protected
      procedure Execute; override;
      constructor Create; reintroduce;
    public
     property  inputext:string read Finputext write Setinputext;
     property  ORDlabel:TLabel read FORDlabel write SetORDlabel;
     property  REVlabel:TLabel read FREVlabel write SetREVlabel;
     property  FULLREVlabel:TLabel read FFULLREVlabel write SetFULLREVlabel;
     property  FULLORDlabel:TLabel read FFULLORDlabel write SetFULLORDlabel;
     function  ValorOrd(pword:String):integer;
     function  ValorRev(pword:String):integer;
     function  ValorFULLOrd(pword:String):integer;
     function  ValorFULLRev(pword:String):integer;
     property  FORDVALUE:String read FFORDVALUE write SetFORDVALUE;
     property  FREVVALUE:String read FFREVVALUE write SetFREVVALUE;
     property  FFULLORDVALUE:String read FFFULLORDVALUE write SetFFULLORDVALUE;
     property  FFULLREVVALUE:String read FFFULLREVVALUE write SetFFULLREVVALUE;
  end;

  TThreadCarregaPalavras= class(TThread)
    private
    FClientDataSet1: TClientDataSet;
    Fedit: TEdit;
    procedure SetClientDataSet1(const Value: TClientDataSet);
    procedure Setedit(const Value: TEdit);
     procedure syncronizagrid;
    protected
      procedure Execute; override;
      constructor Create; reintroduce;
    public
      property edit:TEdit read Fedit write Setedit;
      property ClientDataSet1: TClientDataSet read FClientDataSet1 write SetClientDataSet1;

  end;

implementation

{ TThreadExportacao }

constructor TThreadExportacao.Create;
begin
  inherited
  Create(True);
  FreeOnTerminate := True;
  Fcontador:=0;
end;

procedure TThreadExportacao.Execute;
var
 arq: TextFile; { declarando a vari�vel "arq" do tipo arquivo texto }
 path,linha: string;
begin
    AssignFile(arq, caminho);
    Reset(arq);
  inherited;

  if not Terminated then
  try
     if (IOResult <> 0) then
        showmessage('File opening error !!!')
        else
         while (not eof(arq)) do
           begin

              readln(arq, linha);

              Value:=linha;
              Synchronize(SincronizarMemo);
              Application.ProcessMessages

           end;
           CloseFile(arq);

  finally
    MessageDlg('As palavras se encontram na �rea de transfer�ncia, clique em importar para concluir a importa��o!',mtConfirmation,[mbOK],1 );
  end;

end;

procedure TThreadExportacao.Setlabel1(const Value: TLabel);
begin
  Flabel1 := Value;
end;

procedure TThreadExportacao.SetMemo(const Value: TMemo);
begin
  FMemo := Value;
end;

procedure TThreadExportacao.SetPath(const Value: String);
begin
  FPath := Value;
end;

procedure TThreadExportacao.SetValue(const Value: string);
begin
  FValue := Value;
end;

procedure TThreadExportacao.SincronizarMemo;
begin
 Memo.Lines.Add(UpperCase(value));
 inc(Fcontador,1);
 label1.Caption := 'words in transfer area: '+inttostr(Fcontador);
end;

{ TThreadGravaDados }

constructor TThreadGravaDados.Create;
begin
  inherited
  Create(True);
  FreeOnTerminate := True;
  FContador:=0;
end;

procedure TThreadGravaDados.Execute;
var
i:integer;
begin
  inherited;
  if not Terminated then
    try
      for I := 0 to Memo.Lines.Count-1 do
          begin
            prword:=(Memo.Lines.Strings[I]);
            Synchronize(insertnw);
            prword:=EmptyStr;
          end;
    finally
     MessageDlg('words successfully imported! ',mtConfirmation,[mbOK],1 );
     FContador:=0;
    end;
end;

procedure TThreadGravaDados.insertnw;
var
  wSQL:string;
begin
  if not Assigned(TSQL) then
    TSQL:= TExecSQL.Create;
  // chamada de m�todos para pegar os valores das palavras
//  ValorFULLOrd(word);
//  ValorFULLRev(word);
//  ValorOrd(word);
  wSQL := EmptyStr;
  wSQL := 'update or insert into WORDSTB (BDWORD,ORDVALUE,REVALUE,FULLORDVALUE,FULLREVALUE) ';
  wSQL := wSQL + ' values (UPPER('+QuotedStr(prword)+'),'+inttostr(ValorORD(prword))+','+inttostr(ValorREV(prword))+','+IntToStr(ValorFULLOrd(prword))+','+IntToStr(ValorFULLRev(prword))+')';
  TSQL.SQL(wSQL);
  Inc(FContador,1);
  Label1.Caption:='imported words: '+inttostr(FContador);
//  ShowMessage('GRAVOU');



end;
procedure TThreadGravaDados.SetLabel1(const Value: TLabel);
begin
  FLabel1 := Value;
end;

procedure TThreadGravaDados.SetMemo(const Value: TMemo);
begin
  FMemo := Value;
end;

procedure TThreadGravaDados.SetStringFULLORDValue(const Value: TStringList);
begin
  FStringFULLORDValue := Value;
end;

procedure TThreadGravaDados.SetStringFULLREVValue(const Value: TStringList);
begin
  FStringFULLREVValue := Value;
end;

procedure TThreadGravaDados.SetStringORDValue(const Value: TStringList);
begin
  FStringORDValue := Value;
end;

procedure TThreadGravaDados.SetStringREVValue(const Value: TStringList);
begin
  FStringREVValue := Value;
end;



function TThreadGravaDados.ValorFULLOrd(pword: String): integer;
var
  wValorFULLord,
  i,j:integer;
begin

  wValorFULLord:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringFULLORDValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringFULLORDValue[j]) then
                        begin
                          wValorFULLord := wValorFULLord + integer(StringFULLORDValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorFULLord;
//  ShowMessage('valor FULLORD: '+IntToStr(wValorFULLord));

end;

function TThreadGravaDados.ValorFULLRev(pword: String): integer;
var
  wValorFULLrev,
  i,j:integer;
begin

  wValorFULLrev:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringFULLREVValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringFULLREVValue[j]) then
                        begin
                          wValorFULLrev := wValorFULLrev + integer(StringFULLREVValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorFULLrev;
//  ShowMessage('valor FULLREV: '+IntToStr(wValorFULLrev));

end;

function TThreadGravaDados.ValorOrd(pword: String): integer;
var
  wValorOrdinal,
  i,j:integer;
begin

  wValorOrdinal:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringORDValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringORDValue[j]) then
                        begin
                          wValorOrdinal := wValorOrdinal + integer(StringORDValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorOrdinal;
//  ShowMessage('valor ordinal: '+IntToStr(wValorOrdinal));

end;

function TThreadGravaDados.ValorRev(pword: String): integer;
var
  wValorReverso,
  i,j:integer;
begin

  wValorReverso:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringORDValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringREVValue[j]) then
                        begin
                          wValorReverso := wValorReverso + integer(StringREVValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorReverso;
//  ShowMessage('valor REVERSO: '+IntToStr(wValorReverso));

end;

{ TThreadCalcula }

constructor TThreadCalcula.Create;
begin
  inherited
    Create(True);
    FreeOnTerminate := True;
    StringORDValue:= TStringList.Create;
    StringREVValue:= TStringList.Create;
    StringFULLORDValue := TStringList.Create;
    StringFULLREVValue := TStringList.Create;
end;

procedure TThreadCalcula.Execute;
begin
  inherited;
  if not Terminated then
          begin
             Synchronize(SyncronizaLabel);
          end;

end;

procedure TThreadCalcula.populaStringListFULLORD;
begin
  StringFULLORDValue.AddObject('a',TObject(1));
  StringFULLORDValue.AddObject('b',TObject(2));
  StringFULLORDValue.AddObject('c',TObject(3));
  StringFULLORDValue.AddObject('d',TObject(4));
  StringFULLORDValue.AddObject('e',TObject(5));
  StringFULLORDValue.AddObject('f',TObject(6));
  StringFULLORDValue.AddObject('g',TObject(7));
  StringFULLORDValue.AddObject('h',TObject(8));
  StringFULLORDValue.AddObject('i',TObject(9));
  StringFULLORDValue.AddObject('j',TObject(1));
  StringFULLORDValue.AddObject('k',TObject(2));
  StringFULLORDValue.AddObject('l',TObject(3));
  StringFULLORDValue.AddObject('m',TObject(4));
  StringFULLORDValue.AddObject('n',TObject(5));
  StringFULLORDValue.AddObject('o',TObject(6));
  StringFULLORDValue.AddObject('p',TObject(7));
  StringFULLORDValue.AddObject('q',TObject(8));
  StringFULLORDValue.AddObject('r',TObject(9));
  StringFULLORDValue.AddObject('s',TObject(1));
  StringFULLORDValue.AddObject('t',TObject(2));
  StringFULLORDValue.AddObject('u',TObject(3));
  StringFULLORDValue.AddObject('v',TObject(4));
  StringFULLORDValue.AddObject('w',TObject(5));
  StringFULLORDValue.AddObject('x',TObject(6));
  StringFULLORDValue.AddObject('y',TObject(7));
  StringFULLORDValue.AddObject('z',TObject(8));
end;

procedure TThreadCalcula.populaStringListFULLREV;
begin
  StringFULLREVValue.AddObject('a',TObject(8));
  StringFULLREVValue.AddObject('b',TObject(7));
  StringFULLREVValue.AddObject('c',TObject(6));
  StringFULLREVValue.AddObject('d',TObject(5));
  StringFULLREVValue.AddObject('e',TObject(4));
  StringFULLREVValue.AddObject('f',TObject(3));
  StringFULLREVValue.AddObject('g',TObject(2));
  StringFULLREVValue.AddObject('h',TObject(1));
  StringFULLREVValue.AddObject('i',TObject(9));
  StringFULLREVValue.AddObject('j',TObject(8));
  StringFULLREVValue.AddObject('k',TObject(7));
  StringFULLREVValue.AddObject('l',TObject(6));
  StringFULLREVValue.AddObject('m',TObject(5));
  StringFULLREVValue.AddObject('n',TObject(4));
  StringFULLREVValue.AddObject('o',TObject(3));
  StringFULLREVValue.AddObject('p',TObject(2));
  StringFULLREVValue.AddObject('q',TObject(1));
  StringFULLREVValue.AddObject('r',TObject(9));
  StringFULLREVValue.AddObject('s',TObject(8));
  StringFULLREVValue.AddObject('t',TObject(7));
  StringFULLREVValue.AddObject('u',TObject(6));
  StringFULLREVValue.AddObject('v',TObject(5));
  StringFULLREVValue.AddObject('w',TObject(4));
  StringFULLREVValue.AddObject('x',TObject(3));
  StringFULLREVValue.AddObject('y',TObject(2));
  StringFULLREVValue.AddObject('z',TObject(1));
end;

procedure TThreadCalcula.populaStringListORD;
begin
  StringORDValue.AddObject('a',TObject(1));
  StringORDValue.AddObject('b',TObject(2));
  StringORDValue.AddObject('c',TObject(3));
  StringORDValue.AddObject('d',TObject(4));
  StringORDValue.AddObject('e',TObject(5));
  StringORDValue.AddObject('f',TObject(6));
  StringORDValue.AddObject('g',TObject(7));
  StringORDValue.AddObject('h',TObject(8));
  StringORDValue.AddObject('i',TObject(9));
  StringORDValue.AddObject('j',TObject(10));
  StringORDValue.AddObject('k',TObject(11));
  StringORDValue.AddObject('l',TObject(12));
  StringORDValue.AddObject('m',TObject(13));
  StringORDValue.AddObject('n',TObject(14));
  StringORDValue.AddObject('o',TObject(15));
  StringORDValue.AddObject('p',TObject(16));
  StringORDValue.AddObject('q',TObject(17));
  StringORDValue.AddObject('r',TObject(18));
  StringORDValue.AddObject('s',TObject(19));
  StringORDValue.AddObject('t',TObject(20));
  StringORDValue.AddObject('u',TObject(21));
  StringORDValue.AddObject('v',TObject(22));
  StringORDValue.AddObject('w',TObject(23));
  StringORDValue.AddObject('x',TObject(24));
  StringORDValue.AddObject('y',TObject(25));
  StringORDValue.AddObject('z',TObject(26));
end;

procedure TThreadCalcula.populaStringListREV;
begin
  StringREVValue.AddObject('a',TObject(26));
  StringREVValue.AddObject('b',TObject(25));
  StringREVValue.AddObject('c',TObject(24));
  StringREVValue.AddObject('d',TObject(23));
  StringREVValue.AddObject('e',TObject(22));
  StringREVValue.AddObject('f',TObject(21));
  StringREVValue.AddObject('g',TObject(20));
  StringREVValue.AddObject('h',TObject(19));
  StringREVValue.AddObject('i',TObject(18));
  StringREVValue.AddObject('j',TObject(17));
  StringREVValue.AddObject('k',TObject(16));
  StringREVValue.AddObject('l',TObject(15));
  StringREVValue.AddObject('m',TObject(14));
  StringREVValue.AddObject('n',TObject(13));
  StringREVValue.AddObject('o',TObject(12));
  StringREVValue.AddObject('p',TObject(11));
  StringREVValue.AddObject('q',TObject(10));
  StringREVValue.AddObject('r',TObject(9));
  StringREVValue.AddObject('s',TObject(8));
  StringREVValue.AddObject('t',TObject(7));
  StringREVValue.AddObject('u',TObject(6));
  StringREVValue.AddObject('v',TObject(5));
  StringREVValue.AddObject('w',TObject(4));
  StringREVValue.AddObject('x',TObject(3));
  StringREVValue.AddObject('y',TObject(2));
  StringREVValue.AddObject('z',TObject(1));
end;



procedure TThreadCalcula.SetFFULLORDVALUE(const Value: String);
begin
  FFFULLORDVALUE := Value;
end;

procedure TThreadCalcula.SetFFULLREVVALUE(const Value: String);
begin
  FFFULLREVVALUE := Value;
end;

procedure TThreadCalcula.SetFORDVALUE(const Value: String);
begin
  FFORDVALUE := Value;
end;

procedure TThreadCalcula.SetFREVVALUE(const Value: String);
begin
  FFREVVALUE := Value;
end;

procedure TThreadCalcula.SetFULLORDlabel(const Value: TLabel);
begin
  FFULLORDlabel := Value;
end;

procedure TThreadCalcula.SetFULLREVlabel(const Value: TLabel);
begin
  FFULLREVlabel := Value;
end;

procedure TThreadCalcula.Setinputext(const Value: string);
begin
  Finputext := Value;
end;

procedure TThreadCalcula.SetORDlabel(const Value: TLabel);
begin
  FORDlabel := Value;
end;

procedure TThreadCalcula.SetREVlabel(const Value: TLabel);
begin
  FREVlabel := Value;
end;

procedure TThreadCalcula.SyncronizaLabel;
begin
    StringORDValue:= TStringList.Create;
    StringREVValue:= TStringList.Create;
    StringFULLORDValue := TStringList.Create;
    StringFULLREVValue := TStringList.Create;
    populaStringListORD;
    populaStringListREV;
    populaStringListFULLORD;
    populaStringListFULLREV;

    FORDVALUE:=inttostr(ValorOrd(inputext));
    FREVVALUE:=inttostr(ValorRev(inputext));
    FFULLORDVALUE:=inttostr(ValorFULLRev(inputext));
    FFULLREVVALUE:=inttostr(ValorFULLOrd(inputext));

  if not (inputext = EmptyStr) then
     begin
        ORDlabel.Caption:=inttostr(ValorOrd(inputext));
        REVlabel.Caption:=inttostr(ValorRev(inputext));
        FULLREVlabel.Caption:=inttostr(ValorFULLRev(inputext));
        FULLORDlabel.Caption:=inttostr(ValorFULLOrd(inputext));


        FORDVALUE:=inttostr(ValorOrd(inputext));
        FREVVALUE:=inttostr(ValorRev(inputext));
        FFULLORDVALUE:=inttostr(ValorFULLRev(inputext));
        FFULLREVVALUE:=inttostr(ValorFULLOrd(inputext));

     end;

end;

function TThreadCalcula.ValorFULLOrd(pword: String): integer;
var
  wValorFULLord,
  i,j:integer;
begin

  wValorFULLord:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringFULLORDValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringFULLORDValue[j]) then
                        begin
                          wValorFULLord := wValorFULLord + integer(StringFULLORDValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorFULLord;
//  ShowMessage('valor FULLORD: '+IntToStr(wValorFULLord));

end;

function TThreadCalcula.ValorFULLRev(pword: String): integer;
var
  wValorFULLrev,
  i,j:integer;
begin

  wValorFULLrev:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringFULLREVValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringFULLREVValue[j]) then
                        begin
                          wValorFULLrev := wValorFULLrev + integer(StringFULLREVValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorFULLrev;
//  ShowMessage('valor FULLREV: '+IntToStr(wValorFULLrev));

end;

function TThreadCalcula.ValorOrd(pword: String): integer;
var
  wValorOrdinal,
  i,j:integer;
begin

  wValorOrdinal:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringORDValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringORDValue[j]) then
                        begin
                          wValorOrdinal := wValorOrdinal + integer(StringORDValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorOrdinal;
//  ShowMessage('valor ordinal: '+IntToStr(wValorOrdinal));

end;

function TThreadCalcula.ValorRev(pword: String): integer;
var
  wValorReverso,
  i,j:integer;
begin

  wValorReverso:=0;
  for i := 0 to (pword.Length) do
  begin
          for j := 0 to StringORDValue.Count -1 do
              begin
                    if UpperCase(pword[i]) = UpperCase(StringREVValue[j]) then
                        begin
                          wValorReverso := wValorReverso + integer(StringREVValue.Objects[j]);
                        end;
              end;

  end;
  Result:=wValorReverso;
//  ShowMessage('valor REVERSO: '+IntToStr(wValorReverso));

end;
{ TThreadCarregaPalavras }

constructor TThreadCarregaPalavras.Create;
begin
inherited
    Create(True);
    FreeOnTerminate := True;
end;

procedure TThreadCarregaPalavras.Execute;
begin
  inherited;
   if not Terminated then
    Synchronize(syncronizagrid);

end;

procedure TThreadCarregaPalavras.SetClientDataSet1(const Value: TClientDataSet);
begin
  FClientDataSet1 := Value;
end;

procedure TThreadCarregaPalavras.Setedit(const Value: TEdit);
begin
  Fedit := Value;
end;

procedure TThreadCarregaPalavras.syncronizagrid;
var
wSQL:string;
begin
          //thread para exibir dados em um grid nao funciona
//        ClientDataSet1.Close;
//        wSQL:=' select * from wordstb where wordstb = AARDVARK';
//        ClientDataSet1.commandtext:='select * from wordstb wd where ordvalue = '+inttostr(Util.ValorOrd(trim(edTexto.Text)));
//        ClientDataSet1.open;
end;

end.

