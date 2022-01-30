function [parametry] = extrahovani_parametru(wavfilename)
%% popis funkce
% extrahuje prametry pomoci mirtoolboxu
% parametry jsou normalizovane a ulozene do bunky parametry
%% vstupni promene
%  wavfilename = nazev souboru kter? byl predzpracovan
%% vystupni promene
% vystupni struktura vypocitanych normalizovanych parametru
%% parametry popisujici vysku
parametry.Chromagram = mirgetdata(mirchromagram(wavfilename,'Frame')); %matice
parametry.Keystrength = mirgetdata(mirkeystrength(wavfilename, 'Frame'));
parametry.Keystrength = parametry.Keystrength(:,:); %aby to byla 2D matice
parametry.Key = mirgetdata(mirkey(wavfilename, 'Frame')); %vektor
parametry.Mod = mirgetdata(mirmode(wavfilename,'Frame')); %matice
parametry.Tonal_centroid = mirgetdata(mirtonalcentroid(wavfilename,'Frame')); %matice
parametry.Hcdf = mirgetdata(mirhcdf(wavfilename,'Frame'));%vektor
%% parametry popisujici barvu
%parametry.Duration = normalizace(mirgetdata(mirduration(wavfilename)));
%%matice, dela bordel
parametry.Rolloff = NaNfilter(mirgetdata(mirrolloff(wavfilename))); %cislo, pri segmentaci haze Nany
parametry.Brightness = NaNfilter(mirgetdata(mirbrightness(wavfilename))); %cislo, pri segmentaci haze Nany
parametry.Roughtness = NaNfilter(mirgetdata(mirroughness(wavfilename,'Frame'))); %vektor urcuje dissonance atd?
parametry.Regularity = NaNfilter(mirgetdata(mirregularity(wavfilename,'Frame'))); %vektor urcuje stupen variace peaku spektra
parametry.ZRC = NaNfilter(mirgetdata(mirzerocross(wavfilename,'Frame'))); %matice
parametry.MCC = NaNfilter(mirgetdata(mirmfcc(wavfilename,'Frame')));%matice
parametry.Belost_spektra = NaNfilter(mirgetdata(mirmode(wavfilename,'Frame')));%matice
%% parametry popisujici dynamiku
parametry.RMS = NaNfilter(mirgetdata(mirrms(wavfilename,'Frame')));%matice
parametry.Low_energy = NaNfilter(mirgetdata(mirlowenergy(wavfilename,'Frame')));%matice
%% parametry popisujici tempo
fluk = mirgetdata(mirfluctuation(wavfilename)); %vraci divnou 3 dim matici ale jen jeden sloupec proto predelam na vek, segmentace viz manula ale moc velky vysledek
%fluktuace na matici
matice = zeros(size(fluk,1),size(fluk,3)); %matice)
for i = 1:size(fluk,3)
    matice(:,i) = fluk(:,i);
end
parametry.Fluktuace = NaNfilter(matice);
parametry.Beatspectrum = NaNfilter(mirgetdata(mirbeatspectrum(wavfilename))); %vektor u frame je
%kratsi a haze warningy, dlouhy vypocet 
parametry.Events = NaNfilter(mirgetdata(mirevents(wavfilename))); %detekuje peaky, frame dela NaNy, je zde milionmoznosti viz manual
parametry.Events_Frame = NaNfilter(mirgetdata(mirevents(wavfilename,'SpectroFrame',0.1,0.1)));%vektor sloupcovy
parametry.Eventdensity = NaNfilter(mirgetdata(mireventdensity(wavfilename,'Frame'))); %vektor 
parametry.Tempo = NaNfilter(mirgetdata(mirtempo(wavfilename))); %cislo
parametry.pulse= NaNfilter(mirgetdata(mirpulseclarity(wavfilename,'Frame')));
parametry.Metroid = NaNfilter(mirgetdata(mirmetroid(wavfilename)));%vektor
parametry.Hustota_zvuk_udalosti = NaNfilter(mirgetdata(mireventdensity(wavfilename,'Frame'))); %vektor




