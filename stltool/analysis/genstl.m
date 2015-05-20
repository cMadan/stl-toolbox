disp('Calculating spectral timelapse (STL) image')

%collapse frames for time lapse
m = nanmean(colFrame,4); % nanmean requires Statistics Toolbox

% clean up background space
m(find(m<0)) = 0;
m(find(isnan(m))) = 0;

% scale intensities and average in the background
m = m/25;
m = m + oversatRef*double(repmat(refBG,[1 1 3]))/255;
m(find(m<0)) = 0;
m(find(m>1)) = 1;

% amplify color saturation in HSV color space
m = rgb2hsv(m);
m2 = m(:,:,2);
m2 = m2*oversatCol;
m2(find(m2>1)) = 1;
m(:,:,2) = m2;
m = hsv2rgb(m);

% add time bar (default is 1 second)
m((end-(barSize*3+4):(end-3)),4:round(pps)*timeBar*barSize+5,:) = 0;
m((end-(barSize*3+3):(end-3)),5:round(pps)*timeBar*barSize+4,:) = 1;

% add overlap bar and color bar below
% first add black border
m((end-(barSize*2+4):(end-3)),4:nUse*barSize+5,:) = 0;
% mark frames of high-overlap (i.e., little movement between frames)
nnref = eval(sprintf('find(~isnan(sum(colFrame(:,:,:,%s),3)));',refFrame));
for i = 1:(nUse-1)
    nni = find(~isnan(sum(colFrame(:,:,:,i),3)));
    nni1 = find(~isnan(sum(colFrame(:,:,:,i+1),3)));    
    frameChange(i) = (length(intersect(nni,nni1))-length(intersect(nni,nnref)))/length(nni);
end
frameChange(nUse) = 0;
for d = 1:3
    m((end-3-barSize*2):(end-4-barSize),5:nUse*barSize+4,d) = repmat(reshape(repmat(frameChange > threshAdjac,barSize,1),[1 nUse*barSize])',1,barSize)';
    m((end-3-barSize):(end-4),5:nUse*barSize+4,d) = repmat(reshape(repmat(col(:,d),1,barSize)',[1 nUse*barSize])',1,barSize)';
end

% save STL image
imwrite(m,[ path_out 'STL_' fname(1:(end-4)) '.tif'])

% show STL image, if desired
if showSTL == 1
    image(m)
end

disp(sprintf('STL generated ("%s")',['STL_' fname(1:(end-4)) '.tif']))
disp(sprintf('STL summarizes %.02f seconds of video',nUse*sampling/vid.FrameRate*videospeed))