% read the image
I=imread('image2.jpg');
% convert to grayscale
I=rgb2gray(I);
I=uint8(I);

% perform bit quantisation
I4=round(I/16)*16;
I5=round(I/8)*8;
I6=round(I/4)*4;
I7=round(I/2)*2;
I8=I;

% calculate rms and snr
RootMeanSquares=zeros(1,5);
SignalToNoise=zeros(1,5);
RootMeanSquares(1)=RMS(I,I4);
RootMeanSquares(2)=RMS(I,I5);
RootMeanSquares(3)=RMS(I,I6);
RootMeanSquares(4)=RMS(I,I7);
RootMeanSquares(5)=RMS(I,I8);
SignalToNoise(1)=snr(I,abs(I4-I));
SignalToNoise(2)=snr(I,abs(I5-I));
SignalToNoise(3)=snr(I,abs(I6-I));
SignalToNoise(4)=snr(I,abs(I7-I));
SignalToNoise(5)=snr(I,abs(I8-I));

% plot the results
figure
subplot(2,3,1)
imshow(I);
title('Original Image')
subplot(2,3,2)
imshow(I4);
title('4-bit uniform quantization')
subplot(2,3,3)
imshow(I5);
title('5-bit')
subplot(2,3,4)
imshow(I6);
title('6-bit')
subplot(2,3,5)
imshow(I7);
title('7-bit')
subplot(2,3,6)
imshow(I8);
title('8-bit')
X=4:8;
figure
plot(X,RootMeanSquares);
title('Root Mean Square error vs bits used')
figure
plot(X,SignalToNoise);
title('Signal to Noise Ratio vs Bits used')