% if no frames detected, note and abort
if length(nUse) == 0
    warning('STLtool: No frames detected, nothing to do.')
    break
end

% setup colorization based on usable frames
colFrame = zeros([vidHeight vidWidth 3 nUse]);
col = eval(sprintf('%s(nUse)',cmap));

disp(sprintf('Colorizing frames (%g Frames)',nUse))

% only for usable frames
for i = 1:nUse
    % get frame data
    thisFrame = smoothFrame(:,:,i + usableFirst - 1);
    
    % generate colorize matrix
    for d = 1:3
        colorize(:,:,d) = repmat(col(i,d),vidHeight,vidWidth);
    end
    
    % remove subthreshold data
    thisFrame(find(thisFrame < threshMask )) = NaN;
    
    % store data
    colFrame(:,:,:,i)=double(repmat(thisFrame,[1 1 3])/255.*colorize);
    
    % update progress
    fprintf('.')    
end
fprintf('\n')