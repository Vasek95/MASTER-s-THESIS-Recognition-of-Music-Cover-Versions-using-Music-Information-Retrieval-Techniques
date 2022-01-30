function [parametry] = predzprac_MIR(filename,fs_2,t)
%% popis funkce
% nacte dany zvukovy soubor, predzpracuje a preda fci pro extrahovani
% parametru
%% nacteni hudebniho mp3 souboru
[x,fs] = audioread(filename);
%% mono
if size(x,2)>1 %zjistim jestli uz neni mono
    y = (x(:,1)+x(:,2))/2;
else
    y = x;
end
%% ulozeni do WAV souboru
if fs>fs_2
    [up,down]=rat(fs_2/fs);
    y = resample(y,up,down,10);% pri downsamplinu pouziji anti-aliasinf 10 radu.
elseif fs<22050
    [up,down]=rat(fs/fs_2);
    y = resample(y,up,down);
else
    fs_2=fs;
end
%% prvnich 180 sekund
samples= fs_2*t;
if length(y)<samples
    y180 = zeros(samples,1);
    y180(1:length(y)) = y; 
else
    y180 = y(1:samples);
end
%% ulozeni_Wav
y180 = y180/max(abs(y180)); %normalizace aby nepeakoval
wavfilename = strrep(filename,'.mp3','.wav'); %vymena koncovky => ulozeni jako wav
audiowrite(wavfilename,y180,fs_2) %ulozeno jako wav, fs_2, 16bit, mono
%% nacteni WAV souboru a extrahovani parametru
[ch]=chromagram_MIR(wavfilename); %extrahovani chromagaramu

%% ulozeni do promene parametry
nazev = strsplit(filename,'/'); %rozdeleni lomitka
parametry.nazev = nazev(length(nazev));
parametry.cesta = filename; %pojmenovani sady parametru
parametry.chromagram = ch; 
%parametry.frame = frame;
%% odstranìní Wavu
delete (wavfilename)


