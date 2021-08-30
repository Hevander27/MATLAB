[a, fs,] = audioread('cello_A3_1_forte_arco-normal.mp3', [1 20000]);
[a1, fs1] = audioread('saxophone_A3_1_forte_normal.mp3', [1 20000]);

plot(a)
figure(2)
plot(a1)

audioplayer(a, fs)
audioplayer(a1,fs1)

lenA = size(a,1);
lenA1 = size(a1,1);

len = max(lenA, lenA1);
S = zeros(len,size(a,2));
S(1:lenA,:) = a;
S(1:lenA1,:) = S(1:lenA1,:) + a1;
maxVal = max(abs(S(:)));
S = S/maxVal;

sound(S,44100)
figure(3)
plot(S)