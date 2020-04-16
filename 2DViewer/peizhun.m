%% 新疆紫金数据配准
% =====================================================

% 该程序实现了单个形变图的几何映射配准
% last edit:20180701
% 180525加入了形成DEM_Result.dat功能，形变数据保存成五列数，[X Y xa ya za];前两列对应(未验证)
% 180629新疆紫金单幅数据配准
% 180701新疆数据配准相反了，将数据进行左右调换

%======================================================
%clear all;
%close all;
%===================================

%三维空间点到轨道的距离计算

%===================================
function [] = peizhun(difffile,pclfile,my_position)
%新疆紫金数据数据
%data              =  '2018_06_29_12_26_02';
data = difffile;%无.DiffImage后缀
%% -------------------------------第一步：点云数据读取--------------------------
%点云文件读取并重命名
%path   =  'D:\001雷达仿真\xingbian\180629xinjiangzijin\xinjiangzijin\initial_miyun_xyz\';
%pclfile = 'xinjianzijin.xyz';
pcl  = pclfile;
d_deleteUseless   =  load (pcl);
%clearvars            ScanPos001___POINTCLOUDS___180523_145753_2cm;        % 清除临时变量
% save                 initial_miyun_xyz.mat d_deleteUseless;
% load                 'initial_miyun_xyz.mat';                            % 读取保存好的点云数据，使用实验点云数据 
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


%p0                = 0.5*[x1+x2 y1+y2 z1+z2];                              % 求轨道中心点坐标,作为相位中心

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                      % 点云寻找图像上二维坐标


%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%从DiffImage中读取所需的坐标轴

%file3            = [data,'.DiffImage'];
file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
zz               = fliplr(get(xingbian,'cdata'));
%zz(zz>3.5 | zz<-3.5) = zz(1,1);                                     % 形变异常值处理
close(figure(gcf));
%查看该组形变数据
%figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');
%title(strrep(data,'_','\_'));
%==========================================================================
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
%DEM_Result       = [X Y pa];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % 最终形成4维矩阵，x、y、z、形变值
% DEM_Result       = [d_deleteUseless(:,1);d_deleteUseless(:,2);d_deleteUseless(:,3); dxx;dyy ];
% % save DEM_Result.dat DEM_Result -ascii
% fid = fopen('DEM_Result.dat','wb');
% fwrite(fid,DEM_Result,'double');
% fclose(fid);

%% 画散点图，形变值对应颜色
figure;set(gcf,'Color','w');                                     % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）
h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
%title([strrep(data,'_','\_'),'形变映射结果']);
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-130,24);
colorbar;
caxis([-4,4]);                                                      % 改变色标显示范围
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);



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
