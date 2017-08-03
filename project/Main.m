clear;
I=imread('image1.jpg');
lab_image = rgb2lab(I);
Point=[163 162 160];
lab_point = [66.66 0.09 1.18];
%neighborhood=[1 0 1 0 1;0 1 1 1 0;1 1 1 1 1;0 1 1 1 0;1 0 1 0 1];
Scalar_image=scalar_Transform(lab_image,lab_point);
[m,n]=size(Scalar_image);
%Black_Point=[1 1 1];
%Scalar_image=scalar_Transform(Scalar_image,Black_Point);
%Scalar_image=Special_erosion(Scalar_image);    
%Scalar_image=Special_dilation(Scalar_image);
%Scalar_image=Special_erosion(Scalar_image);
%Scalar_image=Special_erosion(Scalar_image);
%Scalar_image=Special_dilation(Scalar_image);
%Scalar_image=Special_erosion(Scalar_image);
%Mask=zeros(size(Scalar_image));
%Mask(10:end-10,10:end-10)=1;
%Active_Contour=activecontour(Scalar_image,Mask,1000,'edge');
Median_image=medfilt2(Scalar_image);
Binary_image=im2bw(Median_image,0.20);
Binary_image=imcomplement(Binary_image);
Morphised_Image=bwareaopen(Binary_image,200);
Morphised_Image=imcomplement(Morphised_Image);
Morphised_Image=bwareaopen(Morphised_Image,200);
Morphised_Image=imcomplement(Morphised_Image);
figure(18)
imshow(Morphised_Image);
title('Without small components');
BW=bwconncomp(Morphised_Image);
BoundingBox=regionprops(BW,'BoundingBox');
for i=1:size(BoundingBox)
if(BoundingBox(i).BoundingBox(3)<m/3 && BoundingBox(i).BoundingBox(4)<n/3)
Morphised_Image(BW.PixelIdxList{i})=0;
end
end
Skeleton_image=bwmorph(Morphised_Image,'thin',Inf);
Complete_skeleton=join_ends(Skeleton_image);
Morphised_image_temp=Complete_skeleton|Morphised_Image;
%Eroded_Image=Special_erosion(Morphised_Image);
%Morphised_Image=bwmorph(Binary_image,'remove');
%Morphised_Image2=bwmorph(Morphised_Image,'clean');
neighborhood=[1 0 1 0 1;0 1 1 1 0;1 1 1 1 1;0 1 1 1 0;1 0 1 0 1];
Eroded_Image2=imerode(Morphised_Image,neighborhood);
Dilated_Image2=imdilate(Morphised_Image,neighborhood);
Eroded_image=Special_erosion(Morphised_Image);
%Eroded_image=imerode(Eroded_image,neighborhood);
Dilated_image=Special_dilation(Morphised_Image);
Morphised_Image2=Special_dilation(Dilated_image);
%Morphised_Image2=Special_erosion(Morphised_Image2);
%Morphised_Image2=imdilate(Dilated_image,neighborhood);
%Morphised_Image2=imerode(Morphised_Image2,neighborhood);
%Dilated_image=imdilate(Dilated_image,neighborhood);
%Morphised_Image2=Dilated_image-Eroded_image;
Morphised_Image3=imdilate(Dilated_image,neighborhood);
Edge_image3=Morphised_Image-Eroded_image;
Edge_image4=Morphised_Image-imerode(Morphised_Image,ones(3));

Endpoints=bwmorph(Skeleton_image,'endpoints');
[Gmag,Gdir]=imgradient(Morphised_Image,'prewitt');
Thickened_image=bwmorph(Skeleton_image,'thicken',Inf);
%Morphised_Image2=bwmorph(Morphised_Image2,'close');
%Morphised_Image2=bwmorph(Morphised_Image,'remove');
Edge_image5=edge(Morphised_Image,'sobel');
Edge_image5=bwmorph(Edge_image5,'close');
Edge_image6=edge(Morphised_Image,'Canny');
Edge_image2=bwmorph(Edge_image6,'close');
Edge_image=edge(Morphised_Image2,'sobel');
Edge_image=bwmorph(Edge_image,'close');
Edge_image2=edge(Morphised_Image2,'Canny');
Edge_image2=bwmorph(Edge_image2,'close');
Edge_image7=edge(Morphised_Image3,'sobel');
Edge_image7=bwmorph(Edge_image7,'close');
Edge_image8=edge(Morphised_Image3,'Canny');
Edge_image8=bwmorph(Edge_image8,'close');
figure(1)
imshow(I,[ ]);
title('Original Image');
figure(2)
imshow(Scalar_image,[ ]);
title('Scalar Image');
figure(3)
imshow(Median_image,[ ]);
title('Median filtered Image');
figure(4)
imshow(Binary_image,[ ]);
title('Binary Image');
figure(5)
imshow(Morphised_Image,[ ]);
title('Morphised Image');
figure(6)
imshow(Edge_image,[ ]);
title('Sobel Operator special');
figure(7)
imshow(Edge_image2,[ ])
title('Canny Edge Detection special');
figure(8)
imshow(Morphised_Image2,[ ]);
title('Morphised Image 2')
figure(9)
imshow(Skeleton_image,[ ]);
title('Skeletonx');
figure(10)
imshow(Endpoints,[ ])
title('Endpoints')
figure(11)
imshow(Edge_image3,[ ])
title('I-e(I) special');
figure(12)
imshow(Edge_image4,[ ])
title('I-e(I) default')
figure(13)
imshow(Edge_image5,[ ])
title('Sobel operator normal')
figure(14)
imshow(Edge_image6,[ ]);
title('Canny Edge Detection normal')
figure(15)
imshow(Edge_image7,[ ])
title('Sobel operator default')
figure(16)
imshow(Edge_image8,[ ]);
title('Canny Edge Detection default')
figure(17)
imshow(Morphised_Image3,[ ]);
title('Morphised_image 3');