function [ encoded,M] = Golomb( img )
[m,n]=size(img);
img=uint16(img);
M=median(img(:));
B=round(log2(double(M)));
M=2^B;
for i =1:m
    for j=1:n
        R=mod(img(i,j),M);
        img(i,j)=img(i,j)-R;
        Q=img(i,j)/M;
        
        img(i,j)=0;
        for temp=1:Q
            img(i,j)=bitset(img(i,j),temp);
        end
        R=de2bi(R);
        for temp=1:size(R,2)
            img(i,j)=bitset(img(i,j),temp+Q+1,R(temp));
        end
    end
end
encoded=img;
        
end

