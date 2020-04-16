% =====================================================

% 该程序实现了累加相干图的几何映射配准，并且单击目标点可获得目标点相干性随时间变化曲线
% last edit:20180701
% 20180701 修改成新疆紫金gui可用的累积相干性分析
%======================================================

function [] = peizhun_correlation_temporal(fullname,pclfile,my_position)
%新疆紫金数据数据
h = waitbar(0,'计算中...');
%% -------------------------------第一步：点云数据读取--------------------------
d_deleteUseless   =  load (pclfile);

xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
Na                = length(xa);                                           % 点云的点数
 

%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail            = load (railfile);

p1                = p_rail(1,:);                                  % 左端点


p2                = p_rail(2,:);                                 % 右端点
%p0               = (p1+p2)/2;

rail              = norm(p1-p2);disp(['计算的轨道长度',num2str(rail)]);


x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % 轨道外a点


%p0               = 0.5*[x1+x2 y1+y2 z1+z2];                              % 求轨道中心点坐标,作为相位中心

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                     % 点云寻找图像上二维坐标

%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz
list = fullname;                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';%从DiffImage中读取所需的坐标轴
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]  = size(list1);

file3            = list1(1,1:end);
file3            = strrep(file3,'.AfterFilter','.DiffImage');
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');

close(figure(gcf));
%查看该组形变数据
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');
%% 查看相干结果

% 循环获取相干结果


for i = 1:col

  file2           = list1(i,1:row);
  fun_show(file2,2);
%读取相干图像中的数据
xianggan          = findobj(gcf,'type','image');  
zzcell{i,1}  = fliplr(get(xianggan,'cdata'));
close(gcf);
waitbar(i/col,h);
end
[nr,nx]  = size(zzcell{1,1});
% 计算每个像素点累加幅度MA(i,j)
zz   = zeros(nr,nx);
for i = 1:col
    zz   =  zz + zzcell{i,1};
    
    zzcumulate{i,1}  =  zz;
end
close(h);
%==========================================================================
%查看该组形变数据
figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(1);
%cmean = mean(mean(zz));
caxis([cmean*0.8,cmean]);  


[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
dxx(j)           = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
if dyy(j)>0 && dyy(j) < length(nxx) && dxx(j) >0 && dxx(j) < length(nyy)
   
        X(j)             = nxx(dyy(j),dxx(j));
        Y(j)             = nyy(dyy(j),dxx(j));
        fusion_z(j)      = zz(dyy(j),dxx(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
end
end
DEM_Result       = [d_deleteUseless dyy dxx];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % 最终形成4维矩阵，x、y、z、形变值

clearvars za yy ya Y xx xianggan xianggan1 xa X pak pa pA nxx nyy list1 list fusion_z  d_deleteUseless
%% 画散点图，形变值对应颜色
figure;set(gcf,'Color','w');                                     % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),0.05,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
title([strrep(xuhao(1,:),'_','\_'),'至',strrep(xuhao(end,:),'_','\_')]);  
%title([strrep(data,'_','\_'),'相干映射结果']);
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
colormap hot;
view(-147,27);
colorbar;
caxis([cmean*0.8,cmean]);                                                       % 改变色标显示范围
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback2(obj,event_obj,h,zz,zzcell,xuhao,DEM_Result);


% axis([0 16 0.85 1 ])
% a = findobj(gca,'type','line');
% yy = get(a,'YData');yy =yy';
