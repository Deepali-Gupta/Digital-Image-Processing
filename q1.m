%% original image
I=imread('image.jpg');
% 8 bit image
I=double(I)/256;
% grayscale image
G=rgb2gray(I);
% negative of the image
Neg = imcomplement(G);
% log of the image, 1 added to avoid taking log of zero
Log = log(G+1);
% figure
% subplot(1,3,1)
% imshow(G)
% title('Original image')
% subplot(1,3,2)
% imshow(Neg)
% title('Negative image')
% subplot(1,3,3)
% imshow(Log)
% title('Log image')
%% Gamma correction
G1 = imadjust(G,[],[],0.4);
G2 = imadjust(G,[],[],2.5);
G3 = imadjust(G,[],[],10);
G4 = imadjust(G,[],[],25);
G5 = imadjust(G,[],[],100);
% figure
% subplot(2,3,1)
% imshow(G)
% title('Original Image')
% subplot(2,3,2)
% imshow(G1)
% title('gamma=0.4')
% subplot(2,3,3)
% imshow(G2)
% title('gamma=2.5')
% subplot(2,3,4)
% imshow(G3)
% title('gamma=10')
% subplot(2,3,5)
% imshow(G4)
% title('gamma=25')
% subplot(2,3,6)
% imshow(G5)
% title('gamma=100')
%% Bit Place Slicing
B = imread('image.jpg');
B = rgb2gray(B);
B1 = bitget(B,1);
B2 = bitget(B,2);
B3 = bitget(B,3);
B4 = bitget(B,4);
B5 = bitget(B,5);
B6 = bitget(B,6);
B7 = bitget(B,7);
B8 = bitget(B,8);
% figure
% subplot(3,3,1)
% imshow(B)
% title('Image')
% subplot(3,3,2)
% imshow(logical(B1))
% title('Bit plane 1')
% subplot(3,3,3)
% imshow(logical(B2))
% title('Bit plane 2')
% subplot(3,3,4)
% imshow(logical(B3))
% title('Bit plane 3')
% subplot(3,3,5)
% imshow(logical(B4))
% title('Bit plane 4')
% subplot(3,3,6)
% imshow(logical(B5))
% title('Bit plane 5')
% subplot(3,3,7)
% imshow(logical(B6))
% title('Bit plane 6')
% subplot(3,3,8)
% imshow(logical(B7))
% title('Bit plane 7')
% subplot(3,3,9)
% imshow(logical(B8))
% title('Bit plane 8')
%% Histogram transformations
% brighten the image
Bri = brighten(G,0.5);
% reduce image contrast
Con = imadjust(B,[0; 1],[0.4; 0.7]);
% darken the image
Dark = brighten(G,-0.5);
figure
subplot(4,2,1)
imshow(B)
title('Original Image')
subplot(4,2,2)
imhist(B)
title('Histogram')
subplot(4,2,3)
imshow(Bri)
title('Image brightened by 0.5')
subplot(4,2,4)
imhist(Bri)
subplot(4,2,5)
imshow(Con)
title('Contrast reduced from 0-1 to 0.4-0.7')
subplot(4,2,6)
imhist(Con)
subplot(4,2,7)
imshow(Dark)
title('Image darkened by 0.5')
subplot(4,2,8)
imhist(Dark)
%% Histogram qualisation
Heq = histeq(B);
figure
subplot(2,2,1)
imshow(B)
title('Original Image')
subplot(2,2,2)
imhist(B)
title('Histogram')
subplot(2,2,3)
imshow(Heq)
title('Histogram Equalised Image')
subplot(2,2,4)
imhist(Heq)
title('Equalised histogram')
%% Highlighting levels 120-200
High = zeros(100,100);
for i=1:100
    for j=1:100
        if(B(i,j)>=120)
            if(B(i,j)<=200)
                High(i,j)=B(i,j);
            end
        end
    end
end
figure
imshow(High)
amountIncrease = 255/4; %smount by which to highlight
highImg(:,:) = (High*(amountIncrease)); % Round since we're dealing with integers.
% Convert highImg to have the same range of values (0-255) as the origImg.
%highImg = uint8(highImg); 
blendImg = G + highImg;
figure
subplot(2,2,1)
imshow(B)
title('Original Image')
subplot(2,2,2)
imhist(B)
title('Histogram')
subplot(2,2,3)
imshow(blendImg)
title('Highlighted Image between 120-200')
subplot(2,2,4)
imhist(blendImg)
title('Resultant histogram')