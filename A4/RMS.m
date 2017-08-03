function [ RMS] = RMS(orig_img,converted_img)
[m,n]=size(orig_img);
[x,y]=size(converted_img);
if(m~=x ||n~=y)
    RMS=-1;
    return;
end
RMS=sqrt(mean2((orig_img-converted_img).^2));
end

