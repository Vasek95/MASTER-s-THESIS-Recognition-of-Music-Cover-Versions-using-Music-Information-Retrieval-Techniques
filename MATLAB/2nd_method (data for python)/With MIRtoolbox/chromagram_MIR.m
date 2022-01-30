function [ch] = chromagram_MIR(wavfilename)
%% nacteni a uprava
[x,fs]  = audioread(wavfilename);
%% vypocet chrmagramu s 0 prekryvem = 12xt
f=mirframe(x,'Length',fs,'sp','Hop',100,'%'); %rozdìlení na framy = 180 framu
ch = mirgetdata(mirchromagram(f)); %vypocet chroma matice





