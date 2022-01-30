function [Y,Y_nazvy,indx_ods,class] = mRMR(X,k,n,var,dim,t,c)
%% funkce pro vypovet K nejlepsi parametru
%% Vstup
% X - bunka parametru
% k - poèet nejlepsich parametru
% n - 0 bez normalizace pred mRMR nebo 1 s normalizaci
% var - varianta mRMR
% dim -  dimenze kategorizace
%     - 0 =  po radcich
%     - 1 =  po sloupcich
% t - vektor konstant kategorizace napr: [1 -1] nebo [1 0.5 -0.5 -1]
% c - kolik kategorii - napø 3 nebo 5 = lichí cislo
%% Vystup
% Y - nejlep¹í parametry
% Y_nazvy - nejlepsi parametry nazvy
% indx_ods - odstranene indexy pri funkci zero_clean

%% Inicializace
p_nazev = X(3:end,1); %nazvy parametru vektor nazvu parametru
class = zeros(120,1); %vektor trid do kterych patri skladby
%naplneni trid

for i = 1:20
    class ((i*6-5):i*6) = i;
end 
d = cell2mat(X(3:end,2:end)'); %matice vsech parametru, pisen = radek, sloupce = parametry
%% NORMALIZACE
if n == 1
    d = normalizace(d,2);
else
end
%% odstraneni parametru a jejich nazvu  = nemaji pro klasifikaci vyznam (nuly)
[d,p_nazev,indx_ods]=zero_clean(d,p_nazev,2); 

%% kategorizace dat
[d_dis] = kategorizace(d,dim,t,c);
%% vypocet mRMR
if var == 1
    fea = mrmr_mid_d(d_dis,class,k);
else
    fea = mrmr_miq_d(d_dis,class,k);
end
%% nejlepsi parametry
Y=zeros(120,k); %prazdna matice pro nejlepisch k parametru
Y_nazvy=cell(k,1); %prazdna bunka pro nejlepi nazvy parametru
for i =1:k
    Y_nazvy(i,1) = p_nazev(fea(i));
    Y(:,i) =  d(:,fea(i));  
end
