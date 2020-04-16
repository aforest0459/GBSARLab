% =====================================================

% 该程序实现了单个形变图的几何映射配准
% last edit:20180626
% 180525 添加了游标显示形变值的功能
% 180602 读入点云数据变量名称直接为d_deleteUseless,注释掉了另存为initial_miyun_xyz.mat
%        将空间点云对应的二维SAR图像坐标写成了函数pcl2image.m
% 180603 加入了根据幅度离差值筛选数据的功能，函数coef_stdev.m
%        均值滤波剔除异常值功能  
% 180626 加入了累计形变图，单击某个点显示形变随时间变化图
%======================================================
clear all;
%clear all;
clc;

%新疆紫金数据数据
data              =  '2018_06_29_12_26_02';
%% -------------------------------第一步：点云数据读取--------------------------
%点云文件读取并重命名
path   =  'D:\001雷达仿真\xingbian\180629xinjiangzijin\xinjiangzijin\initial_miyun_xyz\';
pclfile = 'initial_miyun_xyz.mat';
d_deleteUseless   =  cell2mat(struct2cell(load ([path,pclfile])));
%clearvars            ScanPos001___POINTCLOUDS___180523_145753_2cm;        % 清除临时变量
% save                 initial_miyun_xyz.mat d_deleteUseless;
% load                 'initial_miyun_xyz.mat';                            % 读取保存好的点云数据，使用实验点云数据 

%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
% 计算轨道两端点坐标，然后计算相位中心
railfile          = 'my_position.txt';
p_rail            = load ([path,railfile]);

p1                = p_rail(1,:);                                  % 左端点


p2                = p_rail(2,:);                                 % 右端点
%p0               = (p1+p2)/2;

rail              = norm(p1-p2);disp(['计算的轨道长度',num2str(rail)]);

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                      % 点云寻找图像上二维坐标



%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%从DiffImage中读取所需的坐标轴

file3            = [data,'.DiffImage'];
fun_show_xingbian  (file3,3);
title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
zz               = get(xingbian,'cdata');
close(figure(gcf));

%{
%% 根据相干图处理数据
% 查看相干结果
  file2   = [data,'.AfterFilter'];
  fun_show(file2,2)
%读取相干图像中的数据
xianggan  = findobj(gcf,'type','image');  
zz_coef   = get(xianggan,'cdata');
close(figure(gcf));
% 计算幅度离差结果
datalist      = 'AfterFilterlist';
list          = importdata([datalist,'.txt']);                    % 为afterfilter文件的元胞数组，char形式
DA            = coef_stdev(list);

% 形变异常值处理
% zz_reflector     = zz(90:92,64:67);
zz(zz==zz(2,1) | zz==-zz(2,1)) = 1e-6;
zz(zz_coef<0.9 & zz_coef>0)    = 1e-5;                            % 相干系数大于0.9
zz(DA>0.065 & DA<1)            = 1e-5;                            % 幅度离差小于0.065
% zz = zz*0.5;
% zz(90:92,64:67)  = zz_reflector;



%------------------------------
%滚动窗均值滤波
%------------------------------

[col,row]                  = size(zz);
n_mean                     = 7;                                  % 距离向搜索窗
m_mean                     = 3;                                  % 方位向搜索窗
n_meanmid                  = (n_mean+1)/2;                       % 距离向搜索窗中心点
m_meanmid                  = (m_mean+1)/2;                       % 方位向搜索窗中心点
mean_ES                    = ones(col,row);                      % 二维像rho的点数与Fig图像相同
%mean_ES(n_rhomid,m_rhomid) = 0;
%mean_ES(n_rhomid+1)        = mean(mean(zz(1:n_mean+1,1:m_mean+1))); 

e             = waitbar(0,'均值滤波计算中...');
for i      = 1:col-n_mean-1
    for j  = 1:row-m_mean-1
              mean_ES(n_meanmid+i-1,m_meanmid+j-1)   = mean(mean(zz(i:n_mean+i-1,j:m_mean+j-1)));
    end
    waitbar(i/(col-n_mean-1),e);
end
close(e);

zz         = mean_ES;


%查看该组形变数据
figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');
%}

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
fusion_z(j)      = zz(dyy(j),dxx(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
end
DEM_Result       = [X Y d_deleteUseless];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % 最终形成4维矩阵，x、y、z、形变值


%% 画散点图，形变值对应颜色
figure;set(gcf,'Color','w');                                     % 图形界面背景以白色显示
scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
title([strrep(data,'_','\_'),'形变映射结果']);xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-147,27);
colorbar;
caxis([-4,4]);                                                      % 改变色标显示范围
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);

%角反射器角点坐标


%% 绘制三维曲面函数

% % 抽稀
% n_sparse      =  1:1000:length(pA_3d_fusion); % 现在的精度是2cm，再隔5个取一个点应该为10cm
% 
% [Axx,Ayy,Azz]  = meshgrid(pA_3d_fusion(n_sparse,1),pA_3d_fusion(n_sparse,2),pA_3d_fusion(n_sparse,3));
% figure;set(gcf,'Color','w');
% mesh(Axx,Ayy,Azz);


%绘制三维坐标以及反射强度的关系
% figure;set(gcf,'Color','w'); 
% scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,d_deleteUseless(:,4),'filled');%x,y,z,粗细，强度，形状（默认是圈
% axis image;title('点云反射强度图');xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
% view(15,20);
% colorbar;
% caxis([0 3000])


% %绘制三维坐标以及距离的关系
% pa_range  = zeros(col_pA,1);
% for i = 1:col_pA
%         pa_range(i,1) = norm(pA_3d_fusion(i,1:3));
% end
% figure;set(gcf,'Color','w'); 
% scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pa_range(:,1),'filled');%x,y,z,粗细，强度，形状（默认是圈
% axis image;title('点云距离显示图');xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
% view(15,20);
% colorbar;
% %caxis([0 3000])
