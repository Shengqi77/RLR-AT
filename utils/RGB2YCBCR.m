% clc,clear;
function [Y,Cb,Cr,img_ycbcr] = RGB2YCBCR(RGB_image)
% RGB_image = im2double(imread('./MRI_SPECT/SPETCT/SPECT.png'));
R = RGB_image(:,:,1);
G = RGB_image(:,:,2);
B = RGB_image(:,:,3);

Y = 0.299 * R + 0.587 * G + 0.114 * B;
Cb = -0.1687 * R - 0.3313 * G + 0.5 * B + 128/255.0;
Cr = 0.5 * R - 0.4187 * G - 0.0813 * B + 128/255.0;

[w,h,~] = size(RGB_image);
img_ycbcr = zeros(w,h,3);
img_ycbcr(:,:,1) = Y;
img_ycbcr(:,:,2) = Cb;
img_ycbcr(:,:,3) = Cr;
end
