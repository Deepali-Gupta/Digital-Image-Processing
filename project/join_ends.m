function Complete_Skeleton = join_ends(Skeleton)

Complete_Skeleton=Skeleton;
width=40;
gap=20;
[m,n]=size(Skeleton);
for i=1:gap:m-width
    for j=1:gap:n-width
    section=zeros(width);
    for x=1:width
        for y=1:width
            section(x,y)=Skeleton(i+x-1,j+y-1);
        end
    end
    CC=bwconncomp(section);
    if(CC.NumObjects==2)
        disp('in');
        temp1=zeros(width);
        temp2=zeros(width);
        temp1(CC.PixelIdxList{1})=1;
        temp2(CC.PixelIdxList{2})=1;
        end1=bwmorph(temp1,'endpoints');
        end2=bwmorph(temp2,'endpoints');
        end1(:,1)=0;
        end1(:,width)=0;
        end1(1,:)=0;
        end1(width,:)=0;
        end2(:,1)=0;
        end2(:,width)=0;
        end2(1,:)=0;
        end2(width,:)=0;
        [y1,x1]=find(end1);
        [y2,x2]=find(end2);
        s1=size(y1);
        s2=size(y2);
        if(s1==0)
            end1=bwmorph(temp1,'branchpoints');
            [y1,x1]=find(end1);
            s1=size(y1);
        end
        if(s2==0)
            end2=bwmorph(temp2,'branchpoints');
            [y1,x1]=find(end2);
            s2=size(y2);
        end
%         figure(1)
%         imshow(section)
%         figure(2)
%         subplot(2,2,1)
%         imshow(temp1)
%         subplot(2,2,2)
%         imshow(temp2)
%         subplot(2,2,3)
%         imshow(end1)
%         subplot(2,2,4)
%         imshow(end2)
        minx=0;
        miny=0;
        mindist=Inf;
        for x=1:s1
            for y=1:s2
                points=zeros(2,2);
                points(1,1)=x1(x);
                points(1,2)=y1(x);
                points(2,1)=x2(y);
                points(2,2)=y2(y);
                dist=pdist(points,'euclidean');
                if(dist<mindist)
                    mindist=dist;
                    minx=x;
                    miny=y;
                end
            end
        end
        if(minx~=0)
            section=func_Drawline(section,y1(minx),x1(minx),y2(miny),x2(miny),1);
        end
        %figure(3)
        %imshow(section);
        %pause;
      for x=1:width
      for y=1:width
            Complete_Skeleton(i+x-1,j+y-1)=section(x,y);
        end
      end
    end
    end
end
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


end

