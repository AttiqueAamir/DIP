I2 = imread('Img-1.tif');
I = im2double(I2)
%subplot(4,4,1);
figure(1);
imshow(I)
title('Noisy Image');

%Fourier Transform
F = fft2(I);

%S = abs(F);
Fsh = fftshift(F);
%S = abs(F);
S2 = log(1+abs(Fsh));
figure(2);
%subplot(4,4,2);
imshow(S2,[])
title('Fourier Transformed Spectrum')

%impixelinfo(figure(2));

sz = size(I)
D0 = 10;%Changed
%h=figure;
%datacursormode(S2,'on')
%h=figure;

HNR1 = ones(sz(1),sz(2));
HNRplus1 = ones(sz(1), sz(2));
HNRneg1 = ones(sz(1),sz(2));

for u = 1:sz(1)
    for v = 1:sz(2)
        D1 = sqrt((u-sz(1)/2-80)^2 + ((v-sz(2)/2)-35)^2);% + sqrt((u-sz(1)/2-55)^2 + ((v-sz(2)/2)-86)^2);
        Dnv1 = sqrt((u-sz(1)/2+80)^2 + ((v-sz(2)/2)+35)^2);% + sqrt((u-sz(1)/2+55)^2 + ((v-sz(2)/2)+86)^2);
        HNRplus1(u,v) = 1/(1+(D0/D1)^8);%Changed
        HNRneg1(u,v) = 1/ (1+(D0/Dnv1)^8);%Changed
    end
end

HNR1 = HNRplus1.*HNRneg1;

HNR2 = ones(sz(1),sz(1));
HNRplus2 = ones(sz(1), sz(2));
HNRneg2 = ones(sz(1),sz(2));

for u = 1:sz(1)
    for v = 1:sz(2)
        D2 = sqrt(((u-sz(1)/2)-40)^2 + (((v-sz(2)/2)-30)^2));
        Dnv2 = sqrt(((u-sz(1)/2)+40)^2 + (((v-sz(2)/2)+30)^2));
        HNRplus2(u,v) = 1/(1+(D0/D2)^8);%Changed
        HNRneg2(u,v) = 1/ (1+(D0/Dnv2)^8);%Changed
    end
end

HNR2 = HNRplus2.*HNRneg2;

HNR3 = ones(sz(1),sz(2));
HNRplus3 = ones(sz(1), sz(2));
HNRneg3 = ones(sz(1),sz(2));

for u = 1:sz(1)
    for v = 1:sz(2)
        D3 = sqrt((u-sz(1)/2-(40))^2 + ((v-sz(2)/2)-(-25))^2);
        Dnv3 = sqrt((u-sz(1)/2+(40))^2 + ((v-sz(2)/2)+(-25))^2);
        HNRplus3(u,v) = 1/(1+(D0/D3)^8);%Changed
        HNRneg3(u,v) = 1/ (1+(D0/Dnv3)^8);%Changed
    end
end

HNR3 = HNRplus3.*HNRneg3;

HNR4 = ones(sz(1),sz(2));
HNRplus4 = ones(sz(1), sz(2));
HNRneg4 = ones(sz(1),sz(2));

for u = 1:sz(1)
    for v = 1:sz(2)
        D4 = sqrt((u-sz(1)/2-80)^2 + ((v-sz(2)/2)-(-25))^2);
        Dnv4 = sqrt((u-sz(1)/2+80)^2 + ((v-sz(2)/2)+(-25))^2);
        HNRplus4(u,v) = 1/(1+(D0/D4)^8);%Changed
        HNRneg4(u,v) = 1/ (1+(D0/Dnv4)^8);%Changed
    end
end

HNR4 = HNRplus4.*HNRneg4;

%HNR1234 = HNR1.*HNR2.*HNR3.*HNR4;
HNR1234 = HNR1.*HNR2.*HNR3.*HNR4;

%figure(3);imshow(HNR1,[])
%figure(3);imshow(HNR1,[])
%title('Butterworth Notch Reject Filter');

figure(3);imshow(HNR1234,[])
%figure(3);imshow(HNR1,[])
title('Butterworth Notch Reject Filter');

M = Fsh.*HNR1234;%Changed
figure(4);
%subplot(4,4,3);
 imshow(M,[])
title('Noise Blackout');


%IbS = ifftshift(M);
IbSs = real(ifft2(ifftshift(M)));%Changed 
figure(5);imshow(IbSs,[])
title('Clean Image');

%Noise Pattern through Notch Pass Filter

G = (1-HNR1234).*Fsh;
NP = real(ifft2(ifftshift(G)))
figure(6); imshow(NP,[])
%Gs = ifftshift(G);
%GsS = ifft2(Gs);
%S3 = log(1+abs(Fsh));
%subplot(4,4,4)
%figure(7); imshow(GsS,[])
title('Noise Pattern');