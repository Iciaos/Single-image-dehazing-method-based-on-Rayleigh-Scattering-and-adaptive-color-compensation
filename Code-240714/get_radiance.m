function radiance = get_radiance(image, transmission, atmosphere )
[m, n, ~] = size(image);
rep_atmosphere = repmat(reshape(atmosphere, [1, 1, 3]), m, n);
HCC=0;
p=0;
t0=0.1;
K = 0.3;
win_size=15;
light_channel = get_light_channel(image, win_size);
A = 0.13;
for A=0.13:0.01:0.7
   for i = 1:1:m
    for j = 1:1:n
            if (light_channel(i,j)>A)
            for k = 1:1:3 
            radiance(i,j,k) = (image(i,j,k)-atmosphere(k)) ./ max(transmission(i,j),t0) + atmosphere(k);%原暗通道
            end
         else 
             for k = 1:1:3 
             s=K./(abs(image(i,j,k)-atmosphere(k)));
            radiance(i,j,k) = (image(i,j,k)-atmosphere(k)) ./ min((max(s,1).*max(transmission(i,j),t0)),1)+atmosphere(k);%针对天空，白色区域消除光晕效果
            end
           end
        end
   end
    
    [H]=color_corrlation(radiance,image);
     if(HCC<H)
        HCC=H;
         continue;
     else
         H
         break;  
     end
end
A=A-0.01

end