function [parametry] = predzprac_ChromaSM(filename,t)
%% popis funkce
% nacte dany zvukovy soubor, predzpracuje a preda fci pro extrahovani
% parametru
%% nacteni hudebniho mp3 souboru
[x,fs] = audioread(filename);
%% mono
if size(x,2)>1
    y = (x(:,1)+x(:,2))/2; 
else
    y=x;
end
%% prvnich 180 sekund
samples= fs*t;
if length(y)<samples
    y180 = zeros(samples,1);
    y180(1:length(y)) = y; 
else
    y180 = y(1:samples);
end
%% ulozeni_Wav
y180 = y180/max(abs(y180)); %normalizace aby nepeakoval
wavfilename = strrep(filename,'.mp3','.wav'); %vymena koncovky => ulozeni jako wav
audiowrite(wavfilename,y180,fs) %ulozeno jako wav, fs_2, 16bit, mono
%% nacteni WAV souboru a extrahovani parametru
[ch]=Chromagram_ChromaSM(wavfilename); %extrahovani chromagaramu

%% ulozeni do promene parametry
nazev = strsplit(filename,'/'); %rozdeleni lomitka
parametry.nazev = nazev(length(nazev));
parametry.cesta = filename; %pojmenovani sady parametru
parametry.chromagram = ch; 
%% odstranìní Wavu
delete (wavfilename)


