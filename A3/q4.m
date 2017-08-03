I=imread('image1.jpg');
%%blurring the image
PSF = fspecial('gaussian',7,10);
Blurred = imfilter(I,PSF,'symmetric','conv');
figure
subplot(1,3,1),imshow(Blurred);title('Blurred Image');

%% deblurring
undersizedPSF = ones(size(PSF)-4);
[J1, P1] = deconvblind(Blurred,undersizedPSF);
subplot(1,3,2),imshow(J1),title('Undersized PSF');,

INITPSF = padarray(undersizedPSF,[2 2],'replicate','both');
[J3, P3] = deconvblind(Blurred,INITPSF);
subplot(1,3,3),imshow(J3);title('Deblurring with INITPSF');
