%function:
%       surf特征点检测与匹配
%注意：
%       本例程主要演示如何用matlab自带的Computer Vision System Toolbox进行surf特征点的提取与匹配
%date:2015-1-13
%author:chenyanan
%转载请注明出处：http://blog.csdn.net/u010278305
 
%清空变量，读取图像
%clear;close all
 
%Read the two images.
I1= imread('002雷达视角光学图像.jpg');
I1=imresize(I1,0.5);
I1=rgb2gray(I1);
I2= imread('003雷达视角光学图像_裁剪.jpg');
I2=imresize(I2,0.5);
I2=rgb2gray(I2);
 
%Find the SURF features.寻找特征点
points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2); 
 
%Extract the features.计算描述向量
[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);
 
%Retrieve the locations of matched points. The SURF feature vectors are already normalized.
%进行匹配
indexPairs = matchFeatures(f1, f2, 'Prenormalized', true) ;
matched_pts1 = vpts1(indexPairs(:, 1));
matched_pts2 = vpts2(indexPairs(:, 2));
 
%Display the matching points. The data still includes several outliers, 
%but you can see the effects of rotation and scaling on the display of matched features.
%对匹配结果进行显示，可以看到，还有一些异常值
figure('name','result'); showMatchedFeatures(I1,I2,matched_pts1,matched_pts2);
legend('matched points 1','matched points 2');
