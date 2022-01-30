function [M] = CSM (ch1,ch2,n)
%% funkce pro vypocet matice podobnosti (cross similiarity matrix)
%% vstup
% ch1 -  chromagram 1
% ch2 -  chromagram 2
% n - 0 bez normalizace
%   - 1 normalizace podle: Chang,Lee,Choe,Lee - Audio Cover Identification
%   using Convolutional Neural Network (2017)
%    - 2 -druha moznost normalizace
%% vystup
% M - matice podobnosti
%% vypocet
s1 = size(ch1,2);
s2 = size(ch2,2);
M =  zeros(s1,s2);
for i = 1:s1
    for j = 1:s2
        M(i,j) = norm(ch1(:,i)-ch2(:,j));
        %M(i,j) = dot(ch1(:,i),ch2(:,j));
    end  
end
%% Normalizace

if n == 1
     %1 metoda
     max_numb = max(max(M));
     M = (max_numb - M)/max_numb;
   
elseif n == 2  %2 metoda
    for k = 1:size(M,2)
        MX = max(M(:,k));
        M(:,k) = (MX - M(:,k))/MX;
    end
else
    
end
