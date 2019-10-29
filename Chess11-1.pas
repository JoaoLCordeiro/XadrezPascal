program Chess;
type
	t_tab=array[1..8,1..8] of integer;
	
var
	tab:t_tab;
	cpassant,l,c,lj,cj,lreiB,creiB,lreiP,creiP,f:integer;
	continuajogo,fezpassant,enpassant,resultacheck,chooserook,jogada_valida,peca_valida,mudateam,sameteam,g_valida,eh_bizar,eh_rook,eh_help,rookQB,rookRB,rookQP,rookRP,rookReiB,rookReiP,rook1,rook2,rook3,rook4,checkhouse:boolean;

procedure build_tab(var tab:t_tab);
var	l,c:integer;
begin
//1=peao_b,2=torre_b,3=cavalo_b,4=bispo_b,5=rainha_b,6=rei_b,0=nada;
//7=peao_p,8=torre_p,9=cavalo_p,10=bispo_p,11=rainha_p,12=rei_p;
	l:=1;
	c:=1;
	for l:=1 to 8 do
	begin
		for c:=1 to 8 do
		begin
			if ((l=1) and (c=1)) or ((l=1) and (c=8)) then
				tab[l,c]:=2
			else
			if ((l=1) and (c=2)) or ((l=1) and (c=7)) then
				tab[l,c]:=3
			else
			if ((l=1) and (c=3)) or ((l=1) and (c=6)) then
				tab[l,c]:=4
			else
			if ((l=1) and (c=5)) then
				tab[l,c]:=5
			else
			if ((l=1) and (c=4)) then
				tab[l,c]:=6
			else
			if (l=2) then
				tab[l,c]:=1
			else
			if (l=7) then
				tab[l,c]:=7
			else
			if ((l=8) and (c=1)) or ((l=8) and (c=8)) then
				tab[l,c]:=8
			else
			if ((l=8) and (c=2)) or ((l=8) and (c=7)) then
				tab[l,c]:=9
			else
			if ((l=8) and (c=3)) or ((l=8) and (c=6)) then
				tab[l,c]:=10
			else
			if ((l=8) and (c=5)) then
				tab[l,c]:=11
			else
			if ((l=8) and (c=4)) then
				tab[l,c]:=12
			else
				tab[l,c]:=0;
		end;
	end;
end;

procedure write_tab(tab:t_tab);
var l,c:integer;
//1=peao_b,2=torre_b,3=cavalo_b,4=bispo_b,5=rainha_b,6=rei_b,0=nada;
//7=peao_p,8=torre_p,9=cavalo_p,10=bispo_p,11=rainha_p,12=rei_p;
begin
	l:=1;
	c:=1;
	writeln('0 1 2 3 4 5 6 7 8');
	while (l<=8) do
	begin
		write(l,' ');
		while (c<=8) do
		begin
		if c<8 then
		begin
		if tab[l,c]=1 then
			write ('p ')
		else
		if tab[l,c]=2 then
			write ('t ')
		else
		if tab[l,c]=3 then
			write ('c ')
		else
		if tab[l,c]=4 then
			write ('b ')
		else
		if tab[l,c]=5 then
			write ('q ')
		else
		if tab[l,c]=6 then
			write ('r ')
		else
		if tab[l,c]=7 then
			write ('P ')
		else
		if tab[l,c]=8 then
			write ('T ')
		else
		if tab[l,c]=9 then
			write ('C ')
		else
		if tab[l,c]=10 then
			write ('B ')
		else
		if tab[l,c]=11 then
			write ('Q ')
		else
		if tab[l,c]=12 then
			write ('R ')
		else
			write ('0 ');
		end;
		if c=8 then
		begin
		if tab[l,c]=1 then
			writeln ('p ')
		else
		if tab[l,c]=2 then
			writeln ('t ')
		else
		if tab[l,c]=3 then
			writeln ('c ')
		else
		if tab[l,c]=4 then
			writeln ('b ')
		else
		if tab[l,c]=5 then
			writeln ('q ')
		else
		if tab[l,c]=6 then
			writeln ('r ')
		else
		if tab[l,c]=7 then
			writeln ('P ')
		else
		if tab[l,c]=8 then
			writeln ('T ')
		else
		if tab[l,c]=9 then
			writeln ('C ')
		else
		if tab[l,c]=10 then
			writeln ('B ')
		else
		if tab[l,c]=11 then
			writeln ('Q ')
		else
		if tab[l,c]=12 then
			writeln ('R ')
		else
			writeln ('0 ');
		end;
		c:=c+1;
		end;
	l:=l+1;
	c:=1;
	end;
