function [] = q3(image,zX,zY,angle,method)
% The script takes the follwing inputs-  
% image = input image to operate on.
% zX for zoom along X
% zY for zoom along Y
% angle= Rotation in degrees of the image in the clockwise direction
% Input method = 1 for bilenear and method = 2 for bicubic interpolation

image=imread(image);
image=rgb2gray(image);
[r ,c, d] = size(image);
rn = floor(zX*r);
cn = floor(zY*c);

%% Code for bilenear interpolation
if(method==1)
    im_zoom = zeros(rn,cn,d);
for i = 1:rn;
    x1 = cast(floor(i/zX),'uint32');
    x2 = cast(ceil(i/zX),'uint32');
    if x1 == 0
        x1 = 1;
    end
    x = rem(i/zX,1);
    for j = 1:cn;
        y1 = cast(floor(j/zY),'uint32');
        y2 = cast(ceil(j/zY),'uint32');
        if y1 == 0
            y1 = 1;
        end
        ctl = image(x1,y1,:);
        cbl = image(x2,y1,:);
        ctr = image(x1,y2,:);
        cbr = image(x2,y2,:);
        y = rem(j/zY,1);
        tr = (ctr*y)+(ctl*(1-y));
        br = (cbr*y)+(cbl*(1-y));
        im_zoom(i,j,:) = (br*x)+(tr*(1-x));
    end
end

image_zoom = cast(im_zoom,'uint8');
image_zoom_rotate = imrotate(image_zoom,angle,'bilinear');
end

%% code for bicubic interpolation
if (method==2)
im_zoom = cast(zeros(rn,cn,d),'uint8');
im_pad = zeros(r+4,c+4,d);
im_pad(2:r+1,2:c+1,:) = image;
im_pad = cast(im_pad,'double');
for m = 1:rn
    x1 = ceil(m/zX); x2 = x1+1; x3 = x2+1;
    p = cast(x1,'uint16');
    if(zX>1)
       m1 = ceil(zX*(x1-1));
       m2 = ceil(zX*(x1));
       m3 = ceil(zX*(x2));
       m4 = ceil(zX*(x3));
    else
       m1 = (zX*(x1-1));
       m2 = (zX*(x1));
       m3 = (zX*(x2));
       m4 = (zX*(x3));
    end
    X = [ (m-m2)*(m-m3)*(m-m4)/((m1-m2)*(m1-m3)*(m1-m4)) ...
          (m-m1)*(m-m3)*(m-m4)/((m2-m1)*(m2-m3)*(m2-m4)) ...
          (m-m1)*(m-m2)*(m-m4)/((m3-m1)*(m3-m2)*(m3-m4)) ...
          (m-m1)*(m-m2)*(m-m3)/((m4-m1)*(m4-m2)*(m4-m3))];
    for n = 1:cn
        y1 = ceil(n/zY); y2 = y1+1; y3 = y2+1;
        if (zY>1)
           n1 = ceil(zY*(y1-1));
           n2 = ceil(zY*(y1));
           n3 = ceil(zY*(y2));
           n4 = ceil(zY*(y3));
        else
           n1 = (zY*(y1-1));
           n2 = (zY*(y1));
           n3 = (zY*(y2));
           n4 = (zY*(y3));
        end
        Y = [ (n-n2)*(n-n3)*(n-n4)/((n1-n2)*(n1-n3)*(n1-n4));...
              (n-n1)*(n-n3)*(n-n4)/((n2-n1)*(n2-n3)*(n2-n4));...
              (n-n1)*(n-n2)*(n-n4)/((n3-n1)*(n3-n2)*(n3-n4));...
              (n-n1)*(n-n2)*(n-n3)/((n4-n1)*(n4-n2)*(n4-n3))];
        q = cast(y1,'uint16');
        sample = im_pad(p:p+3,q:q+3,:);
        im_zoom(m,n,1) = X*sample(:,:,1)*Y;
        if(d~=1)
              im_zoom(m,n,2) = X*sample(:,:,2)*Y;
              im_zoom(m,n,3) = X*sample(:,:,3)*Y;
        end
    end
end
im_zoom = cast(im_zoom,'uint8');
image_zoom_rotate = imrotate(im_zoom,angle,'bicubic');
end;

%% Displaying the final images
figure 
imshow(image);
figure
imshow(image_zoom_rotate);

    
    
    
        
        




















end

