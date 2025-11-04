program compteur_descendant;
uses crt,sysUtils;
var mot : integer;


procedure compteur(entier : integer);
var i : integer;
begin
for i :=entier downto 1 do 
 begin
   clrscr;
   gotoxy(3,1);
   write(i);
   gotoxy(3,1);
   sleep(1000);
   write('    ');
   gotoxy(3,1)
 end;
end;

begin
writeln('quelle durée');
readln(mot);
compteur(mot);



end.


