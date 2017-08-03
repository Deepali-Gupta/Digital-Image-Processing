I=imread('image.jpg');
I=rgb2gray(I);
imgF=fourierPlotter(I);
Translated = imtranslate(I,[15, 25]);
trans_fourier=fourierPlotter(Translated);
Rotated= imrotate(I,20);
rotate_fourier=fourierPlotter(Rotated);
Upscaled= imresize(I,2);
upscale_fourier=fourierPlotter(Upscaled);
figure;
subplot(2,4,1), imshow(I), title('Original Image');
subplot(2,4,2), imshow(Translated), title('Translated Image');
subplot(2,4,3), imshow(Rotated), title('Rotated Image');
subplot(2,4,4), imshow(Upscaled),title('Upscaled ');
subplot(2,4,5), imshow(imgF), title('Fourier transform ');
subplot(2,4,6), imshow(trans_fourier), title('Fourier transform ');
subplot(2,4,7), imshow(rotate_fourier), title('Fourier transform');
subplot(2,4,8),imshow(upscale_fourier),title('Fourier tranform');




%% Gaussian Filter
G1 = imgaussfilt(I,2);
G2 = imgaussfilt(I,0.5);
figure
subplot(1,3,1), imshow(G1),title('Low pass, sigma= 2');
subplot(1,3,2),imshow(G2),title('Low pass, sigma=0.5');
G3=IdealLowPass(I,0.5);
G4=butterworthbpf(I,10,20,4);
G5=butterworthbpf(I,120,110,4);
subplot(1,3,3)
imshow(G3,[ ])
title('ideal Low Pass Filter')
figure
subplot(1,2,1)
imshow(G4,[ ])
title('Butterworth Low Pass Filter');
subplot(1,2,2)
imshow(G5,[ ])
title('Butterworth High Pass Filter');
%% High pass
figure
subplot(1, 3, 1);imshow(I, []); title('Original question');
% Filter 1
kernel1 = -1 * ones(3)/9;
kernel1(2,2) = 8/9;
filteredImage = imfilter(single(I), kernel1);
subplot(1, 3, 2);
imshow(filteredImage, []),title('High pass Filter');
% Filter 2
kernel2 = [-1 -2 -1; -2 12 -2; -1 -2 -1]/16;
filteredImage = imfilter(single(I), kernel2);
subplot(1, 3, 3);
imshow(filteredImage, []),title('High pass Filter');

  