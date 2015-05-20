if strfind(fname,'S-Video')
%    smoothFrame(375:410,560:585,:) = 0;
%    smoothFrame(300:375,150:190,:) = 0;
    
elseif strcmp(fname,'radial.avi')
    smoothFrame(:,:,1) = NaN;
    smoothFrame(180:220,300:400,3:end) = 0;
    smoothFrame(400:end,1:170,:) = 0;
    smoothFrame(275:end,275:end,:) = 0;
end

