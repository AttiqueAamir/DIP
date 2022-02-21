I2 = imread('Img-2.tif');
I = im2double(I2)
%subplot(4,4,1);
figure(1);
imshow(I)
title('Noisy Image');

F = fft2(I);

%S = abs(F);
Fsh = fftshift(F);
S2 = log(1+abs(Fsh));
figure(2);
%subplot(4,4,2);
imshow(S2,[])
title('Fourier Transformed Spectrum')

impixelinfo(figure(2));

sz = size(I);
D0 = 10; W = 2;

HBW = ones(sz(1),sz(2));
for u = 1:sz(1)
    for v = 1:sz(2)
        D = sqrt((u-sz(1)/2)^2 + (v-sz(2)/2)^2);
        HBW(u,v)=1/(1+((D*W/(D^2-D0^2))^8));
    end
end

figure(3);  
imshow(HBW,[]); title('Butterworth BandReject Filter');


BR = Fsh.*HBW;
figure(4);
imshow(BR,[]);
title('Band Reject');

IbSs = real(ifft2(ifftshift(BR)));%Changed 
figure(5);imshow(IbSs,[])
title('Clean Image');

%Noise Pattern through Band Pass Filter
G = (1-HBW).*Fsh;
NP = real(ifft2(ifftshift(G)))
figure(6); imshow(NP,[])
title('Noise Pattern');
%IbS = ifftshift(BR);
%IbSs = ifft2(IbS);
%figure(5);imshow(IbSs,[])

%title('Clean Image');
