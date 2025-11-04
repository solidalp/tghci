unit timebased;

interface

uses
  sysutils, crt, Events;

type
  TEvo = (oeuf, enfant, ado, adulte);

  Ttamago = record
    evo: TEvo;
    facteur_faim, facteur_bonheur: real;
    faim, bonheur, fatigue: integer;  
    tempsStable: longint; ///jsppp ici si ca marche avec longint             
  end;

procedure nourrir(var tama: Ttamago);
procedure dormir(var tama: Ttamago);
procedure jouer(var tama: Ttamago);
procedure evolution(var tama: Ttamago);
function mort(tama: Ttamago): boolean;
procedure getstats(tama: Ttamago);
procedure movestats(var tama: Ttamago; var dernierTick: longint);

implementation

function mort(tama: Ttamago): boolean;
begin
  mort := (tama.faim <= 10) or (tama.bonheur <= 0) or (tama.fatigue <= 10);
end;

procedure evolution(var tama: Ttamago);
begin
  if tama.evo < adulte then
  begin
    tama.evo := succ(tama.evo);
    writeln(' Ton Tamagotchi a évolué !YAYYY! Nouveau stade : ', Ord(tama.evo));
    tama.tempsStable := 0;
  end
  else
    writeln('Ton Tamagotchi restera le même si vous continuez à jouer avec eux.');
end;

procedure nourrir(var tama: Ttamago);
begin
  tama.faim := tama.faim - 3;
  if tama.faim < 0 then tama.faim := 0;
  writeln('Tu as nourri ta Tamagotchi.');
end;

procedure dormir(var tama: Ttamago);
begin
  tama.fatigue := tama.fatigue - 3;
  if tama.fatigue < 0 then tama.fatigue := 0;
  tama.faim := tama.faim + 1;
  writeln('Ta Tamagotchi dort bien.');
end;

procedure jouer(var tama: Ttamago);
begin
  tama.bonheur := tama.bonheur + 2;
  if tama.bonheur > 10 then tama.bonheur := 10;
  tama.fatigue := tama.fatigue + 2;
  tama.faim := tama.faim + 2;
  writeln('Ta Tamagotchi joue et s’amuse !');
end;

procedure getstats(tama: Ttamago);
begin
  writeln('--- État du Tamagotchi ---');
  writeln('  Stage   : ', Ord(tama.evo));
  writeln('  Faim    : ', tama.faim);
  writeln('  Fatigue : ', tama.fatigue);
  writeln('  Bonheur : ', tama.bonheur);
  writeln;
end;

procedure movestats(var tama: Ttamago; var dernierTick: longint);
var
  actuel, diff: longint;
begin
  actuel := tickcount;
  diff := actuel - dernierTick;

  //stats degarde in 1000ms
  if diff >= 1000 then
  begin
    dernierTick := actuel;

    tama.faim := tama.faim + 1;      { devient plus affamé }
    if tama.faim > 10 then tama.faim := 10;

    tama.fatigue := tama.fatigue + 1; { devient plus fatigué }
    if tama.fatigue > 10 then tama.fatigue := 10;

    tama.bonheur := tama.bonheur - 1; { devient moins heureux }
    if tama.bonheur < 0 then tama.bonheur := 0;

    //jai mis des conditions un peu au hazard faut tester et regardez si il jeu bien 
    if (tama.faim < 2) and (tama.fatigue < 2) and (tama.bonheur > 8) then
    begin
      if tama.tempsStable = 0 then
        tama.tempsStable := actuel  
      else if (actuel - tama.tempsStable) >= 120000 then //2 min au hazard peut etre moins pour les tests 
      begin
        evolution(tama);
        tama.tempsStable := 0;
      end;
    end
    else
      tama.tempsStable := 0; 
  end;
end;

end.
