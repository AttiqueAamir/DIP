I2 = imread('E:\matlab\R2020a\bin\Image for HW-2.tif')
I = im2double(I2)
%subplot(4,4,1);
figure;
imshow(I)
title('Original Image');

laplacian = 1/16*[-1 -1 -1;-1 8 -1; -1 -1 -1];

%edge detection by laplacian mask

output = imfilter(I,laplacian);

%subplot(4,4,2);
figure;
imshow(output,[])
title('laplacian mask');

%laplacian mask 
output1 = imadd(output,I);
%subplot(4,4,3);
figure;
imshow(output1)
title('Laplacian image');

Sobelx = [-1 -2 -1;0 0 0;1 2 1];
Sobely = [-1 0 1;-2 0 2;-1 0 1];

gx = imfilter(I,Sobelx);
gy = imfilter(I,Sobely);

output2 = (gx+gy);
%subplot(4,4,4);
figure;
imshow(output2)
title('Sobel Image');

averagingmask = 1/25*ones([5 5]);

smoothedgradient = imfilter(output2,averagingmask);
%Temp = smoothedgradient - min(smoothedgradient(:))
%Rescaled = 255*(Temp/max(Temp(:)))
%Rescaled = uint8(Rescaled)
%subplot(4,4,5);
figure;
imshow(smoothedgradient)
title('Averaging Mask');

ProductoflaplaciannSmoothedgradient = immultiply(output1,smoothedgradient);
%subplot(4,4,6);
figure;
imshow(ProductoflaplaciannSmoothedgradient)
title('*ofLnSG');

SumofRealImgnProductoflaplaciannSmoothedgradient = imadd(I,ProductoflaplaciannSmoothedgradient);
%subplot(4,4,7);
figure;
imshow(SumofRealImgnProductoflaplaciannSmoothedgradient)
title('+ofInPLnSG');

PowerLawTransformation = 1*SumofRealImgnProductoflaplaciannSmoothedgradient.^0.5;
%subplot(4,4,8);
figure;imshow(PowerLawTransformation)
title('Power Law Transformatin');