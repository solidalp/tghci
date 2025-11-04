unit compteur;

{$mode objfpc}{$H+}
interface
uses crt, sysutils, classes;

type
  TCompteurThread = class(TThread)
  private
    FEnt: Integer;
    FNb:PSmallInt;
  protected
    procedure Execute; override;
  public
    constructor Create(Entree: Integer; var Nb: SmallInt);
  end;
implementation
constructor TcompteurThread.create(Entree: Integer; var Nb: SmallInt);
begin
        inherited Create(False);
        Fent := Entree;
        Fnb := @Nb;
FreeOnTerminate:= true;
end;

procedure TcompteurThread.execute;
var i : integer;
begin
for i :=fent downto 1 do 
 begin
   sleep(1000);
   Fnb^ := Fnb^-1;
   
 end;
end;

end.


