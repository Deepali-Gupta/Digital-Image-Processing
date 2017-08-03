I=imread('cameraman.tif');
I=im2double(I);
%KLTransform Coding
m=1;
for i=1:8:256
    for j=1:8:256
        for x=0:7
            for y=0:7
            img(x+1,y+1)=I(i+x,j+y);
            end
        end
            k=0;
            for l=1:8
                img_expect{k+1}=(img(:,l))*(img(:,l)');
                k=k+1;
            end
            imgexp=zeros(8:8);
            for l=1:8
                imgexp=imgexp+(1/8)*img_expect{l};%expectation of E[xx']
            end
            img_mean=zeros(8,1);
            for l=1:8
                img_mean=img_mean+(1/8)*img(:,l);
            end
            img_mean_trans=img_mean*img_mean';
            img_covariance=imgexp - img_mean_trans;
            [v{m},d{m}]=eig(img_covariance);
            temp=v{m};
             m=m+1;
            for l=1:8
                v{m-1}(:,l)=temp(:,8-(l-1));
            end
             for l=1:8
           trans_img1(:,l)=v{m-1}*img(:,l);
             end
           for x=0:7
               for  y=0:7
                   transformed_img(i+x,j+y)=trans_img1(x+1,y+1);
               end
           end
mask=[1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 
      1 1 1 1 1 1 1 1 ];
  trans_img=trans_img1.*mask;
           for l=1:8
           inv_trans_img(:,l)=v{m-1}'*trans_img(:,l);
           end
            for x=0:7
               for  y=0:7
                  inv_transformed_img(i+x,j+y)=inv_trans_img(x+1,y+1);
               end
           end

          end
end
  figure
  subplot(1,2,1)
  imshow(transformed_img)
  title('KLTransformed Image')
  subplot(1,2,2)
  imshow(inv_transformed_img);
  title('KLInverse Transformed Image')
  
%Discrete Cosine Transform Coding
T = dctmtx(8);
dct = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dct);
mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);
invdct = @(block_struct) T' * block_struct.data * T;
I2 = blockproc(B2,[8 8],invdct);
figure
imshow(I2)
title('Decompressed image Cosine Transformation')

%DFT Coding
N=8;
for i=1:8:256
    for j=1:8:256
        for x=0:7
            for y=0:7
                img(x+1,y+1)=I(i+x,j+y);
            end
        end
        F=fft2(img);
         for x=1:8
             for y=1:8
                 if(log(abs(F(x,y))+1)<0.01*log(max(abs(F)))+1)
                     F(x,y)=0;
                 end
             end
         end
        img=real(ifft2(F));
        for x=0:7
            for y=0:7
                J(i+x,j+y)=img(x+1,y+1);
            end
        end
    end
end
figure
imshow(J,[ ])
title('Decompressed Image Fourier Transform')

%Entropy Calculation
Ent_KL=Entropy(inv_transformed_img)
Ent_DCT=Entropy(I2)
Ent_DFT=Entropy(J)


%Root Mean Square Error
RMS_KL=RMS(I,inv_transformed_img)
RMS_DCT=RMS(I,I2)
RMS_DFT=RMS(I,J)

%Square-Mean Signal-to-Noise Ratios
SNR_KL=snr(I,abs(inv_transformed_img-I))
SNR_DCT=snr(I,abs(I2-I))
SNR_DFT=snr(I,abs(J-I))

        
        