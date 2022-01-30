function [E_c,E_valid,w1,w2,w3,w1_min,w2_min,w3_min] = BPNN(X,d,Valid,dv,neuronCountLayer1,neuronCountLayer2,Ec_stop,maxIter,alpha,M,nazev,p,s)
%% neuronova sit
% 2x skryta vrstva
% moznost menit pocet neuronu
% prenosove funkce Tanh
% parametry - koef uceni a momentum (zahrnuje zmeny starych vah)
%prenosove funkce jsou tanh (-1,+1)
%% vstupni data
%X - trenovaci matice - radek = trenovaci vzor =>  priznaky ve sloupcich=>
%pisen je radek
%d - ucitel - ocekavany vytsup site (-1,1)
%Valid - validacni data
%dv - ocekavany vystup validacnich dat
%Ec_stop - pozadovana chyba, pro ukonceni uceni
%maxIter - pocet iteraci
%alpha - koeficient uceni
%M - momentum
%neuronCountLayer1 - pocet neuronu v 1. skryte vrstve
%neuronCountLayer2 - pocet neuronu v 2. skryte vrstve
%nazev - nazev a datasetu
%p - kolik pridanych zasumenych vzoru k jedne skladbe
%s - jak moc sumu bylo pridano
%% vytsupni data
%E_c - vektor celkove chyby v kazde iteraci uceni
%matice vah mezi vrstavmi
    %   w1
    %   w2
    %   w3
%Y_3 - vystup site v posledni epose
tic;
numberOfClass = size(d,1);                      % pocet trid, do kterych tridime
neuronCountLayer3 = numberOfClass;      % pocet neuronu ve vystupni vrstve

%% vstupni data
                       % pozadovane vytsupy
X = [(ones(size(X,1),1)) [X]];
Valid = [(ones(size(Valid,1),1)) [Valid]]; % pridani jednicky kvuli w0 - BIAS

%% Inicializace vah
w1 = rand(size(X,2),neuronCountLayer1)-0.5; %nepricitam jednicku protoze X uz je o bias delsi
w2 = rand(neuronCountLayer1+1,neuronCountLayer2)-0.5;
w3 = rand(neuronCountLayer2+1,neuronCountLayer3)-0.5;
E_c = ones(1,maxIter); %vektor pro ukladani celkove chyby
iter = 1; %iterator
E = Ec_stop +1; %nastaveni chyb pro 0. iteraci
%% Uceni
while(iter <= maxIter)&&(E>=Ec_stop)
    E =0;
    Evalid = 0;
    %zamichani dat v kazde iteraci
    [X, d] = zamichani(X, d);
    for i  = 1:size(X,1)
        %vypocet vystupu site
        Y_1 = tanh(X(i,:) * w1);
        Y_2 = tanh([1 [Y_1]] * w2);
        Y_3 = tanh([1 [Y_2]] * w3);
    
        %vypocet chyb na kazde vrstve pri testovasni
        E_3 = (d(:,i)' - Y_3);
        E_2 = E_3*w3(2:end, :)';
        E_1 = E_2*w2(2:end, :)';
        %celkova chyba cele sady vzorku
        E = E + 0.5*sum((E_3.^2)); 
        
        if iter==1
            %buffer vah
            w1_b = w1;
            w2_b = w2;
            w3_b = w3;
            %adaptace vah
            w1 = w1 + X(i,:)'* alpha * (E_1 .* (1 - Y_1.^2))+ M*(w1 - w1);            
            w2 = w2 + [1 [Y_1]]'* alpha * (E_2 .* (1 - Y_2.^2))+ M*(w2 - w2);
            w3 = w3 + [1 [Y_2]]'* alpha * (E_3 .* (1 - Y_3.^2))+ M*(w3 - w3);
        else
            %adaptace vah
            w1_n = w1 + X(i,:)'* alpha * (E_1 .* (1 - Y_1.^2))+ M*(w1 - w1_b);            

            w2_n = w2 + [1 [Y_1]]'* alpha * (E_2 .* (1 - Y_2.^2))+ M*(w2 - w2_b);
            w3_n = w3 + [1 [Y_2]]'* alpha * (E_3 .* (1 - Y_3.^2))+ M*(w3 - w3_b);
            %buffer vah

             w1_b = w1;
            w2_b = w2;
            w3_b = w3;
            %ulozeni novych vah
            w1 = w1_n;   
            w2 = w2_n;
            w3 = w3_n;
        end
    end
    %testovani na validacnich datech v kazde iteraci trenovani = po celem
    %vzoru
   
    for j = 1:size(Valid,1)
        Yt_1 = tanh(Valid(j,:) * w1);
        Yt_2 = tanh([1 [Yt_1]] * w2);
        Yt_3 = tanh([1 [Yt_2]] * w3);
        E_valid_3 = (dv(:,j)' - Yt_3);
        Evalid = Evalid + 0.5*sum((E_valid_3.^2)); 
        
    end
    
    E_valid(iter) = Evalid;
    % zapamatovani wah s nejmensi chybou testovani
    if iter > 1
        if  (E_valid(iter) <  E_valid(iter-1)) && (E_valid(iter)<min(Evalid))
            w1_min = w1;
            w2_min = w2;
            w3_min = w3;
        end
       
    else
        w1_min = w1_b;
        w2_min = w2_b;
        w3_min = w3_b;
    end
    
    E_c(iter) = E; %celkova chyb site po jedne itreraci
    iter = iter +1;
end
%% uprava delky vektoru chyb
E_c=E_c(1:iter-1);
E_valid=E_valid(1:iter-1);
t = 1:iter-1;
Time_stop = toc;
minut = Time_stop/60;
%% Vykresleni prubehu uceni
figure(2);
plot(t,E_c)
hold on
plot(t,E_valid) 
legend('Trenovaci data','Validacni data')   
title('Zavislost validacni a trenovaci chyby na iteracich');
xlabel('iterace [-]')
xlim([1 iter-1])
ylabel('chyba [-]')
ylim([0 45])
grid on
%parametry do grafu
S = ['dataset: ',nazev,char(10),...
    'maximalni pocet iteraci: ',num2str(maxIter),char(10),...
    'ukoncujici chyba: ',num2str(Ec_stop),char(10),...
    'ucici koefeicient: ',num2str(alpha),char(10),...
    'momentum: ',num2str(M),char(10),...
    'neurony v 1. skryte vrstve: ',num2str(neuronCountLayer1),char(10),...
    'neurony v 2. skryte vrstve: ',num2str(neuronCountLayer2),char(10),...
    'nejmensi validacni chyba: ',num2str(min(E_valid)),char(10),...
    'pocet parametru mRMR: ',num2str(size(X,2)-1),char(10),...
    'pocet zasumenych vzoru k jedne skladbe: ',num2str(p),char(10),...
    'maximalni sum: ','< +',num2str(s),', -',num2str(s),' >',char(10),...
    'cas vypoctu: ',num2str(minut), ' minut'];
annotation('textbox',[0.3, 0.8, 0.1, 0.1], 'String', S)
end