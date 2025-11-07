Unit tamago;
interface 
uses sysutils,crt;
Type TEvo=(oeuf,enfant,ado,adulte,fantome);
Type Ttamago=record
   evo:TEvo;
   facteur_faim,facteur_bonheur : real;
   faim,bonheur,fatigue :integer;
end;

procedure nourrir(ent:integer ;var tama : Ttamago);
procedure dormir(ent:integer ;var tama : Ttamago);
procedure jouer(ent:integer ;var tama : Ttamago);
procedure evolution(var tama : Ttamago);
function mort(tama : Ttamago):boolean;
procedure verif(tama : Ttamago);
procedure fant(tama : Ttamago);
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
begin
if tama.evo<=(adulte) then
tama.evo:=succ(tama.evo);
            end;
end;

procedure fant(tama : Ttamago);
begin
if mort(tama) = true then tama.evo:=(fantome)
end;

procedure nourrir(ent:integer ; var tama : Ttamago);
begin
if tama.faim <= ent-20 then
tama.faim:=tama.faim + 20
else
tama.faim := ent
end;

procedure dormir(ent : integer;var tama : Ttamago);
begin
if tama.fatigue <= ent-20 then
tama.fatigue:=tama.fatigue + 20
else
tama.fatigue := ent
end;

procedure jouer(ent : integer;var tama : Ttamago);
begin
if tama.bonheur <= ent-20 then
tama.bonheur:=tama.bonheur + 20
else
tama.bonheur := ent
end;

procedure verif(tama : Ttamago);
begin
writeln('l'' evo est  : ',tama.evo);
writeln('la faim est de : ',tama.faim);
writeln('la fatigue est de : ',tama.fatigue);
writeln('le bonheur est de : ',tama.bonheur);
end;



end.





