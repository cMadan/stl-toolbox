function wrapper(fname)

disp(' ')
config
configCustom

loadRawVideo
checkFrames

% save raw frames of usable frames
path_export = [path_out fname(1:(end-4)) '/'];
mkdir(path_export)

% loop through frames
for i = 1:nUse
    % get frame data
    thisFrame = mov(:,:,i + usableFirst - 1)/255;
    
    % export raw frames
    imwrite(thisFrame,[ path_export sprintf('frame%04.0f.tif',i) ]); 
end

% reference frame
i = 0;
thisFrame = mov(:,:,end)/255;
imwrite(thisFrame,[ path_export sprintf('frame%04.0f.tif',i) ]); 

disp('Raw frames exported')