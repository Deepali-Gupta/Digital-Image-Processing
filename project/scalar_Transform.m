function sc_I = scalar_Transform(I,point)
[m,n,t]=size(I);
sc_I=zeros(m,n);
%disp(m);
%disp(n);
modPoint=double(0);
for k=1:3
    modPoint=modPoint+double(point(k))*double(point(k));
end
disp(modPoint)
for i=1:m
    for j=1:n
        %disp(i)
        %disp(j)
        temp=double(0);
        modI=double(0);
        for k=1:3
            %disp(k)
            temp=double(temp+double(I(i,j,k))*double(point(k)));
            modI=double(modI+double(I(i,j,k))*double(I(i,j,k)));
        end
%         disp(temp)
%         disp(modI)
%         disp(modPoint)
%         disp(modI*modPoint);
%         disp(sqrt(double(modI*modPoint)))
        if(temp~=0)
        temp=double(temp)/sqrt(double(modI)*double(modPoint));
        end
        if(temp>1)
        disp(temp)
        disp(modI)
        disp(modPoint)
        disp(sqrt(double(modI)*double(modPoint)))
        disp(double(modI)*double(modPoint))
        disp(I(i,j,:))
        end
        sc_I(i,j)=acos(double(temp));
    end
end
end

