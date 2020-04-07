% =====================================================

% 该程序实现了单个形变图的几何映射配准
% last edit:20180701
% 180525 添加了游标显示形变值的功能
% 180602 读入点云数据变量名称直接为d_deleteUseless,注释掉了另存为initial_miyun_xyz.mat
%        将空间点云对应的二维SAR图像坐标写成了函数pcl2image.m
% 180603 加入了根据幅度离差值筛选数据的功能，函数coef_stdev.m
%        均值滤波剔除异常值功能  
% 180626 加入了累计形变图，单击某个点显示形变随时间变化图
%        形变图像自动保存，多个cursor点结果保存成一个yy.txt文档
% 180701 将文件修改成函数形式，加入到新疆紫金数据分析gui中
% 181023 将函数改写，返回DEM_Result不生成图像       
%======================================================
function [DEM_Result,rail,pA_3d_fusion] = peizhun_deformation_temporal(fullname,pclfile,my_position,flag)
% DEM_Result 为x y z m n的变量
% rail       为轨道长度
if flag == 1
%% -------------------------------第一步：点云数据读取--------------------------
h = waitbar(0,'计算中...');
d_deleteUseless   =  load (pclfile);
xa                = d_deleteUseless(:,1)-5*1e5;
ya                = d_deleteUseless(:,2)-4.44*1e6;
za                = d_deleteUseless(:,3);
                                          % 点云的点数
                                          % 处理z值接近0点数据
% temp  = d_deleteUseless(:,3);
% temp(d_deleteUseless(:,3) == d_deleteUseless(1,3))=0;
% d_deleteUseless(:,3)  = temp;
%% -------------------------------轨道信息读取-----------------------------------
% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail           = load (railfile);
p1                = p_rail(1,:);                                 % 左端点
p2                = p_rail(2,:);                                 % 右端点
rail               = norm(p1-p2);
disp(['计算的轨道长度',num2str(rail)]);

x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
% p1                = [x1-5*1e5 y1-4.44*1e6 z1];
% p2                = [x2-5*1e5 y2-4.44*1e6 z2];
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                                                % 轨道外a点

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                     % 点云寻找图像上二维坐标

%% 
% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%% 从DiffImage中读取所需的坐标轴（）必须为角度域
list = fullname';                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
    list1(i,:) = list{i,1}(:);
    a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
    xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
%% 读取二维图像中的坐标轴
[col,row]  = size(list1);
file3           = list1(1,1:end);
filename        = file3;

%[diffImageData, diffImageM, diffImageN, diffImageRAxis, diffImageAAxis]=funDiffImageReader(filename);
fid             = fopen(filename,'rb');
fid2            = fopen(filename,'rb');
fid3            = fopen(filename,'rb');
data_read3      = fread(fid3,'uint16');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  % 该方法可以读取行数和列数
a1 = data_read3(1);a2 = data_read3(3);   % 距离向号及方位向号

data_read0 =   [a1;a2];
data_read1      = data_read(2:data_read0(1)+data_read0(2)+1);% 提取距离向及方位向坐标
%file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = data_read1(a1+1:end,:);
yy               = data_read1(1:a1,:);
[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% 循环获取形变结果

for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);

%读取形变图像中的数据
xingbian1         = findobj(gcf,'type','image');  
zzcell{i,1}       = get(xingbian1,'cdata');
close(gcf);
%zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;

waitbar(i/col,h);
end

[nr,nx]  = size(zzcell{1,1});
% 计算每个像素点累加形变值
zz   = zeros(nr,nx);
for i = 1:col
    zz               =  zz + zzcell{i,1};
    zzcumulate{i,1}  =  zz;
end
close(h);
%==========================================================================


%查看该组形变数据
figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('方位向（rad）');ylabel('距离向（m）');
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(3);
%cmean = mean(mean(zz));
caxis([-cmean,cmean]);  

% 计算点云的方位角
p_view  = atan(pA(:,1)./pA(:,2));

%==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
dxxFliplr = zeros(col_pA,1);

