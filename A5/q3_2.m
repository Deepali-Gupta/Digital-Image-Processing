% load image
I = imread('image.jpg');
I=rgb2gray(I);
I = uint8(I);
[m,n]=size(I);
% simulate blur
winsize=9; 
dirangle=45;
h=motionblur(dirangle,winsize);
% blurred image
F=fft2(I);
Hmat=fft2(h,m,n);
Gmat=F.*Hmat;
g=ifft2(Gmat);
figure(1),
imagesc(I),colormap('gray'),title('original image')
figure(2),
imagesc(abs(g)),colormap('gray'),title('blurred image')
figure(3),
imagesc(log(1+abs(Gmat))),colormap('gray'),title('blurring filter')
figure(4)
imagesc(h),colormap('gray'),title('blurring filter mask')
P = Hmat;
P( P==0 )=1e-7; 
Hinv = 1./(P);
GG = fft2(g);
rec = ifft2(GG.*Hinv);
figure(5)
imagesc(abs(rec)), colormap('gray'), title('Inverse Filtering')
P = Hmat;
epsilon = 1e-3;
P(abs(P) < epsilon) = 0;
Hinv = 1./(P);
Hinv(isinf(Hinv)) = 0;
GG = fft2(g);
rec1 = ifft2(GG.*Hinv);
figure(6)
imagesc(abs(rec1)), colormap('gray'), title('pseudo inverse filtering')