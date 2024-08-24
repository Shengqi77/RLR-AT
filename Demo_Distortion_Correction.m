%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demo code for CDSP
%
% Reference:
%   title={Long-range Turbulence Mitigation: A Large-scale Dataset and A Coarse-to-fine Framework},
%   author={Xu, Shengqi and Sun, Run and Chang, Yi and Cao, Shuning and Xiao, Xueyao and Yan, Luxin},
%   journal={arXiv preprint arXiv:2407.08377},
%   year={2024}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

addpath(genpath('./downloads'))
addpath(genpath('./utils'))

% set input path and load data
input_dir = './data/Building/';
imgs = dir([input_dir '*.png']);
for i = 1:length(imgs)
    temp = imread([input_dir imgs(i).name]);
    if size(temp,3) == 3
        temp = rgb2gray(temp);
    end
    stack(:,:,i) = double(temp);
end


% registration step
fprintf('===========================\n');
fprintf('CDSP, 2024 ECCV\n');
fprintf('===========================\n');

% Step1: Frequency-aware Reference Frame Construction
fprintf('Step 1: Frequency-aware Reference Frame Construction\n')
sigma = 0.2;%The sensitivity of weight function to frequency
FRF_ref = Gray_FRF_Construction(stack, sigma);
fprintf('\n');


% Step2: FRF-based Image Registraion
fprintf('Step 2: FRF-based Image Resgistration \n')
load reg_par.mat
Num = 15;%Number of images to register
Registered = Image_resgistraion(stack, FRF_ref, Num, reg_parameters);
fprintf('\n');

%Step 3: Low-rank Tensor Refinement
fprintf('Step 3: Low-rank Tensor Refinement \n')
nSig = 5;
refine_parameters   = ParSet(nSig); 
Refined = Tensor_refinement(Registered,refine_parameters);
fprintf('\n');
fprintf('Done. Display results.\n');

figure;
subplot(121);
imshow(uint8(stack(:,:,1))); title('input: Frame 1');
subplot(122);
imshow(uint8(Refined(:,:,1)*255)); title('processed: Frame 1');

% %save result
% imwrite(uint8(Refined(:,:,1)*255),['./result/Building_out.png']);