end;

procedure Choose_Piece(var tab:t_tab;var l,c:integer;var peca_valida:boolean);
begin
	peca_valida:=true;
	writeln ('Escolha sua peca');
	read(l,c);
	if (l>8)or(c>8)or(l<1)or(c<1) then
		peca_valida:=false;
	if tab[l,c]=0 then
		peca_valida:=false;
	if (tab[l,c]>6) and mudateam then
		peca_valida:=false;
	if (tab[l,c]<7) and (not mudateam) then
		peca_valida:=false;
end;

procedure Identify_Jogada(var l,c,lj,cj,cpassant:integer;var tab:t_tab;var jogada_valida,enpassant:boolean);
var 
	cont:integer;
begin
	jogada_valida:=false;
	//Encontrar jogadas de Peao Branco(1);
	if tab[l,c]=1 then
	begin
		if l=2 then
		begin
			if ((lj=l+1)and(cj=c))or((lj=l+2)and(cj=c))or((lj=l+1)and(cj=c-1)and(tab[(l+1),(c-1)]<>0))or((lj=l+1)and(cj=c+1)and(tab[(l+1),(c+1)]<>0)) then
			begin
				jogada_valida:=true;
				if ((lj=l+2)and(cj=c)) then
				begin
					enpassant:=true;
					cpassant:=cj;
				end;
			end;
		end
		else
		begin
			if ((lj=l+1)and(cj=c))or((lj=l+1)and(cj=c-1)and(tab[(l+1),(c-1)]<>0))or((lj=l+1)and(cj=c+1)and(tab[(l+1),(c+1)]<>0)) then
				jogada_valida:=true;
		end;
	end;
	//Encontrar jogadas de Peao Negro(7);
	if tab[l,c]=7 then
	begin
		if l=7 then
		begin
			if ((lj=l-1)and(cj=c))or((lj=l-2)and(cj=c))or((lj=l-1)and(cj=c-1)and(tab[(l-1),(c-1)]<>0))or((lj=l-1)and(cj=c+1)and(tab[(l-1),(c+1)]<>0)) then
			begin
				jogada_valida:=true;
				if ((lj=l-2)and(cj=c)) then
				begin
					enpassant:=true;
					cpassant:=cj;
				end;
			end;
		end
		else
		begin
			if ((lj=l-1)and(cj=c))or((lj=l-1)and(cj=c-1)and(tab[(l-1),(c-1)]<>0))or((lj=l-1)and(cj=c+1)and(tab[(l-1),(c+1)]<>0)) then
				jogada_valida:=true;
		end;
	end;
	//Encontrar jogadas de Torre Branca ou Negra (2 ou 8);
	if (tab[l,c]=2)or(tab[l,c]=8) then
	begin
		if ((lj<>l)and(cj=c))or((lj=l)and(cj<>c)) then
			jogada_valida:=true;
	end;
	//Encontrar jogadas de Cavalo Branco ou Negro (3 ou 9);
	if (tab[l,c]=3)or(tab[l,c]=9) then
	begin
		if((lj=l+2)and((cj=c-1)or(cj=c+1)))or((lj=l+1)and((cj=c-2)or(cj=c+2)))or((lj=l-2) and((cj=c-1)or(cj=c+1)))or((lj=l-1)and((cj=c-2)or(cj=c+2))) then
			jogada_valida:=true;
	end;
	//Encontrar jogadas de Bispo Branco ou Negro(4 ou 10);
	if (tab[l,c]=4)or(tab[l,c]=10) then
	begin
	cont:=1;
	while (cont<=8)and(not jogada_valida) do
	begin
		if ((lj=l+cont)and((cj=c+cont)or(cj=c-cont))) or ((lj=l-cont)and((cj=c+cont)or(cj=c-cont))) then
		jogada_valida:=true;
	cont:=cont+1;
	end;
	end;
	//Encontrar jogadas de Dama Branca ou Negra(5 ou 11);
	if (tab[l,c]=5)or(tab[l,c]=11) then
	begin
		if ((lj<>l)and(cj=c))or((lj=l)and(cj<>c)) then
			jogada_valida:=true;
		cont:=1;
		while (cont<=8)and(not jogada_valida) do
		begin
			if ((lj=l+cont)and((cj=c+cont)or(cj=c-cont))) or ((lj=l-cont)and((cj=c+cont)or(cj=c-cont))) then
			jogada_valida:=true;
		cont:=cont+1;
		end;
	end;
	//Encontrar jogadas de Rei Branco ou Negro(6 ou 12);
	if (tab[l,c]=6)or(tab[l,c]=12) then
	begin
		if ((lj<=(l+1))or(lj>=(l-1)))and((cj<=(c+1))or(cj>=(c-1)))and((lj<>l)and(cj<>c)) then
			jogada_valida:=true;
	end;
