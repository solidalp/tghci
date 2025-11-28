program menu;
{$mode objfpc}{$H+}

uses cthreads,tamago,sysutils,crt,compteur,sdl2,sdl2_image;

var choix : integer;
    temps_derniere_evolution: Integer;
    temps_actuel: Integer;
var tama : Ttamago;
var window : PSDL_Window;
    renderer :PSDL_renderer; 
    texture : PSDL_texture;
    rect : PSDL_Rect;
    Event: TSDL_Event;    
    Running: Boolean = True;
    
const Max = 100;
      intervalle =30000;

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
SDL_CreateWindowAndRenderer(700,600, SDL_WINDOW_SHOWN,@window, @Renderer);
temps_derniere_evolution := SDL_GetTicks();
texture:= IMG_LoadTexture(renderer,'lucas.png');
if texture = nil then 
writeln('pas d''image', IMG_GetError);


New(rect);
rect^.x :=100;
rect^.y :=100;
rect^.w :=400;
rect^.h :=200;

TcompteurThread.create(tama.faim,tama.faim);
TcompteurThread.create(tama.fatigue,tama.fatigue);
TcompteurThread.create(tama.bonheur,tama.bonheur);


running := true;
while Running=true do
  begin
    while SDL_PollEvent(@Event) <> 0 do
    begin
      if Event.type_ = SDL_QUITEV then
        Running := False;
        begin
       
  
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
temps_actuel := SDL_GetTicks();
        if (temps_actuel - temps_derniere_evolution >= intervalle) then
        begin
        evolution(tama);
        temps_derniere_evolution := temps_actuel;
        
        end;
        begin
	if (tama.evo=fantome) or mort(tama)=true then
		begin
		SDL_DestroyTexture(texture);
		texture:= IMG_LoadTexture(renderer,'fadi.png');
		 SDL_RenderClear(renderer);
        	SDL_RenderCopy(Renderer, Texture,nil,rect);
        	SDL_RenderPresent(Renderer);
		writeln('il est mort');
		running := false;
		sleep(5000);
		break;
		end;

        
	end;
end;
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






