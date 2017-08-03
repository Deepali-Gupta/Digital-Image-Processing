% make video object
obj = VideoReader('videoplayback1.mp4');
% extract frames
f1 = rgb2gray(read(obj, 201));
f2 = rgb2gray(read(obj, 202));
% estimate motion
hbm = vision.BlockMatcher('ReferenceFrameSource',...
        'Input port','BlockSize',[35 35]);
hbm.OutputValue = 'Horizontal and vertical components in complex form';
halphablend = vision.AlphaBlender;
motion = step(hbm,f2,f1);
img12 = step(halphablend,f2,f1);
% inverse filtering
h = fspecial('disk',4);
hf = fft2(h,size(img12,1),size(img12,2));
img_inv = real(ifft2(fft2(img12)./hf));
% pseudo inverse filtering
img_pinv = real(ifft2((abs(hf) > 0.1).*fft2(img12)./hf));



