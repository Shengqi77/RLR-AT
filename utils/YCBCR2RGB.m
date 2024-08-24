% addpath(genpath(pwd)); %将当前文件夹下的所有文件夹都包括进调用函数的目录
% clc,clear;
function [ycbcr_img] = YCBCR2RGB(Y,Cb,Cr)
[w,h] = size(Y);
ycbcr_img = zeros(w,h,3);

ycbcr_img(:,:,1) = Y+1.402*(Cr-128/255.0);
ycbcr_img(:,:,2) = Y-0.344*(Cb-128/255.0)-0.714*(Cr-128/255.0);
ycbcr_img(:,:,3) = Y+1.772*(Cb-128/255.0);
end
