% original image
I=imread('image.jpg');
% 256 scale image
I=double(I)/256;
% grayscale image
G=rgb2gray(I);
% calculate variance of image to change it for getting required SNR
v=var(G(:));
% for dB 0, no change in v
noise1=imnoise(G, 'gaussian', 0, v); 
% for dB 10, divide v by 10^1
noise2=imnoise(G, 'gaussian', 0, v/10);
% for dB 10, divide v by 10^2
noise3=imnoise(G, 'gaussian', 0, v/100);
% for dB 10, divide v by 10^3
noise4=imnoise(G, 'gaussian', 0, v/1000);
% plot all images
figure
subplot(2,2,1)
imshow(noise1)
subplot(2,2,2)
imshow(noise2)
subplot(2,2,3)
imshow(noise3)
subplot(2,2,4)
imshow(noise4)
% Smoothing operation, apply noise 15 times to get different results
img_1=imnoise(G,'gaussian',0,v/10);
img_2=imnoise(G,'gaussian',0,v/10);
img_3=imnoise(G,'gaussian',0,v/10);
img_4=imnoise(G,'gaussian',0,v/10);
img_5=imnoise(G,'gaussian',0,v/10);
img_6=imnoise(G,'gaussian',0,v/10);
img_7=imnoise(G,'gaussian',0,v/10);
img_8=imnoise(G,'gaussian',0,v/10);
img_9=imnoise(G,'gaussian',0,v/10);
img_10=imnoise(G,'gaussian',0,v/10);
img_11=imnoise(G,'gaussian',0,v/10);
img_12=imnoise(G,'gaussian',0,v/10);
img_13=imnoise(G,'gaussian',0,v/10);
img_14=imnoise(G,'gaussian',0,v/10);
img_15=imnoise(G,'gaussian',0,v/10);
% take average using different number of images
avg_5=(img_1+img_2+img_3+img_4+img_5)/5;
avg_10=(img_1+img_2+img_3+img_4+img_5+img_6+img_7+img_8+img_9+img_10)/10;
avg_15=(img_1+img_2+img_3+img_4+img_5+img_6+img_7+img_8+img_9+img_10+img_11+img_12+img_13+img_14+img_15)/15;
% plot smoothed images
figure
subplot(2,2,1)
imshow(G)
subplot(2,2,2)
imshow(avg_5)
subplot(2,2,3)
imshow(avg_10)
subplot(2,2,4)
imshow(avg_15)
% calculate mean square error in each case
MSE_5=0;
MSE_10=0;
MSE_15=0;
for i=1:100
    for j=1:100
        MSE_5=MSE_5+abs(avg_5(i,j)-G(i,j))^2;
        MSE_10=MSE_10+abs(avg_10(i,j)-G(i,j))^2;
        MSE_15=MSE_15+abs(avg_15(i,j)-G(i,j))^2;
    end
end
% divide by number of pixels
MSE_5=MSE_5/10000
MSE_10=MSE_10/10000
MSE_15=MSE_15/10000
        



