function [ Ent ] = Entropy(img)
[counts,bin]=imhist(img);
[m,n]=size(img);
tot=m*n;
Ent=0;
for i=1:256
    prob=counts(i)/tot;
    Ent=Ent-prob*log2(prob);
end
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here


end

