function out = stltool(fname)
% Spectral time-lapse generation code (stltool)
% Written by Christopher R Madan
% Last edited 20131102 [CRM]
%
% Copyright (C) 2013 Madan & Spetch
%
% This program is free software: you can redistribute it and/or 
% modify it under the terms of the GNU General Public License as 
% published by the Free Software Foundation, either version 3 of
% the License, or (at your option) any later version. 
%
% This program is distributed in the hope that it will be 
% useful, but WITHOUT ANY WARRANTY; without even the implied 
% warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
% PURPOSE. See the GNU General Public License for more details. 
%
% You should have received a copy of the GNU General Public 
% License along with this program. If not, see 
% <http://www.gnu.org/licenses/>. 

disp(' ')
config
configCustom
storeConfig

loadRawVideo
out.framesSTLSampled = k;
out.ppsSTL = pps;
checkFrames
out.framesSTLKept = nUse;
colorizeFrames
genstl

if doPath == 1
    
    if pathSampling ~= 0
        % if the sampling rate is different
        % we need to re-acquire the raw data and pre-process it
        sampling = pathSampling;
        loadRawVideo
        out.framesPathSampled = k;
        out.ppsPath = pps;
        checkFrames
        out.framesPathKept = nUse;
        col = eval(sprintf('%s(nUse)',cmap));
    end
    
    calcPath
    
end

if doVel == 1
    if doPath == 0
        warning('STLtool: Path analysis must be enabled to calculate velocity-acceleration plot.')
    else
        calcVel
    end
end


% sort fields within struct
out = orderfields(out);

if debugOn == 1
    keyboard
end

