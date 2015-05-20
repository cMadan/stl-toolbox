disp(sprintf('Processing video file "%s"',fname))
vid = VideoReader([path_raw fname]);

vidHeight   = vid.Height;
vidWidth    = vid.Width;
lastFrame   = vid.NumberOfFrames;

% export this info
out.fname       = fname;
out.vidHeight   = vidHeight;
out.vidWidth    = vidWidth;
out.vidFPS      = vid.FrameRate;

% detect color (Gray[1] or RGB[3])
if std(mean(mean(read(vid,1)))) == 0
    cdepth = 1;
else
    cdepth = 3;
end
out.vidCDepth = cdepth;

% Preallocate movie structure.
j = eval(sprintf('%s:sampling:%s',startFrame,endFrame));
mov = zeros([vidHeight vidWidth length(j)]);

% Read every k-th frame (based on sampling rate)
disp(sprintf('Reading from raw video (%g Frames)',length(j)))
for k = 1:length(j)
    thisFrame = read(vid, j(k));
    if cdepth == 1 % Gray
        mov(:,:,k) = thisFrame(:,:,1);
    elseif cdepth == 3 % RGB ->gray
        mov(:,:,k) = mean(thisFrame,3);
    end
    
    % update progress
    fprintf('.')
end
fprintf('\n')

% load mask if needed
if doMask == 1
    mask = imread([ path_raw maskName ]);
    mask = mean(mask,3);
end

% calculate sampling rate in pps
pps = vid.FrameRate/sampling/videospeed;
disp(sprintf('Video is being sampled at one position per %.02f seconds (%.01f pps)',sampling/vid.FrameRate*videospeed,pps))