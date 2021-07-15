%% Script for counting cells
% This script will automatically count cells in a single image 
% using the countcells function, which segments the image, then
% detects and counts the number of cells.
% The user can define the segmentation such as deemed correct. 

% This script is written by Tom Niessink, 15-7-2021
% As part of a master Thesis 'In flow magnetophoresis'
clear; close all; clc;

% Load file and read image
filename = uigetfile('*');
im = imread(filename);

% Check if images are not RGB, if they are then convert to grayscale
if size(im,3) == 3
    im = rgb2gray(im);
else    
end

% Show image
figure(2)
imshow(im,[350 450])

% Make an estimation for the treshold
figure(1)
edit = true; 
treshold = round(mean(mean(im))+.5*(mean(max(im))-mean(mean(im))));
filtersize = 3;

% Perform the first segmentation, present to the user
[cellcount,cellimage]=countcells(im,filtersize,treshold);
C = imfuse(im+50,cellimage);
imshow(C)
title(['Treshold: ' num2str(treshold) ' Filtersize: ' ...
        num2str(filtersize) ' Cellcount: ' num2str(cellcount)])

    
while edit == true      % Allow the user to set the tresholding filter

    prompt = {'Enter threshold','Enter filter size','Finished (set to 1)'};
    definput = {num2str(treshold),num2str(filtersize),'0'};
    answer = inputdlg(prompt,'title',1,definput);
    treshold = str2num(answer{1});
    filtersize = str2num(answer{2});
    
    [cellcount,cellimage]=countcells(im,filtersize,treshold);
    C = imfuse(im+50,cellimage);
    imshow(C)
    title(['Treshold: ' num2str(treshold) ' Filtersize: ' ...
        num2str(filtersize) ' Cellcount: ' num2str(cellcount)])
    drawnow 
    if str2num(answer{3})==1        % If the user is happy, we can stop
        edit = false;
    end 
end
