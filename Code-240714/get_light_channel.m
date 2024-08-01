function z_channel = get_light_channel(image, win_size)
%
[m, n, ~] = size(image);
light_channel = zeros(m, n);
d_channel = zeros(m, n);
for j = 1 : m
    for i = 1 : n
        light_channel(j,i) = max(max(image(j,i,1),image(j,i,2)),image(j,i,3));
     end
end

for j = 1 : m
    for i = 1 : n
        d_channel(j,i) = min(min(image(j,i,1),image(j,i,2)),image(j,i,3));
     end
end

z_channel=light_channel-d_channel;

end