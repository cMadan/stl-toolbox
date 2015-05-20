function showFrameK(fname,k)

config

if nargin == 1
    k = 1;
end

startFrame      = sprintf('%g',k);
endFrame        = 'lastFrame';
sampling        = 1e10;

loadRawVideo

imagesc(mov)
colormap(gray)