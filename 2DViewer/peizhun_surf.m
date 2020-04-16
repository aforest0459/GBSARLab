%function:
%       surf����������ƥ��
%ע�⣺
%       ��������Ҫ��ʾ�����matlab�Դ���Computer Vision System Toolbox����surf���������ȡ��ƥ��
%date:2015-1-13
%author:chenyanan
%ת����ע��������http://blog.csdn.net/u010278305
 
%��ձ�������ȡͼ��
%clear;close all
 
%Read the two images.
I1= imread('002�״��ӽǹ�ѧͼ��.jpg');
I1=imresize(I1,0.5);
I1=rgb2gray(I1);
I2= imread('003�״��ӽǹ�ѧͼ��_�ü�.jpg');
I2=imresize(I2,0.5);
I2=rgb2gray(I2);
 
%Find the SURF features.Ѱ��������
points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2); 
 
%Extract the features.������������
[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);
 
%Retrieve the locations of matched points. The SURF feature vectors are already normalized.
%����ƥ��
indexPairs = matchFeatures(f1, f2, 'Prenormalized', true) ;
matched_pts1 = vpts1(indexPairs(:, 1));
matched_pts2 = vpts2(indexPairs(:, 2));
 
%Display the matching points. The data still includes several outliers, 
%but you can see the effects of rotation and scaling on the display of matched features.
%��ƥ����������ʾ�����Կ���������һЩ�쳣ֵ
figure('name','result'); showMatchedFeatures(I1,I2,matched_pts1,matched_pts2);
legend('matched points 1','matched points 2');
