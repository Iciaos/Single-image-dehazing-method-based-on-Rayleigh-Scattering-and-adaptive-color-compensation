function trans_est2 = get_transmission_estimatel(image, atmosphere, omega, win_size)


[m, n, ~] = size(image);
for i = 1:3
    I(i) = 1-atmosphere(i);
end

rep_atmosphere = repmat(reshape(atmosphere, [1, 1, 3]), m, n);
II = repmat(reshape(I, [1, 1, 3]), m, n);
light_channel = get_light_channel( image, win_size);
aa = zeros(m,n,3);
for i = 1:3
   aa(:,:,i) =  light_channel;
end
trans_estl = omega * (aa-rep_atmosphere)./II;
trans_est2 = zeros(m,n);
for z = 1:m
   for q = 1:n
       trans_est2(z,q) = max(max(trans_estl(z,q,1),trans_estl(z,q,2)),trans_estl(z,q,3));
   end
end


end