end;

procedure Identify_Geral(var lj,cj:integer;var g_valida,eh_rook,eh_bizar,eh_help:boolean);
//Identifica se a jogada esta no tabuleiro, ou eh rook, ou eh bizar, ou eh duvida;
begin
	g_valida:=false;
	eh_rook:=false;
	eh_bizar:=false;
	eh_help:=false;
	if (lj<=8)and(cj<=8)and(lj>=1)and(cj>=1) then
		g_valida:=true;
	if (lj=9)and(cj=9) then
		eh_rook:=true;
	if (lj=10)and(cj=10) then
		eh_bizar:=true;
	if (lj=11)and(cj=11) then
		eh_help:=true;
end;

procedure Imprimir_Ajuda(var eh_help:boolean);
//Acho que ta bem claro o que isso aqui faz, neh?;
begin
	if eh_help then
	begin
		writeln('Para realizar um Roque, digite 9 9');
		writeln('Para realizar um en passant, digite 10 10');
		writeln('Para qualquer outra jogada comum, digite a coordenada desejada');
	end;
end;

procedure Testar_Rook_Mov(var rookRB,rookQB,rookRP,rookQP,rookReiB,rookReiP:boolean;var tab:t_tab);
//Testa toda rodada se as torres e os reis se mecheram;
begin
	if tab[1,1]<>2 then
		rookRB:=false;
	if tab[1,8]<>2 then
		rookQB:=false;
	if tab[8,1]<>8 then
		rookRP:=false;
	if tab[8,8]<>8 then
		rookQP:=false;
	if tab[1,4]<>6 then
		rookReiB:=false;
	if tab[8,4]<>12 then
		rookReiP:=false;
end;

procedure Change_Pieces(var l,c,lj,cj:integer;var tab:t_tab);
var aux:integer;
begin//Troca a peca de lugar e poe nada onde ela estava;
		aux:=tab[l,c];
		tab[lj,cj]:=aux;
		tab[l,c]:=0;
end;

procedure Identify_Team(var lj,cj:integer;var tab:t_tab;var mudavez,sameteam:boolean);
begin	//Identifica se a jogada cai em uma peca do mesmo time;
	sameteam:=false;
	if (tab[lj,cj]<7)and(tab[lj,cj]<>0)and mudavez then
		sameteam:=true;
	if (tab[lj,cj]>6) and not mudavez then
		sameteam:=true;
end;

procedure Testa_Rook_Pecas(var rook1,rook2,rook3,rook4:boolean;var tab:t_tab);
begin //Testa se tem pecas no caminho dos rooks;
	rook1:=false;
	rook2:=false;
	rook3:=false;
	rook4:=false;
	if (tab[1,2]=0)and(tab[1,3]=0) then
	rook1:=true;
	if (tab[1,5]=0)and(tab[1,6]=0)and(tab[1,7]=0) then
	rook2:=true;
	if (tab[8,2]=0)and(tab[8,3]=0) then
	rook3:=true;
	if (tab[8,5]=0)and(tab[8,6]=0)and(tab[8,7]=0) then
	rook4:=true;
end;		

procedure Choose_Rook(var rookRB,rookQB,rookRP,rookQP,rookReiB,rookReiQ,mudateam,chooserook:boolean);
var c:integer;
begin//Escolhe o rook desejado;
	writeln('Qual roque deseja realizar?Os disponiveis sao:');
	if mudateam then
	begin
		if (rookRB)and(rookReiB)and(rook1) then
		writeln('Roque curto (digite 0)');
		if (rookQB)and(rookReiB)and(rook2) then
		writeln('Roque longo (digite 1)');
		if not(((rookRB)and(rookReiB)and(rook1))or((rookQB)and(rookReiB)and(rook2))) then
		writeln('Nenhum esta :(')
		else
		begin
			read(c);
			if c=0 then
				chooserook:=false;
			if c=1 then
				chooserook:=true;
		end;
	end;
	if not mudateam then
	begin
		if (rookRP)and(rookReiP)and(rook3) then
		writeln('Roque curto (digite 0)');
		if (rookQP)and(rookReiP)and(rook4) then
		writeln('Roque longo (digite 1)');
		if not(((rookRP)and(rookReiP)and(rook3))or((rookQP)and(rookReiP)and(rook4))) then
		writeln('Nenhum esta :(')
		else
		begin
			read(c);
			if c=0 then
				chooserook:=false;
			if c=1 then
				chooserook:=true;
		end;
	end;
