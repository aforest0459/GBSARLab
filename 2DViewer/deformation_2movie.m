function []=deformation_2movie(fps,fullname)
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
close(gcf);


fmat = moviein(col);
% 循环获取形变结果
h = waitbar(0,'计算中...');
for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);set(gcf,'color','w');
xlabel({('方位向（m）'),(strrep(xuhao(i,:),'_','\_'))});
  fmat(:,i) = getframe(gcf);
close(gcf);


waitbar(i/col,h);
end
close(h);

%% 动画显示
v= VideoWriter('二维瞬时形变动画.avi');
v.FrameRate = str2double(fps);
open(v);
writeVideo(v,fmat)
close(v);
figure;set(gcf,'color','w');set(gcf,'Position',[ 670   433   711   545]);axis off;box off;
btn = uicontrol('Style', 'pushbutton', 'String', '清除',...
        'Position', [5 40 50 20],'callback','cla');
%colorbar;
%axis(theAxis);
movie(fmat,5,str2double(fps));


