# Spectral time-lapse (STL) Toolbox

### Description
The spectral time-lapse (STL) algorithm is designed to be a simple and efficient technique for analyzing and presenting both spatial and temporal information of animal movements within a two-dimensional image representation. The STL algorithm re-codes an animal's position at every time point with a time-specific color, and overlaid it over a reference frame of the video, to produce a summary image. It additionally incorporates automated motion tracking, such that the animal's position can be extracted and summary statistics such as path length and duration can be calculated, as well as instantaneous velocity and acceleration. This toolbox implements the STL algorithm as a MATLAB toolbox and allows for a large degree of end-user control and flexibility.

## More Information
The STL algorithm is described in detail here:

Madan CR and Spetch ML. Visualizing and quantifying movement from pre-recorded videos: The spectral time-lapse (STL) algorithm. F1000Research 2014, 3:19 (doi: 10.12688/f1000research.3-19.v1)
http://f1000research.com/articles/3-19/v1

The published version of the toolbox is also available on Zenodo:

ZENODO: Spectral time-lapse (STL) Toolbox. doi: 10.5281/zenodo.7663

### Illustration of the STL algorithm, the component stages, and examples of images at each stage
![STL algorithm workflow](https://f1000researchdata.s3.amazonaws.com/manuscripts/3552/193aaf33-a169-4c5d-baa3-e400f0da1a85_figure2.gif)
