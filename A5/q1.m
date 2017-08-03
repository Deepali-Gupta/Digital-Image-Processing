% given matrix or image
%I = [0 0 1 5 6; 0 0 1 5 6; 2 2 4 7 8; 3 3 7 4 2; 6 6 5 1 0];
I=rgb2gray(imread('image.jpg'));
% size of image
[M,N]=size(I);
% original image values
f = I;
% predicted image values
F1 = f;
% prediction using average of top and left pixel
for i=2:M
    for j=2:N
        F1(i,j) = 0.5*(f(i,j-1)+f(i-1,j));
    end
end
% prediction error with this method
e1 = f - F1;
% mse calculate
mse1 = immse(f,F1);
% quantisation of prediction error
B = 0.1;
T = 2;
for i=1:M
    for j=1:N
        if e1(i,j)<(-1)*T
            e1(i,j)=(-1)*B;
        elseif e1(i,j)<=T
            e1(i,j)=0;
        else
            e1(i,j)=B;
        end
    end
end
% finding optimal weights using least mean square error method
% with only two neighbours
X = zeros((M-1)*(N-1),2);
p = zeros((M-1)*(N-1),1);
k=1;
for i=2:M
    for j=2:N
        X(k,1)= f(i-1,j);
        X(k,2)= f(i,j-1);
        p(k,1) = f(i,j);
        k=k+1;
    end
end
a = pinv(X)*p;
G2 = X*a;
F2=f;
k=1;
for i=2:M
    for j=2:N
        F2(i,j)=G2(k,1);
        k=k+1;
    end
end
e2 = f - F2;
mse2 = immse(f,F2);
for i=1:M
    for j=1:N
        if e2(i,j)<(-1)*T
            e2(i,j)=(-1)*B;
        elseif e2(i,j)<=T
            e2(i,j)=0;
        else
            e2(i,j)=B;
        end
    end
end
% using all nearest neighbours
X1 = zeros((M-2)*(N-2),8);
p1 = zeros((M-2)*(N-2),1);
k=1;
for i=2:M-1
    for j=2:N-1
        X1(k,1)= f(i-1,j-1);
        X1(k,2)= f(i-1,j);
        X1(k,3)= f(i-1,j+1);
        X1(k,4)= f(i,j-1);
        X1(k,5)= f(i,j+1);
        X1(k,6)= f(i+1,j-1);
        X1(k,7)= f(i+1,j);
        X1(k,8)= f(i+1,j+1);
        p1(k,1) = f(i,j);
        k=k+1;
    end
end
a1 = pinv(X1)*p1;
G3 = X1*a1;
F3=f;
k=1;
for i=2:M-1
    for j=2:N-1
        F3(i,j)=G3(k,1);
        k=k+1;
    end
end
e3 = f - F3;
mse3 = immse(f,F3);
for i=1:M
    for j=1:N
        if e3(i,j)<(-1)*T
            e3(i,j)=(-1)*B;
        elseif e3(i,j)<=T
            e3(i,j)=0;
        else
            e3(i,j)=B;
        end
    end
end