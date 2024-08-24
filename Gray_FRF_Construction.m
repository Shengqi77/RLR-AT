function FRF_ref = FRF_Construction(stack,sigma)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FRF_ref = registration_main(stack, sigma)
% This function is the main routine for the Frequency-aware Reference Construction part
% (section 4.1 in the paper)
% Input: stack - Input sequence (Generally, the more frames there are, the better the result)
%        sigma  -  The sensitivity of weight function to frequency
% Output: FRF_ref - Constructed FRF Reference Frame
% Shengqi Xu, Run Sun, Yi Chang
% Copyright ECCV 2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FRF_ref = zeros(size(stack,1),size(stack,2));
for x = 1:size(stack,1)
    for y = 1:size(stack,2)
        pixs = stack(x,y,:);
        pix_times = tabulate(pixs(:));
        idx_zeros = any(pix_times==0,2);
        pix_times = pix_times(~idx_zeros, :);
        pix_itens = pix_times(:,1);
        pix_fre = pix_times(:,2);
        FRF_ref(x,y) = sum(pix_itens.*exp(sigma*pix_fre))./sum(exp(sigma*pix_fre));
    end
end
end