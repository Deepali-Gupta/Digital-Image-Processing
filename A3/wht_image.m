% program to find the 2D Walsh-Hadamard Transform
% specially helpful for grayscale images

%Please choose small images, large images take too long time for execution
%Image size M=N square image
%M=N=2 power of m
clc;
close all;
clear all;
a=imread('coins.png');
% a=rgb2gary(a);
a=imresize(a,[32,32]);
imshow(a),title('input image');
b=double(a);
[~,n]=size(a);
m=log2(n);
g=zeros(n);
t=zeros(n);
z=zeros(n);
c1=0;
in=1;
for u=0:n-1
     binu=de2bi(u,m);
    for v=0:n-1
         binv=de2bi(v,m);
        for x=0:n-1
            binx=de2bi(x,m);
            for y=0:n-1
                biny=de2bi(y,m);
                for i=1:m
                    if i==1
                        pu=binu(1,m);
                        pv=binv(1,m);
                    else
                        pu=mod(binu(1,(m-i)+2)+binu(1,(m-(i+1))+2),2);
                        pv=mod(binv(1,(m-i)+2)+binv(1,(m-(i+1))+2),2);
                    end
                    c=mod((binx(1,i)*pu)+(biny(1,i)*pv),2);
                    c1=mod(c1+c,2);
                end
                aa=x+1;bb=y+1;
                g(aa,bb,in)=(1/n)*(-1)^c1;
                c1=0;
            end
        end
         aa=u+1;bb=v+1;
       t(aa,bb)=sum(sum(g(:,:,in).*b));
       in=in+1;
    end
end
figure,imshow(t),title('WHT of input image');
figure,
imshow(log(abs(t)),[ ]); colormap(jet); colorbar;title('absolute value of wht plot');
%Inverse Transform
in=1;
 for u=0:n-1
    for v=0:n-1
         aa=u+1;bb=v+1;
         z(aa,bb)=sum(sum(g(:,:,in).*t));
         in=in+1;
    end
end
figure,imshow(uint8(z)),title('iWHT of WHT image');
