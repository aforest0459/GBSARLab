% =====================================================

% 该程序实现了单个DA图的几何映射配准
% last edit:20180603
% 
%======================================================
clear all;
%close all;
clc;

%定标实验练习数据
data              =  '2018_05_23_14_23_08';
%% -------------------------------第一步：点云数据读取--------------------------
%点云文件读取并重命名
pcldata           =  'ScanPos001 - POINTCLOUDS - 180523_145753_2cm';
d_deleteUseless   =  load([pcldata,'.txt']);
 

%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
% 计算轨道两端点坐标，然后计算相位中心

pleft_1           = [6.957 -7.016 -0.139];
pleft_2           = [7.131 -6.976 -0.141];
p1                = (pleft_1 +pleft_2)/2;                                 % 左端点

pright_1          = [5.877 -7.287 -0.148];
pright_2          = [6.048 -7.241 -0.147];
p2                = (pright_1+pright_2)/2;                                % 右端点
%p0               = (p1+p2)/2;

rail              = norm(p1-p2);disp(['计算的轨道长度',num2str(rail)]);

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                     % 点云寻找图像上二维坐标



%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%从DiffImage中读取所需的坐标轴
file3            = [data,'.AfterFilter'];
fun_show_xingbian  (file3,3);
title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
zz               = get(xingbian,'cdata');

close(figure(gcf));
%查看该组形变数据
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');

% 计算幅度离差结果
datalist      = 'AfterFilterlist';
list          = importdata([datalist,'.txt']);                      % 为afterfilter文件的元胞数组，char形式
DA            = coef_stdev(list);

figure;imagesc(-xx,yy,DA);axis xy;xlabel('方位向(m)');ylabel('距离向(m)');title(strrep(data,'_','\_'));
%==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
dxx(j)           = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
X(j)             = nxx(dyy(j),dxx(j));
Y(j)             = nyy(dyy(j),dxx(j));
fusion_z(j)      = DA(dyy(j),dxx(j));                               % 在zz_coef中找到dyy（j）和dxx（j）对应的形变值
end
DEM_Result       = [X Y d_deleteUseless];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % 最终形成4维矩阵，x、y、z、形变值


%% 画散点图，形变值对应颜色
figure;set(gcf,'Color','w');                                        % 图形界面背景以白色显示
scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
title([strrep(data,'_','\_'),'相干幅度离差映射结果']);xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(15,20);
colorbar;
caxis([0,0.025]);                                                   % 改变色标显示范围
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);
hold on;
%角反射器角点坐标
p_reflector = [2.243 19.577 -1.316;                                 % 右上角反射器坐标
               -1.372 18.821 -1.085;                                % 大角反射器坐标
               1.738 5.806 -1.179];                                 % 下侧角反射器坐标
scatter3(p_reflector(:,1),p_reflector(:,2),p_reflector(:,3),12,'r','filled');
hold off;
