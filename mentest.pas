program menu;
{$mode objfpc}{$H+}

uses cthreads,tamago,sysutils,crt,compteur,sdl2,sdl2_image;

var choix : integer;
var tama : Ttamago;
var window : PSDL_Window;
    renderer :PSDL_renderer; 
    texture : PSDL_texture;
    rect : PSDL_Rect;
    Event: TSDL_Event;    
    Running: Boolean = True;
const Max = 100;

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

SDL_CreateWindowAndRenderer(500,500, SDL_WINDOW_SHOWN,@window, @Renderer);
texture:= IMG_LoadTexture(renderer,'perso.png');
if texture = nil then 
writeln('pas d''image', IMG_GetError);


New(rect);
rect^.x :=100;
rect^.y :=100;
rect^.w :=200;
rect^.h :=200;

TcompteurThread.create(tama.faim,tama.faim);
TcompteurThread.create(tama.fatigue,tama.fatigue);
TcompteurThread.create(tama.bonheur,tama.bonheur);


running := true;
while Running do
  begin
    while SDL_PollEvent(@Event) <> 0 do
    begin
      if Event.type_ = SDL_QUITEV then
        Running := False;
    SDL_RenderClear(renderer);
    SDL_RenderCopy(Renderer, Texture,nil,rect);
    SDL_RenderPresent(Renderer);
  writeln('1,evo, 2 verif,3 nourrir,4 dormir,5 jouer');
  readln(choix);
   if choix = 1 then
      evolution(tama);
   if choix = 2 then 
	verif(tama);
   if choix = 3 then
	nourrir(Max,tama);
   if choix = 4 then
	dormir(Max,tama);
   if choix = 5 then
	jouer(Max,tama);
   if choix = 0 then
        tama.evo := fantome;
begin
if tama.evo=fantome then

running := false
end;
end;


end;








end;
Dispose(rect); 
SDL_DestroyTexture(texture);
SDL_DestroyRenderer(renderer);
SDL_DestroyWindow(window);
IMG_Quit;
SDL_Quit;
end.

{SDL_RenderCopy(renderer,texture,@rect,nil);
SDL_RenderPresent(@renderer);}




