function [zz,zzcell,xuhao]=deformation_cumulate2(fullname)
%% 点云数据获得的二维坐标与实际形变图中的二维坐标匹配
%=========================================================================

%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz

%从DiffImage中读取所需的坐标轴

%datalist          = 'FileName.mat';
list = fullname;                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]  = size(list1);

file3            = list1(1,1:end);
%file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
%[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% 循环获取形变结果
h = waitbar(0,'计算中...');
for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);

%读取形变图像中的数据
xingbian1         = findobj(gcf,'type','image');  
zzcell{i,1}       = get(xingbian1,'cdata');
close(gcf);
zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;

waitbar(i/col,h);
end
close(h);
[nr,nx]  = size(zzcell{1,1});
% 计算每个像素点累加形变值
zz   = zeros(nr,nx);
for i = 1:col
    zz               =  zz + zzcell{i,1};
    %zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;
    zzcumulate{i,1} = zz;
end
%clearvars zzcell
%==========================================================================

%查看该组形变数据
figure;h=imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');set(gcf,'color','w');
title([strrep(xuhao(1,:),'_','\_'),'至',strrep(xuhao(end,:),'_','\_')]);
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback6(obj,event_obj,h,zz,zzcell,zzcumulate,xuhao);

cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(10);
%cmean = mean(mean(zz));
caxis([-cmean,cmean]); 
%--------------------------图像保存------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
txt = [xuhao(1,:),'至',xuhao(end,:)];
set(btn,'Callback', @(x,y)fun_adjustfig([],txt,5)); % 使用句柄调用回调函数
