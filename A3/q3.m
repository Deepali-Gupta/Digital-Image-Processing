I=imread('image.jpg');
j = imtranslate(I,[35, 25]);
I=rgb2gray(I);
J=rgb2gray(j);
%% Cosine and sine
cT=dct2(I);
cTj=dct2(J);
figure
subplot(1,2,1),imshow(I),title('Original Image');
subplot(1,2,2),imshow(j),title('Translated Image');
figure
subplot(2,2,1), imshow(log(abs(cT)),[]), colormap(gca,jet(64)), colorbar, title('Cosine');
P = dstn(I);
Q=dstn(J);
subplot(2,2,2),imshow(log(abs(P)),[]), colormap(gca,jet(64)), colorbar, title('Sine');
subplot(2,2,3), imshow(log(abs(cTj)),[]), colormap(gca,jet(64)), colorbar, title('Cosine Translated');
subplot(2,2,4), imshow(log(abs(Q)),[]), colormap(gca,jet(64)), colorbar, title('Sin Translated');
%% Haar
im = imread('image.jpg');
imt=imtranslate(im,[35, 25]);
figure 
subplot(2,2,1),imagesc(im),title('Original');
subplot(2,2,2),imagesc(imt),title('Translated');
[a,h,v,d] = haart2(im,3); %Obtain the 2-D Haar transform to level 2 and view the level 2 approximation.
[at,ht,vt,dt] = haart2(imt,3);
subplot(2,2,3),imagesc(a),title('Level 2 Approximation');
subplot(2,2,4),imagesc(at),title('Level 2 Approximation(T)');
imdata = imread('image.jpg'); %Load image
imdatat=imtranslate(imdata,[35, 25]);
new = double(rgb2gray(imdata)); %Convert to 2D Grayscale
newt= double(rgb2gray(imdatat));
figure 
subplot(2,2,1),imshow(imdata),title('Image');
subplot(2,2,2),imshow(imdatat),title('Image Translated');
N = 512;
%% Hadamard matrix
y = fwht(new,N,'sequency'); %Perform Fast-walsh-hadamard-transform with order 512
z= fwht(newt,N,'sequency');
subplot(2,2,3),imshow(y),title('Hadamard Transform'); %Display image transform
subplot(2,2,4),imshow(z),title('Hadamard Transform (T)'); %Display image transform