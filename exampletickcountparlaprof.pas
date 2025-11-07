program test;

uses sysutils;
var
	dep,fin,cr : QWord;
	i,j: longint;
begin
	dep:=GetTickCount64;
	writeln('dep=', dep);
	
	{simulation d'une fonction consommatrice de temps}
	for i:=1 to 999999 do
		begin
		 	for j:=1 to 999 do
		 		begin
		 		end;
		end;
	{dure ~2s , ajouter un 9 pour prolonger à ~20s)
	{fin de la simulation}
	
	fin :=GetTickCount64;
	writeln('fin=',fin);
	cr:=fin-dep;
	writeln('chrono=',cr);	
end.
