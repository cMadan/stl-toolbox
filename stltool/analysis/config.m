% Config settings for spectral time-lapse generation code (stltool)
% Written by Christopher R Madan
% Last edited 20131102 [CRM]
% Requires Statistics Toolbox (nanmean,normpdf)
% Requires Image Processing Toolbox (imresize,regionprops)

%% general settings
% debug on? (activates 'interactive' mode at end of STL code)
debugOn         = 0;
% is the target lighter or darker than the background area?
% set to 1 for lighter, -1 for darker
target          = -1;
% plot position from every i-th frame
% most videos are at 30 frames per second (30 Hz; NTSC)
sampling        = 30;
% video speed
% has the video frame rate been adjusted relative to the original
% recording? 
% set to 1 if not
% set to .1 if used high-speed camera and slowed down by 10x
videospeed      = 1;
% threshold for detecting change in frame
% if this is too low, there will be lots of 'speckle' (random noise)
% if this is too high, too few/no usable frames will be detected
threshMask      = 50;
% block size of legend bars (height/width of each block, in px)
barSize         = 8;
% length of time bar (in seconds)
timeBar         = 1;
% display STL image? (will be saved regardless)
showSTL         = 0;
% paths for input raw videos and output ot STL images
path_raw        = '../raw/';
path_out        = '../output/';


%% frame range
% starting frame, used to manually remove the first i frames
% must be in quotes
startFrame      = '1';        
% last frame, use 'lastFrame' for the last frame of the video
% must be in quotes
endFrame        = 'lastFrame';    
% reference frame for subtraction (usually '1' or 'end')
% must be in quotes
% use 'move' for a moving average, can be a bit slow
refFrame        = 'end';      
% if using moving average, how should frames be weighted 
% (temporal smoothing)
% list of values should be odd in length
% middle value should be 0, so weight for 'current' frame is 0
% absolute values don't matter, will be normalized to sum to 1
refSmooth       = [ 4:-1:1 repmat(0,1,5) 1:1:4 ];


%% frame spatial (masking)
% mask out a region of the frame if desired
doMask          = 1;
% if using doMask, specify mask filename (within path_raw)
maskName        = 'mask.tif';
% auto-mask white?
% E.g., if there was a hard-coded timestamp
cleanWhite      = 1;
% lower end of what to trim as 'white'
white           = 120;



%% frame temporal settings (trimming, change detection)
% disable auto-trimming of start and end frames
disableTrim     = 0;
% threshold for automatically trimming start and end frames
% checks for differences between start/end frames and reference frame
% if there little difference, removes the frames
% (proportion of total frame)
threshTrim      = .004;
% threshold for detecting changes between adjacent frames
% used for the white/black bar to detect differences between adjacent
% frames
threshAdjac     = 0.4;


%% STL colorization settings
% set color map
% 'hsv' - recommended, one color cycle
% 'dhsv' - custom colormap for two cycles of hsv
% (dhsv = double hsv)
cmap            = 'dhsv';  
% increase brightness of reference image (refFrame) by x
oversatRef      = 2;        
% increase saturation of colorized frames by x
oversatCol      = 20;
% smoothing kernel range
% improves detection of change, reduces effects of random noise
smooth          = -1:1;  


%% path analysis settings
% calculate path image?
doPath          = 1;
% background image for path
% 'stl' or 'ref'
pathBack        = 'stl';
% color for arrows and marker circles
% usually 'k' or 'w' (black or white)
pathCol         = 'k';
% different sampling rate for path analysis?
% for same rate just type: 0
% for double the STL sampling frequency: sampling/2
pathSampling    = 30/5;
% minimum area for tracked
% set to 0 for no minimum
areamin         = 200;
% path output units
% how many px in a meter
% set to 0 to report as pixels
px2m            = 0;


%% velocity-acceleration plot settings
% calculate velocity-acceleration plot?
doVel           = 1;
% smooth instantaneous velocity/arousal with a kernel
velSmooth       = -3:.2:3;
