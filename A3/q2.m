%% original image
I=imread('image.jpg');
% 8 bit image
J=double(I)/256;
% grayscale image
G=rgb2gray(J);
H=rgb2gray(I);
% Edge detection

%% Laplacian filter
%Preallocate the matrices with zeros
A=H;
I1=zeros(size(A));
I2=zeros(size(A));

%Filter Masks
F1=[0 1 0;1 -4 1; 0 1 0];% without diagonal terms
F2=[1 1 1;1 -8 1; 1 1 1];% with diagonal terms

%Padarray with zeros
A=padarray(A,[1,1]);
A=double(A);

%Implementation of the laplacian operator
for i=1:size(A,1)-2
    for j=1:size(A,2)-2
       
        I1(i,j)=sum(sum(F1.*A(i:i+2,j:j+2)));
        I2(i,j)=sum(sum(F2.*A(i:i+2,j:j+2)));
       
    end
end

I1=uint8(I1);
I2=uint8(I2);
BW1=I1;
BW2=I2;
%% Gradient Operators
BW3=edge(H,'Roberts'); % Robert's cross gradient operator
BW4=edge(H,'Sobel'); % Sobel's operator

%% High Boost Filtering
[r c]=size(H);
A=1.5;
for j=1:r
    for i=1:c
        pixel_value=H(i,j);
        if(pixel_value<0)
            h8_lap_mask=[0 -1 0;-1 A+4 -1;0 -1 0];
            B=imfilter(H,h8_lap_mask);
        end
        if(pixel_value>=0)
            h8_lap_mask2=[-1 -1 -1;-1 A+8 -1;-1 -1 -1];
            B=imfilter(H,h8_lap_mask2);
        end
    end
end
BW5=B;

%% High pass
kernel2 = [-1 -2 -1; -2 12 -2; -1 -2 -1]/16;
filteredImageHP = imfilter(single(imread('image.jpg')), kernel2);

figure
imshow(H)
title('Original Image')
%% plot all the filters
figure
subplot(2,3,1)
imshow(BW1)
title('(a) Laplacian filter')
subplot(2,3,2)
imshow(BW2)
title('(a) With diagonal terms')
subplot(2,3,3)
imshow(BW3)
title('(b) Robert''s operator')
subplot(2,3,4)
imshow(BW4)
title('(c) Sobel''s operator')
subplot(2,3,5)
imshow(filteredImageHP)
title('(d) High pass filter')
subplot(2,3,6)
imshow(BW5)
title('(e) High boost filter')