end;

procedure Faz_Rook(var tab:t_tab;var rookRB,rookQB,rookRP,rookQP,rookReiB,rookReiP,rook1,rook2,rook3,rook4,mudateam,chooserook:boolean; var lreiB,creiB,lreiP,creiP:integer);
begin
	if (rookRB)and(rookReiB)and(rook1)and(mudateam)and(not chooserook) then
	begin
		tab[1,1]:=0;
		tab[1,2]:=6;
		tab[1,3]:=2;
		tab[1,4]:=0;
		lreiB:=1;
		creiB:=2;
		mudateam:= not mudateam;
	end;
	if (rookQB)and(rookReiB)and(rook2)and(mudateam)and(chooserook) then
	begin
		tab[1,4]:=0;
		tab[1,5]:=2;
		tab[1,6]:=6;
		tab[1,7]:=0;
		tab[1,8]:=0;
		lreiB:=1;
		creiB:=6;
		mudateam:= not mudateam;
	end;
	if (rookRP)and(rookReiP)and(rook3)and(not mudateam)and(not chooserook) then
	begin
		tab[8,1]:=0;
		tab[8,2]:=12;
		tab[8,3]:=8;
		tab[8,4]:=0;
		lreiP:=8;
		creiP:=2;
		mudateam:= not mudateam;
	end;
	if (rookQP)and(rookReiP)and(rook4)and(not mudateam)and(chooserook) then
	begin
		tab[8,4]:=0;
		tab[8,5]:=8;
		tab[8,6]:=12;
		tab[8,7]:=0;
		tab[8,8]:=0;
		lreiB:=8;
		creiP:=6;
		mudateam:= not mudateam;
	end;
end;

