program test;

uses Events;
var
	dep,fin,cr : longint;
	i,j: longint;
begin
	dep:=tickcount;
	writeln('dep=',dep);
	
	{simulation d'une fonction consommatrice de temps}
	for i:=1 to 200 do
		begin
		 	for j:=1 to 200 do
		 		begin
		 		end;
		end;
	{fin de la simulation}
	
	fin :=tickcount;
	writeln('fin=',fin);
	cr:=fin-dep;
	writeln('chrono=',cr);	
end.
