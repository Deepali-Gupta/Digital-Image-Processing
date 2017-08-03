function Eroded_image = Special_erosion(I)
Eroded_image=I;
[m,n]=size(I);
Mean=[0 0 0 0];
Standard_Deviation=[0 0 0 0];
for i=3:m-2
    for j=3:n-2
        for k=1:4
            for place=1:5
                if(k~=4)
                    x=i+place-3;
                else
                    x=i;
                end
                if(k~=1)
                    y=j-(-1)^k*(place-3);
                else
                    y=j;
                end
                Mean(k)=Mean(k)+I(x,y);
            end
            Mean(k)=Mean(k)/5;
        end
        for k=1:4
             for place=1:5
                if(k~=4)
                    x=i+place-3;
                else
                    x=i;
                end
                if(k~=1)
                   y=j-(-1)^k*(place-3);
                else
                    y=j;
                end
                Standard_Deviation(k)=Standard_Deviation(k)+(I(x,y)-Mean(k))^2;
            end
            Standard_Deviation(k)=Standard_Deviation(k)/5;
        end
        [id,idx]=min(Standard_Deviation);
        temp=zeros(5,1);
         for place=1:5
                if(idx~=4)
                    x=i+place-3;
                else
                    x=i;
                end
                if(idx~=1)
                    y=j-(-1)^k*(place-3);
                else
                    y=j;
                end
                temp(place)=I(x,y);
         end
         Eroded_image(i,j)=min(temp);
    end
end
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


end

