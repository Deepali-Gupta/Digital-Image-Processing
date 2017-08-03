% original image
I=imread('image1.jpg');
% grayscale image
I=rgb2gray(I);
% size of image
[m,n]=size(I);
imshow(I);
% get projections using radon transform
Theta=0:179;
[R,P]=radon(I,Theta);
figure;
% plot sinogram
imagesc(Theta,P,R);
title('R_{\theta} (x\prime)');
xlabel('\theta(degrees)');
ylabel('X\prime');
colorbar;
% BackPrjection
J=zeros(m,n);
for i=1:m
    for j=1:n
        for k=0:179
            val=(i-m/2)*cosd(90+k)+(j-n/2)*sind(90+k);
            temp=abs(P-val);
            [c, idx]=min(temp);
            J(i,j)=J(i,j)+R(idx,k+1);
        end
    end
end
figure;
J=J-min(min(J));
J=J/max(max(J));
imshow(J,[ ]);
% built in method
J=iradon(R,Theta,'linear','none');
K=iradon(R,Theta);
figure;
imshow(J,[ ]);

%Central Slicing Theorem
numOfParallelProjections = size(R,1);
numOfAngularProjections  = length(Theta); 

% convert thetas to radians
Theta = (pi/180)*Theta;

% set up the backprojected image
BPI_fourier = complex(zeros(numOfParallelProjections,numOfParallelProjections));

% find the middle index of the projections
midCoord = (numOfParallelProjections+1)/2;

% set up the coords of the image
yCoords = ([1:numOfParallelProjections]) - (numOfParallelProjections+1)/2;

% set up filter
rampFilter = [floor(numOfParallelProjections/2):-1:0 1:ceil(numOfParallelProjections/2-1)];%linspace(-1,1,numOfParallelProjections);

% loop over each projection
for i = 1:numOfAngularProjections

    % figure out which projections to add to which spots
    xCoordsRot = round(midCoord - yCoords*cos(Theta(i)));
    yCoordsRot = round(midCoord - yCoords*sin(Theta(i)));
    
    % convert 2d coords to indices
    ix = sub2ind(numOfParallelProjections*[1 1],xCoordsRot,yCoordsRot); % TRANSPOSE!!!!

    % filter in fourier domain
    filteredProfile_fourier = rampFilter.*fftshift( fft( fftshift(R(:,i)') ) );

    % summation in fourier domain
    BPI_fourier(ix) = BPI_fourier(ix) + filteredProfile_fourier./numOfAngularProjections;

end

% conversion of aggregated result to spatial domain
BPI = real( ifftshift(fft2(BPI_fourier)) );
BPI=imrotate(BPI,90);
figure;
imshow(BPI,[ ]);

%Filtered Back Propagation Method
midindex = floor(size(J,1)/2) + 1;

% prepare filter for frequency domain without normalization
[xCoords,yCoords] = meshgrid(1 - midindex:size(J,1) - midindex);
rampFilter2D      = sqrt(xCoords.^2 + yCoords.^2);

% 2 D Fourier transformation and sorting
reconstrution2DFT = fftshift(fft2(J));

% Filter in Freq Domain
reconstrution2DFT = reconstrution2DFT .* rampFilter2D;

% inverse 2 D fourier transformation and sorting
reconstrution2DFT = real( ifft2( ifftshift(reconstrution2DFT) ) );

figure;
imshow(reconstrution2DFT,[ ]);

figure;
imshow(K,[ ]);