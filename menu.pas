program menu;
{$mode objfpc}{$H+}

uses cthreads,tamago,sysutils,crt,compteur;

var choix : integer;
var tama : Ttamago;
const Max = 300;

procedure ChargerTamago(var T: Ttamago; nomFichier: string);
var
  f: Text;
  e: integer;
begin
  assign(f, nomFichier);
  reset(f);  { ouverture en lecture }

  readln(f, e);  { on lit l’évolution sous forme d’un entier }
  T.evo := TEvo(e);

  readln(f, T.facteur_faim);
  readln(f, T.facteur_bonheur);
  readln(f, T.faim);
  readln(f, T.bonheur);
  readln(f, T.fatigue);

  close(f);
end;

begin
chargerTamago(tama,'tamagochi.txt');
begin

TcompteurThread.create(tama.faim,tama.faim);
TcompteurThread.create(tama.fatigue,tama.fatigue);
TcompteurThread.create(tama.bonheur,tama.bonheur);

repeat writeln('1 : mort tamago,2 verif,3 nourrir,4 dormir,5 jouer');
readln(choix);
clrscr;

if choix = 1 then
mort(tama);
if choix = 2 then 
verif(tama);
if choix = 3 then
nourrir(tama);
if choix = 4 then
dormir(tama);
if choix = 5 then
jouer(tama);



begin
if mort(tama)=true then
writeln('il est mort');

end;



until (choix = 0) or (mort(tama) = true);

end;
end.




