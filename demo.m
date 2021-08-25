clc
close all

filename = '3.png';
img = imread(filename);
ref = imread('4.png');

out_image = HistMatch(img, ref);
filename_ = strcat(filename(1:end-4), '_matched.png');
imwrite(out_image, filename_);