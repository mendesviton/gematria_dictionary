unit uControleSQL;

interface

uses

   Windows, Messages, SysUtils, Classes,  Controls, Forms, Dialogs,
   Variants, Contnrs,  DBXFirebird, SqlExpr,  StrUtils, inifiles,Vcl.StdCtrls,
   uConexaoBanco;


   type
    TExecSQL = class
      private
       FConnection    : TBDConnection;
       FCommandText : TSQLQuery;
      public
       constructor Create;
       destructor  Destroy; override;
       property CommandText : TSQLQuery read FCommandText write FCommandText;
        procedure SQL (wSQL:String);
        procedure SQLGRID(wSQL:String);


    end;

implementation

{ TExecSQL }

constructor TExecSQL.Create;
begin
   FConnection  := TBDConnection.Create;
   FCommandText := TSQLQuery.Create(Application);
   FCommandText.SQLConnection := FConnection.BDConnection;
end;

destructor TExecSQL.Destroy;
begin

  inherited;
end;
procedure TExecSQL.SQL(wSQL: String);
begin
 CommandText.Close;
 CommandText.SQL.Clear;
 CommandText.SQL.Add(wSQL);
 CommandText.ExecSQL;
 CommandText.Close;
end;


procedure TExecSQL.SQLGRID(wSQL:String);
begin
  CommandText.Close;
  CommandText.SQL.Add(wSQL);
  CommandText.Open;
end;

end.
