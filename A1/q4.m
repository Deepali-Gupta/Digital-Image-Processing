% Original image
I=imread('image.jpg');
% grayscale image
I=rgb2gray(I);

% change to 16 level image by checking range of values
for i=1:size(I,1)
    for j=1:size(I,2)
        if(I(i,j)<16)
            I(i,j)=0;
        elseif(I(i,j)<32)
            I(i,j)=1;
       elseif(I(i,j)<48)
            I(i,j)=2;
       elseif(I(i,j)<64)
            I(i,j)=3;
       elseif(I(i,j)<80)
            I(i,j)=4;
       elseif(I(i,j)<96)
            I(i,j)=5;
       elseif(I(i,j)<112)
            I(i,j)=6;
       elseif(I(i,j)<128)
            I(i,j)=7;
       elseif(I(i,j)<144)
            I(i,j)=8;
       elseif(I(i,j)<160)
            I(i,j)=9;
       elseif(I(i,j)<176)
            I(i,j)=10;
       elseif(I(i,j)<192)
            I(i,j)=11;
       elseif(I(i,j)<208)
            I(i,j)=12;
       elseif(I(i,j)<224)
            I(i,j)=13;
       elseif(I(i,j)<240)
            I(i,j)=14;
       elseif(I(i,j)<256)
            I(i,j)=15;
        end
    end
end  

numofpixels=size(I,1)*size(I,2);
% show original 16 level image
figure,imshow(I);
title('Original Image');

J=uint8(zeros(size(I,1),size(I,2)));

freq=zeros(16,1);  %freq counts the occurrence of each pixel value, plot this for historgram of original image.
probf=zeros(16,1); %The probability of each occurrence is calculated by probf.
probc=zeros(16,1);
cum=zeros(16,1);
output=zeros(16,1);

for i=1:size(I,1)

    for j=1:size(I,2)

        value=I(i,j);
        freq(value+1)=freq(value+1)+1;
        probf(value+1)=freq(value+1)/numofpixels;

    end

end

sum=0;
no_bins=15;

%The cumulative distribution probability is calculated. 

for i=1:size(probf)
   sum=sum+freq(i);
   cum(i)=sum;
   probc(i)=cum(i)/numofpixels;
   output(i)=round(probc(i)*no_bins);
end

for i=1:size(I,1)
    for j=1:size(I,2)
            J(i,j)=output(I(i,j)+1);
    end
end

hist2=zeros(16,1)
for i=9:16
    hist2(i)=1250 % 10000/8 for uniformity between 8 to 15
end

cdf2=cumsum(hist2)/numofpixels;

M=zeros(16,1)
% find the mapping
for idx = 1 : 16
    [~,ind] = min(abs(probc(idx) - cdf2));
    M(idx) = ind-1;
end
K=M(double(I)+1)

% plot images
figure
imshow(J);
title('Histogram equalization');
figure
imshow(K)
title('New equalisation');