% generate smoothing kernel
kern = normpdf(smooth,0,1)'*normpdf(smooth,0,1)/.16; % normpdf requires Image Processing Toolbox
smoothFrame = zeros([vidHeight vidWidth k]);

% get reference frame
if ~strcmp(refFrame,'move')
    ref = eval(sprintf('mov(:,:,%s)',refFrame));
    refBG = ref;
    
    % clean white?
    if cleanWhite == 1
        ref(find(ref>white)) = 0;
    end
    
else
    tic
    % calculate moving average reference
    refSmooth = refSmooth/sum(refSmooth);
    for a = 1:size(mov,1)
        for b = 1:size(mov,2)
            refavg(a,b,:) = conv(squeeze(mov(a,b,:)),refSmooth,'same');
        end
    end
    disp(sprintf('Calculated moving average reference in %.02f seconds.',toc))
end

% determine total number of pixels in frame
nPix = vidHeight*vidWidth;

disp(sprintf('Checking frames for motion (%g Frames)',k))


for i = 1:k
    % if using moving average, calculate it
    if strcmp(refFrame,'move')
        ref = refavg(:,:,i);
    end
    
    % get the frame
    thisFrame = mov(:,:,i);
    
    % clean white?
    if cleanWhite == 1
        thisFrame(find(thisFrame>white)) = 0;
    end
    
    % apply smoothing kernel, flip image for target if needed, clean noise
    thisFrame = conv2((thisFrame-ref),kern,'same');
    thisFrame = target*thisFrame;
    thisFrame(find(thisFrame<0))=0;
    
    % apply mask if needed
    if doMask == 1
        thisFrame(find(mask==0)) = 0;
    end
    
    % determine number of pixels above threshold
    nThresh = length(find(thisFrame > threshMask ));
    
    % check if any changes have occured on this frame
    % must be at least threshTrim % to count as a change
    % minimum accounts for irrelevant changes such as timestamps
    frameThresh(i) = nThresh/nPix;
    if frameThresh(i) < threshTrim & disableTrim == 0
        % frame contained no movement
        changeDetected(i) = 0;
    else
        % frame contains movement
        changeDetected(i) = 1;
    end
    
    % store data only if some change has occured before this point
    if sum(changeDetected) > 0
        smoothFrame(:,:,i) = thisFrame;
    end
    
    % update progress
    fprintf('.')
end
fprintf('\n')

% detect start and end of movement
usableFirst = min(find(changeDetected));
usableLast = max(find(changeDetected));
nUse = usableLast-usableFirst+1;