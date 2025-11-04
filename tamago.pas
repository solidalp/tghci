Unit tamago;
interface 
uses sysutils,crt;
Type TEvo=(oeuf,enfant,ado,adulte);
Type Ttamago=record
   evo:TEvo;
   facteur_faim,facteur_bonheur : real;
   faim,bonheur,fatigue :integer;
end;
procedure nourrir(var tama : Ttamago);
procedure dormir(var tama : Ttamago);
procedure jouer(var tama : Ttamago);
procedure evolution(var tama : Ttamago);
function mort(tama : Ttamago):boolean;
procedure verif(tama : Ttamago);
implementation

function mort(tama : Ttamago):boolean;
var vie : boolean;
begin
vie:= false;
 if (tama.faim = 0) or (tama.bonheur = 0) or (tama.fatigue =0 ) then
vie := true;
mort:=vie;
end;


procedure evolution(var tama : Ttamago);
begin
if tama.evo<(adulte) then
tama.evo:=succ(tama.evo)
            else mort(tama);
end;

procedure nourrir(var tama : Ttamago);
begin
tama.faim:=tama.faim + 5;
end;

procedure dormir(var tama : Ttamago);
begin
tama.fatigue:=tama.fatigue + 5;
end;

procedure jouer(var tama : Ttamago);
begin
tama.bonheur:=tama.bonheur + 5;
end;

procedure verif(tama : Ttamago);
begin
writeln('la faim est de : ',tama.faim);
writeln('la fatigue est de : ',tama.fatigue);
writeln('le bonheur est de : ',tama.bonheur);
end;



end.