for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
%dxx(j)          = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
% 方案2 角度匹配如果p_view 超过了雷达最大角度即continue
    if p_view(j,1)>max(xx) || p_view(j,1)<min(xx)
                 % 雷达未扫描到的像素将其匹配至形变图（1,1）处
        dyy(j) =1;dxx(j)=1; dxxFliplr(j)=1;
        continue;
    else
            dxxFliplr(j)           = length(xx)-round((p_view(j,1)-xx(1))/(xx(2)-xx(1)));
            dxx(j) = round((p_view(j,1)-xx(1))/(xx(2)-xx(1)))+1;
            if dyy(j)>0 && dyy(j) < size(nxx,1) && dxxFliplr(j) >0 && dxxFliplr(j) < size(nyy,2)  
                 X(j)             = nxx(dyy(j),dxxFliplr(j));
                 Y(j)             = nyy(dyy(j),dxxFliplr(j));
                 fusion_z(j)      = zz(dyy(j),dxxFliplr(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
            else
                 % 不在图像内的像素将其匹配至形变图（1,1）处
                dyy(j) =1;
                dxx(j) =1;
            end
    end
end

% 散射模型测试论文使用，正常使用时注释掉
% fusion_z(fusion_z == fusion_z(1))=1e-5;
% load matlab.mat;
% fusion_z = fusion_z.*gammaI;
DEM_Result       = [d_deleteUseless X Y dyy dxxFliplr];
pA_3d_fusion     = [d_deleteUseless fusion_z];                         % 最终形成4维矩阵，x、y、z、形变值
clearvars za yy ya Y xx xingbian xingbian1 xa X pak pa pA nxx nyy list1 list fusion_z  d_deleteUseless

%% 画散点图，形变值对应颜色
figure;set(gcf,'Color','w');                                     % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-130,24);
colorbar;
%caxis([-cmean,cmean]);                                                      % 改变色标显示范围
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) fun_NewCallbackForScatter3(obj,event_obj,h);

%%
elseif flag == 2
%% -------------------------------第一步：点云数据读取--------------------------
h = waitbar(0,'计算中...');
d_deleteUseless   =  load (pclfile);
xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
% 点云的点数
% 处理z值接近0点数据
% temp  = d_deleteUseless(:,3);
% temp(d_deleteUseless(:,3) == d_deleteUseless(1,3))=0;
% d_deleteUseless(:,3)  = temp;
%-------------------------------------------
%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail            = load (railfile);
p1                = p_rail(1,:);                                  % 左端点
p2                = p_rail(2,:);                                  % 右端点
rail              = norm(p1-p2);disp(['计算的轨道长度',num2str(rail)]);


x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % 轨道外a点
[pak,pA]       = pcl2image(d_deleteUseless,p1,p2);                     % 点云寻找图像上二维坐标

%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%从DiffImage中读取所需的坐标轴（）必须为角度域
list = fullname';                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]  = size(list1);

file3           = list1(1,1:end);
filename        = file3;
fid             = fopen(filename,'rb');
fid2            = fopen(filename,'rb');
fid3            = fopen(filename,'rb');
data_read3      = fread(fid3,'uint16');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  % 该方法可以读取行数和列数
a1 = data_read3(1);a2 = data_read3(3);   % 距离向号及方位向号

data_read0 =   [a1;a2];
data_read1      = data_read(2:data_read0(1)+data_read0(2)+1);% 提取距离向及方位向坐标
%file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = data_read1(a1+1:end,:);
yy               = data_read1(1:a1,:);
[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% 循环获取形变结果

for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);

%读取形变图像中的数据
xingbian1         = findobj(gcf,'type','image');  
%翻转
%zzcell{i,1}       = fliplr(get(xingbian1,'cdata'));
%
zzcell{i,1}       = get(xingbian1,'cdata');
close(gcf);
%zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;

waitbar(i/col,h);
end

[nr,nx]  = size(zzcell{1,1});
% 计算每个像素点累加形变值
zz   = zeros(nr,nx);
for i = 1:col
    zz               =  zz + zzcell{i,1};
   

    zzcumulate{i,1}  =  zz;
end
close(h);
%==========================================================================


%查看该组形变数据
figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('方位向（rad）');ylabel('距离向（m）');
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(3);
%cmean = mean(mean(zz));
caxis([-cmean,cmean]);  

% 计算点云的方位角
p_view  = atan(pA(:,1)./pA(:,2));

