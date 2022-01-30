function [CSM_true,CSM_false] = rozdeleni_trenovacich_chroma (X)
%% vstup
% X - bunka vypocitanych chromagramu daneho stylu
%% výstup
% CSM_true - matice krizovych podobnosti coveru (300)
% CSM_false - matice krizovych podobnosti Ne-coveru (300)

%% inicializace
Y = cell.empty; %bunka na roztrideni chromagramu - original a covery ve sloupci (6,20)
C =  cell.empty; %bunka kombinaci 2 chromagramu - cover (300,2)
N = cell.empty;  %bunka kombinaci 2 chromagramu - NEcover (300,2)
CSM_true = cell.empty; %bunka CSM coveru - (300,1)
CSM_false = cell.empty; %bunka CSM NEcoveru - (300,1)

%% rozdeleni do sloupcu = 1 radek original a pod nim 5 coveru
for i = 1:20
    for j = 1:6
        Y{j,i} = X((i*6)-(6-j)).chromagram;
    end
end
%% Covery
%vypocet kombinaci 2 clena kombinace coveru 6!/2!(6-2)! = 15 pro
%kazdou sklabu
p = 1;
for k = 1:20  
    C(p:(p+14),:)=nchoosek(Y(:,k),2);
    p = p+15;
end
%% Necovery
%vypocet kombinaci 2 clena kombinace ne-coveru 270 kombinaci (18*15)
p =1;
for m = 1:6
    for n = 1:3
        N(p:(p+14),:) = nchoosek(Y(m,(n*6)-5:n*6),2);
        p = p+15;
    end
    
end
%+30 ne-cover kombinaci
for o = 1:5
    q = size(N,1); %aktualni velikost matice Necoveru
    N((q+1):(q+6),1) = Y(:,o); 
    N((q+1):(q+6),2) = Y(:,(o+10));
end

%% vypocet matic podobnosti mezi kombinacemi coveru a ne-coveru
for l = 1:size(C,1)
    [~,cover_trans] = transpozice(C{l,1},C{l,2},2);
    CSM_true{l,1} = CSM(C{l,1},cover_trans,1);
    [~,Ne_cover_trans] = transpozice(N{l,1},N{l,2},2);
    CSM_false{l,1} = CSM(N{l,1},Ne_cover_trans,1);
end
