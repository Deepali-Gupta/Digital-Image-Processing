% read the image
I = rgb2gray(imread('image.jpg'));
% apply salt and pepper noise
J = imnoise(I,'salt & pepper');
% Contra-harmonic filter
F1 = spfilt(J, 'chmean', 3, 3, -1);
F2 = spfilt(J, 'chmean', 3, 3, 5);
% median filter
F3 = medfilt2(J);
% adaptive median filter
F4 = adpmedian(J, 3);
I=im2double(I);
F1=im2double(F1);
F2=im2double(F2);
F3=im2double(F3);
F4=im2double(F4);
% error
e1 = immse(I,F1);
e2 = immse(I,F2);
e3 = immse(I,F3);
e4 = immse(I,F4);
r1 = snr2(I,F1-I);
r2 = snr2(I,F2-I);
r3 = snr2(I,F3-I);
r4 = snr2(I,F4-I);
figure;
subplot(3,2,1);
imshow(I);
subplot(3,2,2);
imshow(J);
subplot(3,2,3);
imshow(F1);
subplot(3,2,4);
imshow(F2);
subplot(3,2,5);
imshow(F3);
subplot(3,2,6);
imshow(F4);
e = [e1,e2,e3,e4];
r = [r1,r2,r3,r4];
plot(r,e);


