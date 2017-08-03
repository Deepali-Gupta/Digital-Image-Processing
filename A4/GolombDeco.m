function [ Decoded] = GolombDeco( Encoded,M)
[m,n]=size(Encoded);
for i=1:m
    for j=1:n
        ne=de2bi(Encoded(i,j));
        Q=0;
        while( ne(Q+1)==1)
            Q=Q+1;
            if(Q>=size(ne,2))
                break;
            end
        end
        R=ne(Q+2:size(ne,2));
        if(size(R)~=0)
        R=bi2de(R);
        else
            R=0;
        end
        Encoded(i,j)=Q*M+R;
    end
end
Decoded=Encoded;
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here


end

