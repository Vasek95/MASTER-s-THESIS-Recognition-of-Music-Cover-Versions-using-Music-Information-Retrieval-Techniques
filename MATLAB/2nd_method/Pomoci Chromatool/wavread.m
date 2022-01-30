function [f_audio,fs,nbits] = wavread(wavfilename)
[f_audio,fs] = audioread(wavfilename);
info = audioinfo(wavfilename);
nbits = info.BitsPerSample;
