function [] = cumulate_correlation2(fullname)

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
h = waitbar(0,'计算中...');

for i = 1:col

  file2           = list1(i,1:row);
  fun_show(file2,2);
%读取相干图像中的数据
xianggan          = findobj(gcf,'type','image');  
zzcell{i,1}       = fliplr(get(xianggan,'cdata'));
close(gcf);
waitbar(i/col,h);
end
[nr,nx]  = size(zzcell{1,1});
% 计算每个像素点累加幅度MA(i,j)
zz   = zeros(nr,nx);
for i = 1:col
    zz   =  zz + zzcell{i,1};
    
    %zzcumulate{i,1}  =  zz;
    
end
close(h);
%==========================================================================
%查看该组形变数据
figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');set(gca,'color','w');
colormap hot;
%set(gcf,'Position',[ 670   433   711   545]);
btn1 = uicontrol('Style', 'pushbutton', 'String', '保存区间数据',...
        'Position', [5 5 70 20]);
btn2 = uicontrol('Style', 'pushbutton', 'String', '保存阈值数据',...
        'Position', [85 5 70 20]);
btn3 = uicontrol('Style', 'pushbutton', 'String', '查看数据',...
        'Position', [165 5 70 20]);
btn4 = uicontrol('Style', 'pushbutton', 'String', '无控件图像',...
        'Position', [545 5 70 20]);
 title([strrep(xuhao(1,:),'_','\_'),'至',strrep(xuhao(end,:),'_','\_')]);
text1 = uicontrol('Style','edit','String','<10万','Position',[5 25 50 20]);   % 区间终点
text2 = uicontrol('Style','edit','String','>1500','Position',[5 45 50 20]);   % 区间起点
text3 = uicontrol('Style','edit','String','0.8~1','Position',[5 65 50 20]);   % 阈值

cmean = sort(zz(:),'descend');
cmean = cmean(1);
%cmean = mean(mean(zz));
%caxis([cmean*0.8,cmean]); 

set(btn1,'Callback', @(x,y)fun_savecorrelation(xx,yy,zz,text1,text2)); % 使用句柄调用回调函数
set(btn2,'Callback', @(x,y)fun_savecorrelation1(xx,yy,zz,text3));
set(btn3,'Callback', @(x,y)fun_opencorrelexcel());
set(btn4,'Callback', @(x,y)fun_exceptuicontrol(xx,yy,zz,xuhao));
%a = {'相干图像素行号', '相干图像素列号';corrm,corrn};
% a = [corrm corrn];
% xlswrite('correlationgreatpoints.xlsx',a)