% image handles
im=imread('tennis4.jpg');
% Color detection
[x,y,z]=size(im);
newim=zeros(x,y,3);
for i=1:x
    for j=1:y
        if (im(i,j,3)<=im(i,j,1) && im(i,j,1)<=im(i,j,2)) || (im(i,j,1)>=110 && im(i,j,1)<=255 && im(i,j,2)>=170 && im(i,j,2)<=255 && im(i,j,3)>=20 && im(i,j,3)<=130)
            newim(i,j,:)=im(i,j,:);
        end
    end
end
newim=uint8(newim);
% convert to grayscale
grim=rgb2gray(newim);
% apply median filter
medim=medfilt2(grim);
% convert to binary image
binim=zeros(x,y);
for i=1:x
    for j=1:y
        if medim(i,j)>0
            binim(i,j)=1;
        end
    end
end
% detect clusters
CC=bwconncomp(binim);
numPixels = cellfun(@numel,CC.PixelIdxList);
temp=size(numPixels);
final=binim;
% erase clusters with size less than 200 pixels
for i=1:temp(2)
    if numPixels(i)<200
        final(CC.PixelIdxList{i}) = 0;
    end
end
% detect circles using CHT
[centers, radii] = imfindcircles(final,[10 200],'ObjectPolarity','bright','Sensitivity',0.9);
% plot results
figure
subplot(2,2,1)
imshow(im)
title('Original image')
subplot(2,2,2)
imshow(newim)
title('Color detection')
subplot(2,2,3)
imshow(binim)
title('binary image with median filter')
subplot(2,2,4)
imshow(final)
h = viscircles(centers,radii);
title('Ball detection')