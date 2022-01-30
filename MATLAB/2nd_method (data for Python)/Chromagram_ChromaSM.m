function [ch]=Chromagram_ChromaSM(wavfilename)


%% chroma tool
%nacteni audia
[f_audio,sideinfo] = wav_to_audio(wavfilename);
%vypocet energie pod filtry a segmentace - demo ma 4410
fs=sideinfo.wav.fs;
paramPitch.winLenSTMSP = fs;
[f_pitch] = audio_to_pitch_via_FB(f_audio,paramPitch);
%vypocet CENS chromagramu_v demu nastavuji parametry na 11 a 5
parameter.winLenSmooth = 1;
parameter.downsampSmooth = 2;
[ch] = pitch_to_chroma(f_pitch,parameter);
ch = ch(:,1:180);