%==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
%dxx(j)          = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
% 方案2 角度匹配如果p_view 超过了雷达最大角度即continue
    if p_view(j,1)>max(xx) || p_view(j,1)<min(xx)
         % 雷达未扫描到的像素将其匹配至形变图（1,1）处
        dyy(j) =1;dxx(j)=1;
        continue;
    else
            dxx(j)           = round((p_view(j,1)-xx(1))/(xx(2)-xx(1)))+1;
            if dyy(j)>0 && dyy(j) < size(nxx,1) && dxx(j) >0 && dxx(j) < size(nyy,2)  
                 X(j)             = nxx(dyy(j),dxx(j));
                 Y(j)             = nyy(dyy(j),dxx(j));
                 fusion_z(j)      = zz(dyy(j),dxx(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
            else
                 % 不在图像内的像素将其匹配至形变图（1,1）处
                dyy(j) =1;
                dxx(j) =1;
            end
    end
end


DEM_Result       = [d_deleteUseless X Y dyy dxx];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % 最终形成4维矩阵，x、y、z、形变值
%clearvars za yy ya Y xx xingbian xingbian1 xa X pak pa pA nxx nyy list1 list fusion_z  d_deleteUseless

%% 画散点图，形变值对应颜色
figure;set(gcf,'Color','w');                                     % 图形界面背景以白色显示
% scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）
h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-130,24);
colorbar;
caxis([-cmean,cmean]); % 改变色标显示范围


%% 数据游标
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) fun_NewCallback(obj,event_obj,h,zz,zzcell,xuhao,DEM_Result,2);
%caxis([-cmean,cmean]); 
n=1;
% 改变色标显示范围

elseif flag == 3
%% -------------------------------第一步：点云数据读取--------------------------
h = waitbar(0,'计算中...');
d_deleteUseless   =  load (pclfile);
xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
% 点云的点数
% 处理z值接近0点数据
% temp  = d_deleteUseless(:,3);
% temp(d_deleteUseless(:,3) == d_deleteUseless(1,3))=0;
% d_deleteUseless(:,3)  = temp;
%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail            = load (railfile);
p1                = p_rail(1,:);                                  % 左端点
p2                = p_rail(2,:);                                  % 右端点
rail              = norm(p1-p2);disp(['计算的轨道长度',num2str(rail)]);


x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p0                = 0.5*[x1+x2 y1+y2 z1+z2];
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % 轨道外a点
[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                     % 点云寻找图像上二维坐标

%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%从DiffImage中读取所需的坐标轴（）必须为角度域
list = fullname';                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]  = size(list1);

file3           = list1(1,1:end);
filename        = file3;
fid             = fopen(filename,'rb');
fid2            = fopen(filename,'rb');
fid3            = fopen(filename,'rb');
data_read3      = fread(fid3,'uint16');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  % 该方法可以读取行数和列数
a1 = data_read3(1);a2 = data_read3(3);   % 距离向号及方位向号

data_read0 =   [a1;a2];
data_read1      = data_read(2:data_read0(1)+data_read0(2)+1);% 提取距离向及方位向坐标
%file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = data_read1(a1+1:end,:);
yy               = data_read1(1:a1,:);
[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% 循环获取形变结果

for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);

%读取形变图像中的数据
xingbian1         = findobj(gcf,'type','image');  
zzcell{i,1}       = fliplr(get(xingbian1,'cdata'));
close(gcf);
%zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;

waitbar(i/col,h);
end

[nr,nx]  = size(zzcell{1,1});
% 计算每个像素点累加形变值
zz   = zeros(nr,nx);
for i = 1:col
    zz               =  zz + zzcell{i,1};
   

    zzcumulate{i,1}  =  zz;
end
close(h);
%==========================================================================
%查看该组形变数据
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('方位向（rad）');ylabel('距离向（m）');
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(3);
%cmean = mean(mean(zz));
caxis([-cmean,cmean]);  
DEM_Result = 0;
% 计算点云的方位角
p_view  = atan(pA(:,1)./pA(:,2)); 
p_view(p_view>-0.01 & p_view<0.01) = -10;
%% 画散点图，形变值对应颜色
figure('Name','点云方位角查看');set(gcf,'Color','w');                                     % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）

h = scatter3(d_deleteUseless(:,1),d_deleteUseless(:,2),d_deleteUseless(:,3),2,p_view(:,end),'filled');hold on;
scatter3(p0(:,1),p0(:,2),p0(:,3),10,'b');
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-130,24);
colorbar;
elseif flag==4