procedure Check_Check_Brancas(lc,cc:integer;var tab:t_tab;var checkhouse:boolean);
var cont:integer;
begin//Checa se uma casa esta em check(em perigo por alguma peca);
	checkhouse:=false;
	if ((lc+1)<9) then
	begin
		if ((cc+2)<9) then
		begin
			if (tab[(lc+1),(cc+2)]=9) then
			checkhouse:=true;
		end;
		if ((cc-2)>0) then
		begin
			if (tab[(lc+1),(cc-2)]=9) then
			checkhouse:=true;//Testa a 1 parte do cavalo;
		end;
	end;
	if ((lc-1)>0) then
	begin
		if ((cc+2)<9) then
		begin
			if (tab[(lc-1),(cc+2)]=9) then
			checkhouse:=true;
		end;
		if ((cc-2)>0) then
		begin
			if (tab[(lc-1),(cc-2)]=9) then
			checkhouse:=true;//Testa a 2 parte do cavalo;
		end;
	end;
	if ((lc+2)<9) then
	begin
		if ((cc+1)<9) then
		begin
			if (tab[(lc+2),(cc+1)]=9) then
			checkhouse:=true;
		end;
		if ((cc-1)>0) then
		begin
			if (tab[(lc+2),(cc-1)]=9) then
			checkhouse:=true;//Testa a 3 parte do cavalo;
		end;
	end;
	if ((lc-2)<9) then
	begin
		if ((cc+1)<9) then
		begin
			if (tab[(lc-2),(cc+1)]=9) then
			checkhouse:=true;
		end;
		if ((cc-1)>0) then
		begin
			if (tab[(lc-2),(cc-1)]=9) then
			checkhouse:=true;//Testa a 4 parte do cavalo;
		end;
	end;
	if ((not checkhouse) and ((lc+1)<9)) then
	begin
		if ((cc-1)>0) then
		begin
			if (tab[lc+1,cc-1]=7) then
				checkhouse:=true;
		end;
		if ((cc+1)<9) then
		begin
			if (tab[lc+1,cc+1]=7) then
				checkhouse:=true;//Testou peao;
		end;
	end;
	if (not checkhouse) then
	begin
		if ((lc-1)>0) then
		begin
			if ((cc-1)>0) then
			begin				
				if (tab[lc-1,cc-1]=12)or(tab[lc-1,cc]=12)or(tab[lc,cc-1]=12) then
					checkhouse:=true;
			end;
			if ((cc+1)<9) then
			begin				
				if (tab[lc-1,cc+1]=12)or(tab[lc-1,cc]=12)or(tab[lc,cc+1]=12) then
					checkhouse:=true;
			end;
		end;
		if ((lc-1)>0) then
		begin
			if ((cc-1)>0) then
			begin				
				if (tab[lc+1,cc-1]=12)or(tab[lc+1,cc]=12)or(tab[lc,cc-1]=12) then
					checkhouse:=true;
			end;
			if ((cc+1)<9) then
			begin				
				if (tab[lc+1,cc+1]=12)or(tab[lc+1,cc]=12)or(tab[lc,cc+1]=12) then
					checkhouse:=true;
			end;
		end;//Testou rei;
	end;
	if (not checkhouse) then
	begin
	cont:=1;
	while (((lc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[(lc-cont),cc]=8)or(tab[(lc-cont),cc]=11)) then
				checkhouse:=true;
			if (tab[(lc-cont),cc]<>0) then
				cont:=8;//Testa torres e parte da dama;
			cont:=cont+1;
		end;
	cont:=1;
	while (((lc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[(lc+cont),cc]=8)or(tab[(lc+cont),cc]=11)) then
				checkhouse:=true;
			if (tab[(lc+cont),cc]<>0) then
				cont:=8;
			cont:=cont+1;
		end;
	cont:=1;
	while (((cc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[lc,(cc-cont)]=8)or(tab[lc,(cc-cont)]=11)) then
				checkhouse:=true;
			if (tab[lc,(cc-cont)]<>0) then
				cont:=8;
			cont:=cont+1;
		end;
	cont:=1;
	while (((cc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[lc,(cc+cont)]=8)or(tab[lc,(cc+cont)]=11)) then
				checkhouse:=true;
			if (tab[lc,(cc+cont)]<>0) then
				cont:=8;
			cont:=cont+1;
		end;
	end;
	if (not checkhouse) then
	begin
	cont:=1;
	while (((lc-cont)>0)and((cc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[(lc-cont),(cc-cont)]=11)or(tab[(lc-cont),(cc-cont)]=10)) then
				checkhouse:=true;//Testa bispos e parte da dama;
			if (tab[(lc-cont),(cc-cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	cont:=1;
	while (((lc+cont)<9)and((cc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[(lc+cont),(cc-cont)]=11)or(tab[(lc+cont),(cc-cont)]=10)) then
				checkhouse:=true;
			if (tab[(lc+cont),(cc-cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	cont:=1;
	while (((lc-cont)>0)and((cc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[(lc-cont),(cc+cont)]=11)or(tab[(lc-cont),(cc+cont)]=10)) then
				checkhouse:=true;
			if (tab[(lc-cont),(cc+cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	cont:=1;
	while (((lc+cont)<9)and((cc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[(lc+cont),(cc+cont)]=11)or(tab[(lc+cont),(cc+cont)]=10)) then
				checkhouse:=true;
			if (tab[(lc+cont),(cc+cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	end;
			
end;

procedure Check_Check_Negras(lc,cc:integer;var tab:t_tab;var checkhouse:boolean);
var cont:integer;
begin//Checa se uma casa esta em check(em perigo por alguma peca);
	checkhouse:=false;
	if ((lc+1)<9) then
	begin
		if ((cc+2)<9) then
		begin
			if (tab[(lc+1),(cc+2)]=3) then
			checkhouse:=true;
		end;
		if ((cc-2)>0) then
		begin
			if (tab[(lc+1),(cc-2)]=3) then
			checkhouse:=true;//Testa a 1 parte do cavalo;
		end;
	end;
	if ((lc-1)>0) then
	begin
		if ((cc+2)<9) then
		begin
			if (tab[(lc-1),(cc+2)]=3) then
			checkhouse:=true;
		end;
		if ((cc-2)>0) then
		begin
			if (tab[(lc-1),(cc-2)]=3) then
			checkhouse:=true;//Testa a 2 parte do cavalo;
		end;
	end;
	if ((lc+2)<9) then
	begin
		if ((cc+1)<9) then
		begin
			if (tab[(lc+2),(cc+1)]=3) then
			checkhouse:=true;
		end;
		if ((cc-1)>0) then
		begin
			if (tab[(lc+2),(cc-1)]=3) then
			checkhouse:=true;//Testa a 3 parte do cavalo;
		end;
	end;
	if ((lc-2)<9) then
	begin
		if ((cc+1)<9) then
		begin
			if (tab[(lc-2),(cc+1)]=3) then
			checkhouse:=true;
		end;
		if ((cc-1)>0) then
		begin
			if (tab[(lc-2),(cc-1)]=3) then
			checkhouse:=true;//Testa a 4 parte do cavalo;
		end;
	end;
	if ((not checkhouse) and ((lc-1)>0)) then
	begin
		if ((cc-1)>0) then
		begin
			if (tab[lc-1,cc-1]=1) then
				checkhouse:=true;
		end;
		if ((cc+1)<9) then
		begin
			if (tab[lc-1,cc+1]=1) then
				checkhouse:=true;//Testou peao;
		end;
	end;
	if (not checkhouse) then
	begin
		if ((lc-1)>0) then
		begin
			if ((cc-1)>0) then
			begin				
				if (tab[lc-1,cc-1]=6)or(tab[lc-1,cc]=6)or(tab[lc,cc-1]=6) then
					checkhouse:=true;
			end;
			if ((cc+1)<9) then
			begin				
				if (tab[lc-1,cc+1]=6)or(tab[lc-1,cc]=6)or(tab[lc,cc+1]=6) then
					checkhouse:=true;
			end;
		end;
		if ((lc-1)>0) then
		begin
			if ((cc-1)>0) then
			begin				
				if (tab[lc+1,cc-1]=6)or(tab[lc+1,cc]=6)or(tab[lc,cc-1]=6) then
					checkhouse:=true;
			end;
			if ((cc+1)<9) then
			begin				
				if (tab[lc+1,cc+1]=6)or(tab[lc+1,cc]=6)or(tab[lc,cc+1]=6) then
					checkhouse:=true;
			end;//Testou rei;
		end;
	end;
	if (not checkhouse) then
	begin
	cont:=1;
	while (((lc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[(lc-cont),cc]=2)or(tab[(lc-cont),cc]=5)) then
			begin
				checkhouse:=true;
			end;
			if (tab[(lc-cont),cc]<>0) then
				cont:=8;//Testa torres e parte da dama;
			cont:=cont+1;
		end;
	cont:=1;
	while (((lc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[(lc+cont),cc]=2)or(tab[(lc+cont),cc]=5)) then
			begin
				checkhouse:=true;
			end;
			if (tab[(lc+cont),cc]<>0) then
				cont:=8;
			cont:=cont+1;
		end;
	cont:=1;
	while (((cc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[lc,(cc-cont)]=2)or(tab[lc,(cc-cont)]=5)) then
			begin
				checkhouse:=true;
			end;
			if (tab[lc,(cc-cont)]<>0) then
				cont:=8;
			cont:=cont+1;
		end;
	cont:=1;
	while (((cc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[lc,(cc+cont)]=2)or(tab[lc,(cc+cont)]=5)) then
			begin
				checkhouse:=true;
			end;
			if (tab[lc,(cc+cont)]<>0) then
				cont:=8;
			cont:=cont+1;
		end;
	end;
	if (not checkhouse) then
	begin
	cont:=1;
	while (((lc-cont)>0)and((cc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[(lc-cont),(cc-cont)]=5)or(tab[(lc-cont),(cc-cont)]=4)) then
			begin
				checkhouse:=true;//Testa bispos e parte da dama;
			end;
			if (tab[(lc-cont),(cc-cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	cont:=1;
	while (((lc+cont)<9)and((cc-cont)>0)and(not checkhouse)) do
		begin
			if ((tab[(lc+cont),(cc-cont)]=5)or(tab[(lc+cont),(cc-cont)]=4)) then
			begin
				checkhouse:=true;
			end;
			if (tab[(lc+cont),(cc-cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	cont:=1;
	while (((lc-cont)>0)and((cc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[(lc-cont),(cc+cont)]=5)or(tab[(lc-cont),(cc+cont)]=4)) then
			begin
				checkhouse:=true;
			end;
			if (tab[(lc-cont),(cc+cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	cont:=1;
	while (((lc+cont)<9)and((cc+cont)<9)and(not checkhouse)) do
		begin
			if ((tab[(lc+cont),(cc+cont)]=5)or(tab[(lc+cont),(cc+cont)]=4)) then
			begin
				checkhouse:=true;
			end;
			if (tab[(lc+cont),(cc+cont)]<>0) then
				cont:=8;
		cont:=cont+1;
		end;
	end;
end;

procedure Testa_Rook_Alvo(var tab:t_tab;var checkhouse,rook1,rook2,rook3,rook4:boolean);
var lin,col:integer;
begin
	if rook1 then//Testa o rook curto das brancas;
	begin
		rook1:=false;
		lin:=1;
		col:=2;
		Check_Check_Brancas(lin,col,tab,checkhouse);
		if not checkhouse then
		begin
			col:=3;
			Check_Check_Brancas(lin,col,tab,checkhouse);
			rook1:= not checkhouse;
		end;
	end;
	if rook2 then//Testa o rook longo das brancas;
	begin
		rook2:=false;
		lin:=1;
		col:=5;
		Check_Check_Brancas(lin,col,tab,checkhouse);
		if not checkhouse then
		begin
			col:=6;
			Check_Check_Brancas(lin,col,tab,checkhouse);
			if not checkhouse then
			begin
				col:=7;
				Check_Check_Brancas(lin,col,tab,checkhouse);
				rook2:= not checkhouse;
			end;
		end;
	end;
	if rook3 then//Testa o rook curto das negras;
	begin
		rook3:=false;
		lin:=8;
		col:=2;
		Check_Check_Negras(lin,col,tab,checkhouse);
		if not checkhouse then
		begin
			col:=3;
			Check_Check_Negras(lin,col,tab,checkhouse);
			rook3:= not checkhouse;
		end;
	end;
	if rook4 then//Testa o rook longo das negras;
	begin
		rook4:=false;
		lin:=8;
		col:=5;
		Check_Check_Negras(lin,col,tab,checkhouse);
		if not checkhouse then
		begin
			col:=6;
			Check_Check_Negras(lin,col,tab,checkhouse);
			if not checkhouse then
			begin
				col:=7;
				Check_Check_Negras(lin,col,tab,checkhouse);
				rook4:= not checkhouse;
			end;
		end;
	end;
end;

procedure Resulta_Check(tab:t_tab;var l,c,lj,cj,lreiB,creiB,lreiP,creiP:integer;var mudateam,resultacheck:boolean);
begin
	resultacheck:=false;
	tab[lj,cj]:=tab[l,c];
	tab[l,c]:=0;
	if (tab[lj,cj]=6) or (tab[lj,cj]=12) then
	begin
		if mudateam then
		begin
			lreiB:=lj;
			creiB:=cj;
		end;
		if not mudateam then
		begin
			lreiP:=lj;
			creiP:=cj;
		end;
	end;
	if not mudateam then
		Check_Check_Negras(lreiP,creiP,tab,resultacheck);
	if mudateam then
		Check_Check_Brancas(lreiB,creiB,tab,resultacheck);
end;

procedure En_Passant_Negras(var l,c,lj,cj,cpassant:integer;var tab:t_tab;var fezpassant,enpassant:boolean);
begin
	if enpassant then
	begin
		fezpassant:=false;
		writeln('Qual peca voce vai usar?');
		read(l,c);
		if (l=4) and (tab[l,c]=7)then
		begin
			writeln('Para onde voce quer levar esta peca?');
			read(lj,cj);
			if cj=cpassant then
			begin
				tab[lj+1,cj]:=0;
				tab[lj,cj]:=tab[l,c];
				tab[l,c]:=0;
				fezpassant:=true;
			end;
		end;
	end;
end;

procedure En_Passant_Brancas(l,c,lj,cj:integer;var cpassant:integer;var tab:t_tab;var fezpassant,enpassant:boolean);
begin
	if enpassant then
	begin
		fezpassant:=false;
		writeln('Qual peca voce vai usar?');
		read(l,c);
		if ((l=5)and(tab[l,c]=1))then
		begin
			writeln('Para onde voce quer levar esta peca?');
			read(lj,cj);
			if cj=cpassant then
			begin
				tab[lj-1,cj]:=0;
				tab[lj,cj]:=tab[l,c];
				tab[l,c]:=0;
				fezpassant:=true;
			end;
		end;
	end;
end;

begin
	build_tab(tab);
	write_tab(tab);
	lreiB:=1;
	creiB:=4;
	lreiP:=8;
	creiP:=4;
	rookRB:=true;
	rookQB:=true;
	rookRP:=true;
	rookQP:=true;
	rookReiB:=true;
	rookReiP:=true;
	mudateam:=true;	//Comeca a partida com as brancas;
	continuajogo:=true;
	while continuajogo do
	begin
	Choose_Piece(tab,l,c,peca_valida);//Escolhe a peca e identifica se ela eh do time certo;
	if peca_valida then
	begin
		Testar_Rook_Mov(rookRB,rookQB,rookRP,rookQP,rookReiB,rookReiP,tab);//Testa movimentos de Torres e Reis, para que o Rook possa ser feito;
		writeln('Como sera sua jogada?');
		writeln('Para ajuda, digite 11 11');
		read(lj,cj);
		Identify_Geral(lj,cj,g_valida,eh_rook,eh_bizar,eh_help);//Identifica se a jogada esta dentro do tabuleiro e qual tipo de jogada eh;
		Imprimir_Ajuda(eh_help);
		if eh_rook then
		begin	//AQUI VAI FICAR A SEQUENCIA DO ROOK;
			Testa_Rook_Pecas(rook1,rook2,rook3,rook4,tab);
			Testa_Rook_Alvo(tab,checkhouse,rook1,rook2,rook3,rook4);		Choose_Rook(rookRB,rookQB,rookRP,rookQP,rookReiB,rookReiP,mudateam,chooserook);
Faz_Rook(tab,rookRB,rookQB,rookRP,rookQP,rookReiB,rookReiP,rook1,rook2,rook3,rook4,mudateam,chooserook,lreiB,creiB,lreiP,creiP);
		end;
		if eh_bizar then
		begin	//AQUI VAI FICAR A SEQUENCIA DO EN PASSANT;
			if not mudateam then
				En_Passant_Negras(l,c,lj,cj,cpassant,tab,fezpassant,enpassant);
			if mudateam then
				En_Passant_Brancas(l,c,lj,cj,cpassant,tab,fezpassant,enpassant);
			if fezpassant then
				mudateam:= not mudateam;
		end;
		enpassant:=false;
		cpassant:=0;
		if g_valida then
		begin	//AQUI VAI FICAR A SEQUENCIA GERAL;
			Identify_Jogada(l,c,lj,cj,cpassant,tab,jogada_valida,enpassant);//Verifica se a casa esta entre os movimentos da peca;
			if jogada_valida then
			begin
				Identify_Team(lj,cj,tab,mudateam,sameteam);//Verifica se a casa possui uma peca do mesmo time;
				if not sameteam then
				begin
					Resulta_Check(tab,l,c,lj,cj,lreiB,creiB,lreiP,creiP,mudateam,resultacheck);
					if not resultacheck then
					begin
						if (tab[l,c]=6) or (tab[l,c]=12) then
						begin//Isso muda a linha e coluna dos reis, caso sejam movidos;
							if mudateam then
							begin
								lreiB:=lj;
								creiB:=cj;
							end;
							if not mudateam then
							begin
								lreiP:=lj;
								creiP:=cj;
							end;
						end;
						Change_Pieces(l,c,lj,cj,tab);//Poe a peca no lugar;
						if ((lj=8)and(tab[lj,cj]=1)) or ((lj=1)and(tab[lj,cj]=7)) then
						begin
							if mudateam then
							begin
							writeln('Para qual peca deseja promover?');
							writeln('2=peao 3=cavalo');
							writeln('4=bispo 5=rainha');
							read(tab[lj,cj]);
							end;
							if not mudateam then
							begin
							writeln('Para qual peca deseja promover?');
							writeln('8=peao 9=cavalo');
							writeln('10=bispo 11=rainha');
							read(tab[lj,cj]);
							end;
						end;
						mudateam:= not mudateam;//Muda a equipe;
					end;
				end;
			end;
		end;
		write_tab(tab);
		writeln(lreiB,' ',creiB);
		writeln(lreiP,' ',creiP);
		if not mudateam then
		begin
			Check_Check_Negras(lreiP,creiP,tab,checkhouse);
			if checkhouse then
			writeln('O rei negro esta em check');
		end;
		if mudateam then
		begin
			Check_Check_Brancas(lreiB,creiB,tab,checkhouse);
			if checkhouse then
			writeln('O rei branco esta em check');
		end;
	end;
	end;
end.
