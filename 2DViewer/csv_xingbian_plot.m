%本程序用于将预警系统内导出的区域累积形变生成等形变量图（contour）
%         180403添加数据游标
%lastedit 180518使背景色标显示一致
%% 初始化
%clear all
%clc
%function  xingbian_plot(data)
%% ---------------------第一步：导入形变.csv数据-------------------------
%filename       = data;
filename       = 'D:\001雷达仿真\chenjiang\xingbian\data-5_2-5_11.csv';
data           = csvread(filename,2,0);                % import数据文件到data中
%[column,row]  = size(data);                           % 计算data中数据的行数
data(data == -1000) = 0;                               % 异常值置零
data           = [data(:,1) data(:,2) data(:,4)];      % 将三列数据合成一个
x              = data(:,1);
y              = data(:,2);
z              = data(:,3);
%% ---------------------第二步：建立x，y网格--------------------------
%x升序排列
%data_sort = sortrows(data,1);
% data_sort = sortrows(data,2);
% data_sortx = sort(data(:,1));
% data_sorty = sort(data(:,2));
nx             = linspace(min(x),max(x),1000);         % 距离向网格数量1000
ny             = linspace(min(y),max(y),200);          % 方位向网格数量200
[xx,yy]        = meshgrid(nx,ny);                      % 生成网格
zz             = griddata(x,y,z,xx,yy);

%% --------------------第三步：绘图----------------------------------
% figure;imagesc(ny,nx,zz');axis xy;
% figure;contour(ny,nx,xingbianzz,8);
%% 等高线图
%figure;contour(ny,nx,zz',8);axis([-300 250 500 780]);
figure; set(gcf,'Color','w');contourf(ny,nx,zz',18);axis([-300 300 500 750]);
colorbar;caxis([-40 20]);grid on;
%获得文件名并作为图像的标题
a = strfind(filename,'.');b = strfind(filename,'\');
xuhao = filename(max(b)+1:a-1);
title(strrep(xuhao,'_','\_'));
%title([strrep(xuhao,'_','\_'),'\_',num2str(length(nx)),'*',num2str(length(ny))]);
xlabel('方位向（m）');ylabel('距离向（m）'); 
%获取图像色标
if  xuhao(6)=='3'
mycmap = get(gcf,'Colormap');
save('MyColormaps','mycmap')     %把mycmap变量保存为MyColormaps.mat，位置在matlab当前目录

else
    load MyColormaps.mat
    colormap(mycmap);
    colorbar;
end   
%% 散点图
%figure;scatter3(data(:,2),data(:,1),data(:,4),2); %在figure中画图
%% 添加游标

%===========================
%text(134.4067,595.6662,sprintf('(%.3f,%.3f)',134.4067,595.6662,'verticalAlignment','bottom') 
% 如题，比如：
% >> STATS
% STATS = 
% 2x1 struct array with fields:
%     Centroid
% >> STATS(1,1)
% ans = 
%     Centroid: [475.8515 1.8822e+03]
% >> STATS(2,1)
% ans = 
%     Centroid: [758.0744 806.0816]
%提取游标结构体数值cat(1,STATS.Centroid)
% load cursor_1.mat
% a = cat(1,cursor_1.Position);
% for i = 1:7
%     text(a(i,1),a(i,2),sprintf('(%.3f,%.3f)',a(i,1),a(i,2)),'VerticalAlignment','bottom')
% end

%end
