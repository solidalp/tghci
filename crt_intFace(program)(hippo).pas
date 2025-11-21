program arayuz;
uses crt;
//çeyrek pencerenin sağ alt noktası (72;18)

CONST UPKEY = #72;
		DOWNKEY = #80;
		LEFTKEY = #75;
		RIGHTKEY = #77;
		ESCKEY = #27;
		SPACEKEY = #32;
		ENTERKEY = #13;
		STATBG = Black;
		STATTXT = White;
		AVTBG = Black; //when not choosen
		AVTTXT = White;
		ACTBG = Black; //when not choosen
		ACTTXT = White;


Type TKey = (esc, up, down, right, left, space, enter, rien);
Type TPosKey = (avat, nour, dorm, jour, nul);
Type TCoordinate = record
	avat : Byte;
	stat : Byte;
	acti : Byte;
	main : Byte;
end;

Type TTgchiplaceholder = record
	fatigue : Byte; //0-100
	faim : Byte; 	//0-100
	bonheur : byte; //0-100
	nom : string;
end;

procedure input(var key : TKey; var changed : Boolean);
var ch : char;
begin
	if keypressed then
	begin
	changed:=True;
		ch:=readkey; //ch=#0 if not
		if ch=#0 then
			ch:=readkey; //a second readkey to get the actual key code 
		case ch of 
			upkey : key:=up;
			downkey : key:=down;
			rightkey : key:=right;
			leftkey : key:=left;
			esckey : key:=esc;
			spacekey : key:=space;
			enterkey : key:=enter;
		end;
	end
end;

procedure afficheAvatar(x, y : Byte);
begin
	textbackground(AVTBG);
	textcolor(AVTTXT);
	window(x, y,x+24,y+7);
	writeln('/======================\');
	writeln('|   ,_,                |');
	writeln('|  (0_0)_----------_   |');
	writeln('| (_____)           |~ |');
	writeln('| `-"-"-            /  |');
	writeln('|   `|__|~-----~|__|   |');
	writeln('\======================/');
end;

procedure afficheStats(x, y : Byte);
begin
	window(x, y, x+16, y+5);
	textbackground(STATBG);
	textcolor(STATTXT);
	writeln('@--------------@');
	writeln('|              |');
	writeln('|              |');
	writeln('|              |');
	writeln('@--------------@');
	window(x+1,y+1, x+15, y+4);
	writeln('Faim    : ___ ');
	writeln('Fatigue : ___ ');
	writeln('Bonheur : ___ ');
end;

procedure afficheModifStats(x, y : Byte; tgchi : TTgchiplaceholder);
begin
	textbackground(STATBG);
	textcolor(STATTXT);
	gotoxy(x+11,y+1);
	if tgchi.faim<100 then
		write(' ');
	if tgchi.faim<10 then
		write(' ');
	write(tgchi.faim);
	gotoxy(x+11,y+2);
	if tgchi.fatigue<100 then
		write(' ');
	if tgchi.fatigue<10 then
		write(' ');
	write(tgchi.fatigue);
	gotoxy(x+11,y+3);
	if tgchi.bonheur<100 then
		write(' ');
	if tgchi.bonheur<10 then
		write(' ');
	write(tgchi.bonheur);
end;

procedure afficheActions(x, y : Byte);
begin
	textbackground(ACTBG);
	textcolor(ACTTXT);
	window(x, y, x+12, y+5);
	writeln('@----------@');
	writeln('|  Nourrir |');
	writeln('|  Jouer   |');
	writeln('|  Dormir  |');
	writeln('@----------@');
end;

procedure afficheChoix(poskey : TPoskey; x, y : TCoordinate);
begin
	case poskey of
	nour : begin
			gotoxy(x.acti+1,y.acti+1);
			write('  Nourrir ');
		end;
	jour : begin
			gotoxy(x.acti+1,y.acti+2);
			write('  Jouer   ');
		end;
	dorm : begin
			gotoxy(x.acti+1,y.acti+3);
			write('  Dormir  ');
		end;
	avat : begin
			window(x.avat, y.avat,x.avat+24,y.avat+7);
			writeln('/======================\');
			writeln('|   ,_,                |');
			writeln('|  (0_0)_----------_   |');
			writeln('| (_____)           |~ |');
			writeln('| `-"-"-            /  |');
			writeln('|   `|__|~-----~|__|   |');
			writeln('\======================/');
			window(1,1,x.main,y.main);
		end;
	end;
end;

procedure faireChoix(var key : TKey; var poskey : TposKey; x, y : TCoordinate; var changed : Boolean);
begin
	textbackground(black);
	textcolor(white);
	afficheChoix(poskey, x, y);
	if key=left then
		poskey:=avat;
	if (key=right) and (poskey=nul) then
		poskey:=nour;
	if (key=right) and (poskey=avat) then
		poskey:=nour;
	if (key=up) and (poskey=jour) then
		poskey:=nour;
	if (key=up) and (poskey=dorm) then
		poskey:=jour;
	if (key=down) and (poskey=jour) then
		poskey:=dorm;
	if (key=down) and (poskey=nour) then
		poskey:=jour;
	if key<>esc then
		key:=rien;
	textbackground(yellow);
	textcolor(black);
	afficheChoix(poskey, x, y);
	changed:=False;
end;

var key : TKey;	poskey : TPoskey;
	x, y : TCoordinate; 
	tgchi : TTgchiplaceholder;
	changed : Boolean;
begin
	x.main:=windmaxx; 	y.main:=windmaxy;
	x.avat:=windmaxx*10 div 72;	y.avat:=windmaxy*6 div 18; //avatar penceresinin sol üst noktası (10,6)
	x.stat:=windmaxx*41 div 72; y.stat:=windmaxy*4 div 18; //stat penceresinin sol üst noktası (41,4)
	x.acti:=windmaxx*41 div 72; y.acti:=windmaxy*10 div 18; //action penceresinin sol üst noktası (41, 10)
	key:=rien;	poskey:=nul; changed:=False;
	tgchi.faim:=100;
	tgchi.bonheur:=100;
	tgchi.fatigue:=100;
	
	clrscr();
	cursoroff();
	afficheAvatar(x.avat, y.avat);
	afficheStats(x.stat, y.stat);
	afficheActions(x.acti, y.acti);
	textbackground(black); //temizlenecek
	textcolor(white);
	window(1,1,x.main,y.main);
	repeat
		delay(200);
		input(key, changed);
		if changed then
			faireChoix(key, poskey, x, y, changed);
		gotoxy(1,1);
		clreol();
		write(key, ' / ', poskey,' KEYPRESSED : ', keypressed);
		textbackground(black);
		textcolor(white);
		window(1,1,x.main,y.main); //temizlenecek
		afficheModifStats(x.stat, y.stat, tgchi);
		if tgchi.faim>0 then	//temizlenecek
			Dec(tgchi.faim);
	until key=esc;
	cursoron();
	gotoxy(1,16);
end.
