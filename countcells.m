function [cellcount,segmentedimage]=countcells(image,filtersize,treshold);
%% Script for counting cells in a grayscale image
image=imsharpen(image);
MASK = image(:,:)>treshold;
segmentedimage = image;
segmentedimage(~MASK) = 0;
segmentedimage(MASK) = 1;
SE = strel('disk',filtersize);
segmentedimage = imerode(segmentedimage,SE);

CC = bwconncomp(segmentedimage);
cellcount=CC.NumObjects;
