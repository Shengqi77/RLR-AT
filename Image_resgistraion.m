function Registered = Image_resgistraion(stack, FRF_ref, Num, reg_parameters)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Registered = Image_resgistraion(stack,FRF_ref,reg_parameters)
% This function is the main routine for the image registration part
% Input: stack - Input sequence
%        Num   - Number of images to register(You can choose any number of images to register; we default to 15 here, as we believe it's sufficient to achieve a good output)
%        FRF_ref  -  Frequency-aware reference frame
%        reg_parameters  -  parameters for optical flow (We use optical flow for image registration)
% Output: Registered- Each registered frame
% Reference: We use the optical flow function from: 
%            Ce Liu, "Beyond pixels: Exploring new representations and
%            application for motion analysis", Ph.D. dissertation, MIT, 2009
% Shengqi Xu, Run Sun, Yi Chang
% Copyright ECCV 2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Registered = zeros(size(stack, 1), size(stack, 2),size(stack,3), Num);
Registered = zeros(size(stack, 1), size(stack, 2), Num);
stack = stack/255;
FRF_ref = FRF_ref/255;
for idx = 1:Num
    [vx,vy,warpI2] = Coarse2FineTwoFrames(FRF_ref,stack(:,:,idx),reg_parameters);
    Registered(:,:,idx) = warpI2;
end

end