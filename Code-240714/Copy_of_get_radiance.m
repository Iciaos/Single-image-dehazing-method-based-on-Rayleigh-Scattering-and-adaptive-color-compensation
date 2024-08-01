function radiance = Copy_of_get_radiance(image, transmission, atmosphere )
[m, n, ~] = size(image);
rep_atmosphere = repmat(reshape(atmosphere, [1, 1, 3]), m, n);

p=0;
t0=0.1;
K = 0.2;
win_size=15;
light_channel = get_light_channel(image, win_size);

for i = 1:1:m
    for j = 1:1:n
           if (light_channel(i,j)>0.23)
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

end