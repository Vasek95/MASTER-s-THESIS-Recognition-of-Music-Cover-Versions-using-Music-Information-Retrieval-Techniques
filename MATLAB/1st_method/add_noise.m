function [Y_tren, Y_tren_vyst] = add_noise(X_tren,X_tren_vyst,p, t)
%% funkce ktera umele zvesti pocet trenovacich vzoru pomoci sumu
%% Vstup
% X_tren - trenovaci vzory
% X_tren_vyst - ocekavany vytsup pro trenovaci vzory
% p - pocet kolik zasumnenych vzoru pridat
% t - maximalni rozpeti sumu
%% Vystup
% Y_tren - trenovaci vzory se sumem
% Y_tren_vyst - ocekavany vytsup pro trenovaci vzory
%% Inicializace
[a,b] = size(X_tren); % pocet vzoru
[c,d] = size(X_tren_vyst);
Y_tren = zeros(a+p*a,b);
Y_tren_vyst = zeros(c,d+p*d);
%% zasumneni a napneni
posun = 0;
for i = 1:a
    Y_tren(i+posun,:) =X_tren(i,:);
    Y_tren_vyst(:,i+posun) = X_tren_vyst(:,i);
    for j = 1:p
       Y_tren(i+posun+j,:) = X_tren(i,:) + (normalizace(randn(1,b),1)*t);
       Y_tren_vyst(:,i+posun+j) = X_tren_vyst(:,i);
    end
    posun = posun + p;
end

