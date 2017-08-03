function filtered_image = butterworthbpf(I,d0,d1,n)
% Butterworth Bandpass Filter

% Usage BUTTERWORTHBPF(I,DO,D1,N)
% Example
% ima = imread('grass.jpg');
% ima = rgb2gray(ima);
% filtered_image = butterworthbpf(ima,30,120,4);

f = double(I);
[nx ny] = size(f);
f = uint8(f);
fftI = fft2(f,2*nx-1,2*ny-1);
fftI = fftshift(fftI);

%subplot(2,2,1)
%imshow(f,[]);
%title('Original Image')
%subplot(2,2,2)
%fftshow(fftI,'log')
%title('Image in Fourier Domain')
% Initialize filter.
filter1 = ones(2*nx-1,2*ny-1);
filter2 = ones(2*nx-1,2*ny-1);
filter3 = ones(2*nx-1,2*ny-1);

for i = 1:2*nx-1
    for j =1:2*ny-1
        dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;
        % Create Butterworth filter.
        filter1(i,j)= 1/(1 + (dist/d1)^(2*n));
        filter2(i,j) = 1/(1 + (dist/d0)^(2*n));
        filter3(i,j)= 1.0 - filter2(i,j);
        filter3(i,j) = filter1(i,j).*filter3(i,j);
    end
end
% Update image with passed frequencies.
filtered_image = fftI + filter3.*fftI;

%subplot(2,2,3)
%fftshow(filter3,'log')
%title('Filter Image')
filtered_image = ifftshift(filtered_image);
filtered_image = ifft2(filtered_image,2*nx-1,2*ny-1);
filtered_image = real(filtered_image(1:nx,1:ny));
filtered_image = uint8(filtered_image);

%subplot(2,2,4)
%imshow(filtered_image,[])
%title('Filtered Image')
