function imDst = boxfilter(imSrc, r)  
  
%   BOXFILTER   O(1) time box filtering using cumulative sum  
%  
%   - Definition imDst(x, y)=sum(sum(imSrc(x-r:x+r,y-r:y+r)));  
%   - Running time independent of r;   
%   - Equivalent to the function: colfilt(imSrc, [2*r+1, 2*r+1], 'sliding', @sum);  
%   - But much faster.  
  
[hei, wid] = size(imSrc);  
imDst = zeros(size(imSrc));  
  
%cumulative sum over Y axis  
imCum = cumsum(imSrc, 1);  
%difference over Y axis  
imDst(1:r+1, :) = imCum(1+r:2*r+1, :);  
imDst(r+2:hei-r, :) = imCum(2*r+2:hei, :) - imCum(1:hei-2*r-1, :);  
imDst(hei-r+1:hei, :) = repmat(imCum(hei, :), [r, 1]) - imCum(hei-2*r:hei-r-1, :); 
   
%cumulative sum over X axis  
imCum = cumsum(imDst, 2);  
%difference over X axis  
imDst(:, 1:r+1) = imCum(:, 1+r:2*r+1);  
imDst(:, r+2:wid-r) = imCum(:, 2*r+2:wid) - imCum(:, 1:wid-2*r-1);  
imDst(:, wid-r+1:wid) = repmat(imCum(:, wid), [1, r]) - imCum(:, wid-2*r:wid-r-1);  
end  


% 一共三个表 第一个表是原图 也就是ImSrc 第一部分的Imcum的第n行是原图前n行相加的值 然后 ImDst是一个空表 他的第一行到第R+1行
% 是Imcum的第1+r行到第2*r+1行，这就是第一部分，第二部分是用后几行的位置 减去前几行的位置 最后差R行 就复制R遍最后一行 用
% 最后一行去减去