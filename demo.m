clc
close all

filename = '1.png';
img = imread(filename);
ref = imread('2.png');

out_image = HistMatch(img, ref);
filename_ = strcat(filename(1:end-4), '_matched.png');
imwrite(out_image, filename_);