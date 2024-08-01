clc;
clear all;
close all;
tic
I = double(imread('1.png')) / 255;
p=I;
figure,imshow(I);title('有雾图像');
omega=0.95;
win_size=15;
r = 10; 
eps = 0.4^2; 
 [m, n, ~] = size(I);
dark_channel = get_dark_channel(I ,15);
atmosphere = get_atmosphere(I, dark_channel);%

light_channel = get_light_channel(I ,15);
trans_est = get_transmission_estimate(I, atmosphere, omega, win_size);
tl = get_transmission_estimatel(I, atmosphere, omega, win_size);
x = guided_filter(rgb2gray(I), trans_est, 15, 0.001);
transmission = reshape(x, m, n);
radiance= get_radiance(I, transmission, atmosphere);

toc
disp(['运行时间: ',num2str(toc)]);


