# Spectral time-lapse (STL) Toolbox

### Description
The spectral time-lapse (STL) algorithm is designed to be a simple and efficient technique for analyzing and presenting both spatial and temporal information of animal movements within a two-dimensional image representation. The STL algorithm re-codes an animal's position at every time point with a time-specific color, and overlaid it over a reference frame of the video, to produce a summary image. It additionally incorporates automated motion tracking, such that the animal's position can be extracted and summary statistics such as path length and duration can be calculated, as well as instantaneous velocity and acceleration. This toolbox implements the STL algorithm as a MATLAB toolbox and allows for a large degree of end-user control and flexibility.

## More Information
The STL algorithm is described in detail here:

Madan CR and Spetch ML. Visualizing and quantifying movement from pre-recorded videos: The spectral time-lapse (STL) algorithm. F1000Research 2014, 3:19 (doi: 10.12688/f1000research.3-19.v1)
http://f1000research.com/articles/3-19/v1

The published version of the toolbox is also available on Zenodo:

ZENODO: Spectral time-lapse (STL) Toolbox. doi: 10.5281/zenodo.7663
https://zenodo.org/record/7663

### Illustration of the STL algorithm and examples of images at each stage
![STL algorithm workflow](https://raw.githubusercontent.com/cMadan/stl-toolbox/master/stl_workflow.gif)

### Example output

```
>> data = stltool('S-Video_20110718_1132.avi');
 
Processing video file "S-Video_20110718_1132.avi"
Reading from raw video (46 Frames)
..............................................
Video is being sampled at one position per 1.00 seconds (1.0 pps)
Checking frames for motion (46 Frames)
..............................................
Colorizing frames (25 Frames)
.........................
Calculating spectral timelapse (STL) image
STL generated ("STL_S-Video_20110718_1132.tif")
STL summarizes 25.02 seconds of video
Processing video file "S-Video_20110718_1132.avi"
Reading from raw video (228 Frames)
....................................................................................................................................................................................................................................
Video is being sampled at one position per 0.20 seconds (5.0 pps)
Checking frames for motion (228 Frames)
....................................................................................................................................................................................................................................
Detecting path
Path calculated ("STLpath_S-Video_20110718_1132.tif")
Total path length measured at 6.1424 m
Total path took 25.43 s
Velocity-acceleration plot generated ("STLvel_S-Video_20110718_1132.pdf")
ans = 
               config: [1x1 struct]
                fname: 'S-Video_20110718_1132.avi'
       framesPathKept: 127
    framesPathSampled: 228
        framesSTLKept: 25
     framesSTLSampled: 46
           pathLength: 6.1424
             pathTime: 25.4251
              ppsPath: 4.9951
               ppsSTL: 0.9990
              trackXY: [127x2 double]
               velAcc: [1x125 double]
               velVel: [1x126 double]
            vidCDepth: 1
               vidFPS: 29.9704
            vidHeight: 480
             vidWidth: 640
```
