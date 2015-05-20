% put custom settings for specific videos here

if strcmp(fname,'ant.avi')
    threshMask      = 80;
    cmap            = 'hsv';
    sampling        = 30;
    pathSampling    = 3;
    px2m            = 100/(5/393);      % 393 px    ==  5 cm
    videospeed      = .1;
    timeBar         = 1;
    doMask          = 0;
    cleanWhite      = 0;
elseif strcmp(fname,'radial.avi')
    target          = 1;
    cmap            = 'hsv';
    startFrame      = '3178';
    endFrame        = '3530';
    sampling        = 10;
    refFrame        = '1';
    smooth          = -2:2:2;
    threshMask      = 30;
    pathSampling    = 1;
    pathBack        = 'ref';
    pathCol         = 'w';
    px2m            = 100/(100/330.5);  % 330.5 px    ==  100 cm
    timeBar         = 1;
    doMask          = 0;
    cleanWhite      = 0;
elseif strfind(fname,'S-Video')
    timeBar         = 10;
    px2m            = 100/(32/68.56);   % 68.56 px  == 32 cm
end