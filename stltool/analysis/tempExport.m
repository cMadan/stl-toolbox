path_export = [path_out fname(1:(end-4)) '/'];
mkdir(path_export)

for i = 1:nUse
    % get frame data
    thisFrame = smoothFrame(:,:,i + usableFirst - 1)/255;
    
    % export raw frames
    imwrite(thisFrame,[ path_export sprintf('smooth%04.0f.tif',i) ]); 
end
% reference frame
i = 0;
thisFrame = smoothFrame(:,:,45)/255;
imwrite(thisFrame,[ path_export sprintf('smooth%04.0fa.tif',i) ]);
thisFrame = smoothFrame(:,:,44)/255;
imwrite(thisFrame,[ path_export sprintf('smooth%04.0fb.tif',i) ]);

for i = 1:nUse
    % get frame data
    thisFrame = colFrame(:,:,:,i);
    
    % export raw frames
    imwrite(thisFrame,[ path_export sprintf('color%04.0f.tif',i) ]); 
end

colorizeFrames

%collapse frames for time lapse
m = nanmean(colFrame,4);

% clean up background space
m(find(m<0)) = 0;
m(find(isnan(m))) = 0;

% scale intensities and average in the background
m = m/25;
m = rgb2hsv(m);
m2 = m(:,:,2);
m2 = m2*oversatCol;
m2(find(m2>1)) = 1;
m(:,:,2) = m2;
m = hsv2rgb(m);
m = m/.06;

imwrite(m,[ path_export sprintf('colorNoRef.tif',i) ]); 
