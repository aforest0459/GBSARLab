%% 二维与三维映射匹配程序

% load '.\lianxishuju\range_y.mat';
% load '.\lianxishuju\fangwei_x.mat';
% load '.\lianxishuju\zz.mat';
%% 初始化
clear all;
clc;
close all;
%% 使用的是哪一组形变数据
data      =  '2018_05_23_14_53_08';
%% ------------------------------第一步：查看形变结果---------------------------------
 file3    = [data,'.DiffImage'];
 fun_show_xingbian(file3,3);
 title(strrep(data,'_','\_'));
%读取形变图像中的数据
xingbian  = findobj(gcf,'type','image');   
xx        = -get(xingbian,'xdata');                             % 形变图横轴
yy        = get(xingbian,'ydata');                              % 形变图纵轴
zz        = get(xingbian,'cdata');                              % 形变值
%形成坐标网格数据
[nxx,nyy] = meshgrid(xx,yy);                                    % nxx为形变图每点对应的横坐标，nyy为每点对应的纵坐标
close(figure(gcf));
figure;imagesc(xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');

%% ------------------------------第二步：查看形变结果---------------------------------
%{
[colum_pA,row_pA] = size(pA);
dxx = zeros(colum_pA,1);dyy = zeros(colum_pA,1);
fusion_z = zeros(colum_pA,1);
for j = 1:colum_pA
dyy(j) = round((pA(j,2)-yy(1))/0.3)+1;%对应距离向y方向的下标
dxx(j) = round((pA(j,1)-xx(1))/5.3216)+1;%对应方位向x方向的下标
fusion_z(j) = zz(dyy(j),dxx(j));%在zz中找到dyy（j）和dxx（j）对应的形变值
end
pA_fusion = [pA fusion_z];
pA_3d_fusion = [d_deleteUseless fusion_z];%形成4维矩阵，x、y、z、形变值

%% 画散点图，形变值对应颜色
figure(1);set(gcf,'Color','w');%图形界面背景以白色显示
scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,4),'filled');%x,y,z,粗细，强度，形状（默认是圈）
axis image;
colorbar;
caxis([-0.5,0.5]);%改变色标显示范围

%
%% 欧式距离计算匹配方法
%==========================================================================

%①计算出pA中每个点与img中每个点的距离，选出最短距离对应的点，形变值一致

%==========================================================================
r_fusion = zeros(Nimg,1);
pA_fusion = zeros(colum_pA,1);

        for i = 1:Nimg
             
            r_fusion(i,1) = sqrt((pA(1,1)-img(i,2))^2+(pA(1,2)-img(i,3))^2);
            
        end
[minx, id] = min(r_fusion);%查找矩阵中最小的元素并且返回其对应行号与列号
pA_fusion(1) = img(id,1);
%}
%==========================================================================