function []=deformation_cumulate2movie(fps,yuzhi,fullname)
%% 二维形变动画显示
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
theAxis = axis;
xingbian         = findobj(gcf,'type','image');
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
zz               = get(xingbian,'cdata');
close(gcf);
[nr,nx]  = size(zz);
% 计算每个像素点累加形变值
zz   = zeros(nr,nx);

fmat = moviein(col);
% 循环获取形变结果
h = waitbar(0,'计算中...');
for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);
%读取形变图像中的数据
xingbian1         = findobj(gcf,'type','image');  
zzcell{i,1}       = get(xingbian1,'cdata');
zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;
close(gcf);

waitbar(i/col,h);
end

for i = 1:col
    zz                = zz + zzcell{i,1};

%zz = fliplr(zz);
figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel({('方位向（m）'),(strrep(xuhao(i,:),'_','\_'))});ylabel('距离向（m）');set(gcf,'color','w');

caxis([-str2double(yuzhi),str2double(yuzhi)]); 
fmat(:,i) = getframe(gcf);
close(gcf);
end
close(h);


%% 动画显示
v= VideoWriter('二维累积形变动画.avi');
v.FrameRate = str2double(fps);
open(v);
writeVideo(v,fmat)
close(v);
figure;set(gcf,'color','w');set(gcf,'Position',[ 670   433   711   545]);axis off;box off;
%colorbar;
xlabel([strrep(xuhao(1,:),'_','\_'),'至',strrep(xuhao(end,:),'_','\_')]);
%caxis([-str2double(yuzhi) str2double(yuzhi)]);
%axis(theAxis);
movie(fmat,5,str2double(fps));