%% -------------------------------第一步：点云数据读取--------------------------
h = waitbar(0,'计算中...');
d_deleteUseless   =  load (pclfile);
xa                = d_deleteUseless(:,1)-5*1e5;
ya                = d_deleteUseless(:,2)-4.44*1e6;
za                = d_deleteUseless(:,3);
                                          % 点云的点数
                                          % 处理z值接近0点数据
% temp  = d_deleteUseless(:,3);
% temp(d_deleteUseless(:,3) == d_deleteUseless(1,3))=0;
% d_deleteUseless(:,3)  = temp;
%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail           = load (railfile);
p1                = p_rail(1,:);                                 % 左端点
p2                = p_rail(2,:);                                 % 右端点
rail               = norm(p1-p2);
disp(['计算的轨道长度',num2str(rail)]);

x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
% p1                = [x1-5*1e5 y1-4.44*1e6 z1];
% p2                = [x2-5*1e5 y2-4.44*1e6 z2];
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                                                % 轨道外a点

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                     % 点云寻找图像上二维坐标

%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%从DiffImage中读取所需的坐标轴（）必须为角度域
list = fullname';                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]  = size(list1);

file3           = list1(1,1:end);
filename        = file3;
fid             = fopen(filename,'rb');
fid2            = fopen(filename,'rb');
fid3            = fopen(filename,'rb');
data_read3      = fread(fid3,'uint16');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  % 该方法可以读取行数和列数
a1 = data_read3(1);a2 = data_read3(3);   % 距离向号及方位向号

data_read0 =   [a1;a2];
data_read1      = data_read(2:data_read0(1)+data_read0(2)+1);% 提取距离向及方位向坐标
%file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = data_read1(a1+1:end,:);
yy               = data_read1(1:a1,:);
[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% 循环获取形变结果

for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);

%读取形变图像中的数据
xingbian1         = findobj(gcf,'type','image');  
zzcell{i,1}       = fliplr(get(xingbian1,'cdata'));
close(gcf);
%zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;

waitbar(i/col,h);
end

[nr,nx]  = size(zzcell{1,1});
% 计算每个像素点累加形变值
zz   = zeros(nr,nx);
for i = 1:col
    zz               =  zz + zzcell{i,1};
    zzcumulate{i,1}  =  zz;
end
close(h);
%==========================================================================

%查看该组形变数据
figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('方位向（rad）');ylabel('距离向（m）');
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(3);
%cmean = mean(mean(zz));
caxis([-cmean,cmean]);  

% 计算点云的方位角
p_view  = atan(pA(:,1)./pA(:,2));

%==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
%dxx(j)          = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
% 方案2 角度匹配如果p_view 超过了雷达最大角度即continue
    if p_view(j,1)>max(xx) || p_view(j,1)<min(xx)
                 % 雷达未扫描到的像素将其匹配至形变图（1,1）处
        dyy(j) =1;dxx(j)=1;
        continue;
    else
            dxx(j)           = round((p_view(j,1)-xx(1))/(xx(2)-xx(1)))+1;
            if dyy(j)>0 && dyy(j) < size(nxx,1) && dxx(j) >0 && dxx(j) < size(nyy,2)  
                 X(j)             = nxx(dyy(j),dxx(j));
                 Y(j)             = nyy(dyy(j),dxx(j));
                 fusion_z(j)      = zz(dyy(j),dxx(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
            else
                 % 不在图像内的像素将其匹配至形变图（1,1）处
                dyy(j) =1;
                dxx(j) =1;
            end
    end
end
% 散射模型测试论文使用，正常使用时注释掉
fusion_z(fusion_z == fusion_z(1))=1e-5;
% load matlab.mat;
% 
% fusion_z = fusion_z.*gammaI;
DEM_Result       = [d_deleteUseless X Y dyy dxx];
pA_3d_fusion     = [d_deleteUseless fusion_z];                         % 最终形成4维矩阵，x、y、z、形变值
clearvars za yy ya Y xx xingbian xingbian1 xa X pak pa pA nxx nyy list1 list fusion_z  d_deleteUseless

%% 画散点图，形变值对应颜色
figure;set(gcf,'Color','w');                                     % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-150,40);
colorbar;
%caxis([-cmean,cmean]);                                                      % 改变色标显示范围
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) fun_NewCallbackForScatter3(obj,event_obj,h);    
end
