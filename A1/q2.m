% original image
I = imread('iamge.jpg');
% grayscale image
I=rgb2gray(I);
% Resizing matrix
Tr1 = [3 0 0;0 2 0;0  0 1];
% Translation matrix
Tr2 = [1 0 0;0 1 0;6 7 1];
% Rotation matrix
r = (-1)*75/180*(3.14);
Tr3 = [cos(r) sin(r) 0; (-1)*sin(r) cos(r) 0; 0 0 1 ];
% resultant affine transform matrix
Tr = Tr3*Tr2*Tr1;
% change into transform matrix
tform = maketform('affine', Tr);
% apply transform
Res = imtransform(I, tform);
% plot final image
figure
imshow(Res);
