% run stltool on all images in 'raw' folder
config
f = dir([path_raw '*.avi']);
fname = {f.name};

fname = fname(1);
% also a few others to test then...

for i = 1:length(fname)
    stltool(fname{i})
end
