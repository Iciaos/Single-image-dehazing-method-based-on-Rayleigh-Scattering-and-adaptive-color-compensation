function atmosphere = get_atmosphere(image, dark_channel)

HCC=-10;
p=image;
II=p;
r = 10; 
eps = 0.4^2; 
[m, n, ~] = size(image);
a=1;
omega=0.95;
win_size=15;
image(:, :, 1) = guided_filter(image(:, :, 1), p(:, :, 1), r, eps);
image(:, :, 2) = guided_filter(image(:, :, 2), p(:, :, 2), r, eps);
image(:, :, 3) = (image(:, :, 1)+image(:, :, 2))./2*a;
n_pixels = m * n;
n_search_pixels = floor(n_pixels * 0.01); 
dark_vec = reshape(dark_channel, n_pixels, 1);
image_vec = reshape(image, n_pixels, 3);
[~, indices] = sort(dark_vec, 'descend');
accumulator = zeros(1, 3);
for k = 1 : n_search_pixels
    accumulator = accumulator + image_vec(indices(k),:);
end
atmosphere = accumulator / n_search_pixels;

I = II;
aa = (atmosphere(1)+atmosphere(2))/2+0.04;
bb = (atmosphere(1)+atmosphere(2))/2-0.04;
K = bb;
for K=bb:0.04:aa
    atmosphere(3) = K+0.04
    trans_est = get_transmission_estimate(I, atmosphere, omega, win_size);
    tl = get_transmission_estimatel(I, atmosphere, omega, win_size);
    x = guided_filter(rgb2gray(I), trans_est, 15, 0.001);
     transmission = reshape(x, m, n);
    radiance= Copy_of_get_radiance(I, transmission, atmosphere);
    H = color_corrlation(I,radiance)
     if(HCC<H)
        HCC=H;
         continue;
     else
         H
         break;  
     end
end
atmosphere(3)=atmosphere(3)-0.04




end