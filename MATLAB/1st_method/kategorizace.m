function [Y] = kategorizace(X,dim,k,n)
% Kategorizace dat pro mRMR pro matici priznakovych vektoru
%% Vstup
% X - matice priznakovych vektoru
% dim - ve kterem smeru provadet kategorizace
%     - 0 =  po radcich
%     - 1 =  po sloupcich
% k - konstanty ovlivnujici treshold (0,1) - u n > 3 je k vektor konstant
% n - do kolika hodnot se ma kategorizovat - liche cislo (3,5,7...)
%% Vystup
% Y - matice kategorizovanych dat

%% osetreni dimenze
if dim == 1;
    X = X';
end
%% inicalizace
[a,b] =  size(X);
T = zeros(n-1,1);
C = zeros(n,1);
max_C = floor(n/2);
Y = ones(size(X)) * -max_C;
%% vypocet tresholdu
for j = 1:(size(T,1)/2) %vypocet tresholdu
    for i = 1:a
        T(j,i)=mean(X(i,:)) + k(j)*std(X(i,:));
        T((end+1-j),i)=mean(X(i,:)) + k(end+1-j)*std(X(i,:));
    end
        C(j) = max_C+1-j;
        C(end+1-j) = -max_C-1+j;
end
    
%% kategorizace

for l = 1:a
    for m = 1:b
        for o = 1:(n-1)
            if (X(l,m)>=T(o,l))&&(Y(l,m)<C(o))
                Y(l,m) = C(o);
            end
            
        end
            
    end
end

%% Ostereni dimenze
if dim == 1;
    Y = Y';
end    
end