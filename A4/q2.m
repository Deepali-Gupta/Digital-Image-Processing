I=imread('image1.jpg');
I=rgb2gray(I);
I=uint8(I);
[m,n]=size(I);
%Entropy Function
E1=Entropy(I);

%Huffman Encoding and Decoding
symbols=0:255;
[count,bins]=imhist(I);
P=count/sum(count);
dict=huffmandict(symbols,P);
Vec_I=reshape(I,1,m*n);
Huff_enc=huffmanenco(Vec_I,dict);
Huff_dec=huffmandeco(Huff_enc,dict);
Huff_dec=reshape(Huff_dec,[m,n]);
figure
subplot(1,2,1)
imshow(I)
title('Original Image')
subplot(1,2,2)
imshow(Huff_dec,[ ])
title('Huffman Decoded image')

%Golomb Encoding and Decoding
[Gol_Enc,M]=Golomb(I);
Gol_Dec=GolombDeco(Gol_Enc,M);
figure
subplot(1,2,1)
imshow(I)
title('Original Image')
subplot(1,2,2)
imshow(Gol_Dec,[ ])
title('Golomb Decoded image')

%Arithmatic coding and Decoding
Vec_I=int16(Vec_I);
for i=1:m*n
    if(Vec_I(i)==0)
        Vec_I(i)=1;
    end
end
for i=1:256
    if(count(i)==0)
        count(i)=1;
    end
end
Arit_Enc=arithenco(Vec_I,count);
Arit_Dec=arithdeco(Arit_Enc,count,m*n);
Arit_Dec=reshape(Arit_Dec,[m,n]);
figure
subplot(1,2,1)
imshow(I)
title('Original Image')
subplot(1,2,2)
imshow(Arit_Dec,[ ])
title('Arithmetic Decoded image')

% LZW Encoding and Decoding
[LZW_Enc,M]=norm2lzw(I);
LZW_Dec=lzw2norm(LZW_Enc);
LZW_Dec=reshape(LZW_Dec,[m,n]);
figure
subplot(1,2,1)
imshow(I)
title('Original Image')
subplot(1,2,2)
imshow(LZW_Dec,[ ])
title('LZW Decoded image')