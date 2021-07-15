%% Script for counting folders of images
% This script will automatically count cells of all images in a defined
% folder using an automatic segmentation. It utilizes the cellcount.m
% function. 

% This script is written by Tom Niessink, 15-7-2021
% As part of a master Thesis 'In flow magnetophoresis'

clear; close all; clc;


Files = dir('foldername_here');     % Define folder name

filtersize = 3;                     % Size of the erosion filter    
totalcount = 0;                     % Start with 0 cells

for k=1:length(Files)               % Walk through the files
    FileName=Files(k).name;
    if Files(k).isdir == false
    im = imread(FileName);
        if size(im,3) == 3
            im = rgb2gray(im);
        else    
        end
        
    % Perform counting
    treshold = round(mean(mean(im))+.5*(mean(max(im))-mean(mean(im))));
    [cellcount,cellimage]=countcells(im,filtersize,treshold);
    totalcount = totalcount+cellcount; 
    
        
    else
    end
end

