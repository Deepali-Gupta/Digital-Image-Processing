% original image
f1 = rgb2gray(imread('image.jpg'));
f1 = im2double(f1);
[m,n]=size(f1);
% blur the image
PSF=fspecial('motion',20,45);
d=0.1;
blurred=imfilter(f1,PSF,'conv','circular');
% add salt and pepper noise
blurred_noisy=imnoise(blurred,'salt & pepper',d);
% recovery assuming no noise
recover_blur=deconvwnr(blurred,PSF,0);
% noise variance
signal_var=var(f1(:));
noise_var=d*0.5;
% recovery with noise estimate
recover_noisy=deconvwnr(blurred_noisy,PSF,noise_var/signal_var);
% recovery assuming constant noise
recover_noisy_const=deconvwnr(blurred_noisy,PSF,1);
% recovery using constrained least square filtering
% smoothing matrix
P=[0 -1 0;-1 4 -1;0 -1 0];
P=padarray(P,[m-3 n-3],0,'post');
Lamda=0.1;
CL=fft2(P);
CL=fftshift(CL);
recover_CLS=deconvwnr(blurred_noisy,PSF,abs(Lamda*CL));
% WGN noise
noise_mean=0;
WGN_var=0.00001;
blurred_noisy_WGN=imnoise(blurred_noisy,'gaussian',noise_mean,WGN_var);
recover_noisy_WGN=deconvwnr(blurred_noisy_WGN,PSF,(noise_var+WGN_var)/signal_var);
recover_noisy_WGN_const=deconvwnr(blurred_noisy_WGN,PSF,1.5);
recover_CLS_WGN=deconvwnr(blurred_noisy_WGN,PSF,abs(Lamda*CL));
figure
subplot(2,3,1)
imshow(f1);
subplot(2,3,2)
imshow(blurred);
subplot(2,3,3)
imshow(blurred_noisy)
subplot(2,3,4)
imshow(recover_blur)
subplot(2,3,5)
imshow(recover_noisy);
subplot(2,3,6)
imshow(recover_noisy_const);
figure
imshow(recover_CLS);