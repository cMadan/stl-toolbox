disp('Detecting path')
calcPathCustom

% get the x- and y-coordinates
for i = 1:nUse
    % get frame data
    thisFrame = smoothFrame(:,:,i + usableFirst - 1);
    
    % find centroid
    threshFrame = thisFrame>threshMask;
    pos = regionprops(threshFrame,'centroid','area');
    vals = cat(2,cat(1, pos.Centroid),cat(1,pos.Area));
    [ma,idx]=max(vals(:,3));
    maxarea(i) = ma;
    posX = vals(idx,1);
    posY = vals(idx,2);
    
    trackXY(i,:) = [ posX posY ];
    
end

% re-estable nUse
if areamin > 0
    mamin = find(maxarea>areamin);
    pUsableFirst = usableFirst;
    usableLast = max(mamin)+pUsableFirst;
    usableFirst = min(mamin)+pUsableFirst;
    nUse = usableLast-usableFirst+1;
    trackXY = trackXY((usableFirst-pUsableFirst):(usableLast-pUsableFirst),:);
end

figure
% get background
if strcmp(pathBack,'stl')
    % read in STL
    m = imread([ path_out 'STL_' fname(1:(end-4)) '.tif']);
    
elseif strcmp(pathBack,'ref')
    % read from raw video, in case there was color info that was removed
    m = double(read(vid,eval((sprintf('j(%s)',refFrame)))))/255;
end
image(m)
pathWidth   = size(m,2);
pathHeight  = size(m,1);
hold on
pbaspect([pathWidth pathHeight 1])

% add arrows
if ~exist('arrow3')
    % warn them that figs are better with arrow3
    warning('STLtool: Need arrow3 function to plot arrows in path figure, reverted to regular lines.')
end
global LineWidthOrder, LineWidthOrder=5;
for i = 1:nUse
    if i < nUse
        segLength(i) = sqrt(sum((trackXY(i,:)-trackXY(i+1,:)).^2,2));
        if segLength(i) > 0
            % only draw a line if there is one to draw
            % else arrow3 gives an error
            if exist('arrow3')
                % have arrow3? use it!
                arrow3(trackXY(i,:),trackXY(i+1,:),['/' pathCol],1,1);
            else
                % no arrow 3 package, just draw a regular line
                plot(trackXY(i:(i+1),1),trackXY(i:(i+1),2),'k','linewidth',5)
            end
        end
    end
    plot(trackXY(i,1),trackXY(i,2),['o' pathCol],'markerfacecolor',col(i,:),'linewidth',5,'markersize',20)
    %text(trackXY(i,1),trackXY(i,2),sprintf('%g',i))
end

% clean image settings
set(gca,'YTick',[])
set(gca,'XTick',[])
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 pathWidth/25 pathHeight/25])

% save path image
print([path_out 'STLpath_' fname(1:(end-4)) '.tif'],'-dtiff')
close

% re-load path image and clean up (auto-crop)
m = imread([ path_out 'STLpath_' fname(1:(end-4)) '.tif']);
crop_cols = find(sum(sum(255-m,3),1)>0);
crop_rows = find(sum(sum(255-m,3),2)>0);
m = m(crop_rows,crop_cols,:);
m = imresize(m,[ pathHeight pathWidth ]); % imresize requires Image Processing Toolbox
imwrite(m,[ path_out 'STLpath_' fname(1:(end-4)) '.tif'])

% calculate path length and time
disp(sprintf('Path calculated ("%s")',['STLpath_' fname(1:(end-4)) '.tif']))
pathLength = sum(sqrt(sum((trackXY(1:(end-1),:)-trackXY(2:end,:)).^2,2)));
pathTime = nUse / pps;

% convert path length and coordinates from px to m if necessary
if px2m == 0
    pathUnit    = 'px';
else
    pathLength  = pathLength / px2m;
    trackXY     = trackXY / px2m;
    pathUnit    = 'm';
end

% output path length and time
out.trackXY = trackXY;
disp(sprintf('Total path length measured at %.04f %s',pathLength,pathUnit))
out.pathLength = pathLength;
disp(sprintf('Total path took %.02f s',pathTime))
out.pathTime = pathTime;