function []=fun_adjustfig(t,text1,flag)
%% 横轴
if flag ==1
set(gca,'xtick',(t(1):str2double(get(text1,'String')):t(end)))
end
%% 纵轴
if flag ==2
%(gca,'ytick',(t(1):str2double(get(text1,'String')):t(end)))
ylim([(min(min(t))-5)*str2double(get(text1,'String')) max(max(t))*str2double(get(text1,'String'))])  ;
end
%% grid
if flag ==3
%(gca,'ytick',(t(1):str2double(get(text1,'String')):t(end)))
% 判断是否存在grid如果存在关闭，如果不存在，打开
if length(get(gca,'XGrid')) ==3
    set(gca,'XGrid','on');
    set(gca,'YGrid','on');
elseif length(get(gca,'XGrid')) == 2
    set(gca,'XGrid','off');
    set(gca,'YGrid','off');
end
end
%% 各点瞬时速度及累积形变图像保存模块 SSARLAB
if flag ==4
%寻找图像中的控件
aaa = findall(gcf,'Type','UIControl');
set(aaa,'Visible','off');
%%判断文件夹内图像文件
for i =1:100
if exist(['myfig',num2str(i),'.tif'],'file')
continue;
elseif ~exist(['myfig',num2str(i),'.tif'],'file')
break;
end
  
end
%saveas(gcf,['myfig',num2str(i),'.tiff'])
print (['myfig',num2str(i)], '-r600', '-dtiff');
helpdlg('图像保存成功','图像保存成功');
%winopen(['myfig',num2str(i),'.tiff']);
set(aaa,'Visible','on');
end

%% 二维形变图保存模块 SSARLAB

if flag ==5
%寻找图像中的控件
aaa = findall(gcf,'Type','UIControl');
set(aaa,'Visible','off');
%%判断文件夹内图像文件
for i =1:100
if exist([text1,'SSARImage(',num2str(i),')','.tif'],'file')
continue;
elseif ~exist([text1,'SSARImage(',num2str(i),')','.tif'],'file')
break;
end
  
end
%saveas(gcf,['myfig',num2str(i),'.tiff'])
print ([text1,'SSARImage(',num2str(i),')'], '-r600', '-dtiff');
helpdlg('图像保存成功','图像保存成功');
%winopen(['myfig',num2str(i),'.tiff']);
set(aaa,'Visible','on');
end
%% 二维形变图均值滤波模块 MeanFilter
if flag ==6
%传递形变数据过来
xx  = t{1};yy = t{2}; zz=t{3};
zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;

%zz(nyy<20)  = zz(nyy<20)*0.1;
filterwindow = get(text1,'String');
zz_mean = mean_filter(zz,filterwindow);
figure('Name','MeanFiltered Figure');
imagesc(-xx,yy,zz_mean);colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');set(gcf,'color','w');colormap parula
%-----------------------------形变图插值显示-------------------------------
[c,r] = size(zz_mean);
c = round(str2double(filterwindow))*c; r = round(str2double(filterwindow))*r; 
def_cubic  = imresize(zz_mean,[r,c],'bicubic');
figure('Name','Interpolated Figure');imagesc(-xx,yy,def_cubic);colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');
set(gcf,'color','w');colormap parula
end
%% 二维形变图均值滤波模块 SurfPlot
if flag ==7
%传递形变数据过来
xx  = t{1};yy = t{2}; zz=t{3};[nxx,nyy]  = meshgrid(-xx,yy);
zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;
min_x = min(min(-xx));
min_y = min(min(yy));
max_x = max(max(-xx));
max_y = max(max(yy));
figure('Name','Surf Figure');
surf(nxx,nyy,zz);colormap gray;zlim([-20 20]);shading interp;hold on;
% plot the image plane using surf.
imgzposition = -15;
% the image data you want to show as a plane.
planeimg = zz;
% scale image between [0, 255] in order to use a custom color map for it.
minplaneimg = min(min(planeimg)); % find the minimum
scaledimg = (floor(((planeimg - minplaneimg) ./ ...
    (max(max(planeimg)) - minplaneimg)) * 255)); % perform scaling
 
% convert the image to a true color image with the jet colormap.
colorimg = ind2rgb(scaledimg,parula(256));
s = surf([min_x max_x],[min_y max_y],repmat(imgzposition, [2 2]),...
    colorimg,'facecolor','texture');
view(27,32);
xlabel('Azimuth\m');ylabel('Range\m');zlabel('Deformation\mm');
set(gcf,'color','w');set(gca,'FontSize',18,'FontWeight','bold');
%--------------------------图像保存------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_adjustfig([],[],5)); % 使用句柄调用回调函数
end
%% 三维单帧形变图去除异常值然后显示
if flag ==8
helpdlg('需要滤波');
end
%% 坐标轴字号调整
if flag ==9
 aaa = get(gca,'FontSize');
    if aaa ==10
        set(gca,'FontSize',15,'FontWeight','bold');
        colorbar1   = findobj(gcf,'Type','ColorBar');
        axespos     = get(gca,'Position');
        colorbarpos = colorbar1.Position;colorbarpos(1) = axespos(1)+axespos(3)+0.05;
        set(colorbar1,'Position',colorbarpos,'TrickDirection','out');
    elseif aaa ==15
        set(gca,'FontSize',20,'FontWeight','bold');
        colorbar1   = findobj(gcf,'Type','ColorBar');
        axespos     = get(gca,'Position');
        colorbarpos = colorbar1.Position;colorbarpos(1) = axespos(1)+axespos(3)+0.05;
        set(colorbar1,'Position',colorbarpos,'TrickDirection','out');
        set(gca,'FontSize',10);
    elseif aa ==20
        colorbar1 = findobj(gcf,'Type','ColorBar');
         axespos     = get(gca,'Position');
        colorbarpos = colorbar1.Position;colorbarpos(1) =  axespos(1)+axespos(3)+0.05;
        set(colorbar1,'Position',colorbarpos,'TrickDirection','out');
    end
end
%% 单帧成像图数据导出“DataOutput”
if flag ==10
filename         = t;
fid              = fopen(filename,'rb');
fid2            = fopen(filename,'rb');
fid3            = fopen(filename,'rb');
data_read3      = fread(fid3,'uint16');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  % 该方法可以读取行数和列数
%% 计算行数列数

a1 = data_read3(1);a2 = data_read3(3);
% a1 = length(find(rem(data_read,0.3) ==0 & data_read~=0));
% a2 = length(find(abs(data_read)>data_read(a1+3)-data_read(a1+2)-0.001))+1-a1;
data_read0 =   [a1;a2];
data_read1 =   data_read(2:data_read0(1)+data_read0(2)+1);

fclose(fid);fclose(fid2);fclose(fid3);
data_read_int     = data_read_int((a1+a2)*2+3:end,:);
imgamp            = data_read_int(1:2:end,:);
imgphase          = data_read_int(2:2:end,:);
j = sqrt(-1);
defo = imgamp +j*imgphase;
data_read3 = reshape(defo,a1,a2);
% 读取成像图像中的数据
Ampimg                      = findobj(gcf,'type','image');   
AmpData.xaxis               = data_read1(a1+1:end,:);
AmpData.yaxis               = data_read1(1:a1,:);
AmpData.amplitude           = get(Ampimg,'CData');
AmpData.complex             = data_read3;

if ~exist('E:\SSARLAB\SSARamplitude\','dir')
    mkdir('E:\SSARLAB\SSARamplitude\');
end
save (['E:\SSARLAB\SSARamplitude\',text1,'AmpData','.mat'],'AmpData');
% filename = [text1,'AmpData','.mat'];
% save (filename,'AmpData');
helpdlg('保存成功','保存成功');
end
%% 成像图数据导出结果查看
if flag ==11
    winopen('E:\SSARLAB\SSARamplitude\');
end
%% 相干图数据导出结果查看
if flag ==12
    
end
%% 拟合值和曲线切换
if flag ==13
% 只显示三阶多项式拟合曲线
   figure('Name','三阶多项式拟合速度');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
   plot(t,text1{1},'Linewidth',3);set(gca,'XTickLabelRotation',45,'FontWeight','bold','FontSize',15);
   legend(text1{2});ylabel('Velocity(mm/per-image)')
end
%% 点平均曲线
if flag ==14
% 只显示三阶多项式拟合曲线
  
   time1 = t{1}; data_vel = t{2}; 
 % --------------------------均值滤波----------------------
   zz = data_vel;
[col,row]                  = size(zz);
n_mean                     = str2double(get(text1,'String'));                                  % 距离向搜索窗
%m_mean                     = 7;                                  % 方位向搜索窗
n_meanmid                  = (n_mean+1)/2;                       % 距离向搜索窗中心点
%m_meanmid                  = (m_mean+1)/2;                       % 方位向搜索窗中心点
mean_ES                    = ones(col,row);                      % 二维像rho的点数与Fig图像相同
%mean_ES(n_rhomid,m_rhomid) = 0;
%mean_ES(n_rhomid+1)        = mean(mean(zz(1:n_mean+1,1:m_mean+1))); 

%e             = waitbar(0,'均值滤波计算中...');
for i      = 1:row
    for j  = 1:col-n_mean-1
              mean_ES(n_meanmid+j-1,i)   = mean(zz(j:n_mean+j-1,i));
    end
end
data_meanvel = mean_ES;
%close(e);
 figure('Name','点邻域平均速度');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
  plot(time1(n_meanmid:col-n_mean-1,:),data_meanvel(n_meanmid:col-n_mean-1,:),'Linewidth',3);set(gca,'XTickLabelRotation',45,'FontWeight','bold','FontSize',15);
   legend(t{3});ylabel('Velocity(mm\h)');hold on;
   plot(time1(n_meanmid:col-n_mean-1,:),data_vel(n_meanmid:col-n_mean-1,:));
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_savefig()); % 使用句柄调用回调函数
end
%% 只显示原始曲线
if flag ==15
% 只显示原始曲线
t1 = t{1};data_vel = t{2};
   figure('Name','速度曲线');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
   plot(t1,data_vel);set(gca,'XTickLabelRotation',45,'FontWeight','bold','FontSize',15);
   legend(text1);ylabel('Velocity(mm/per-image)')
end

%% 伪三维显示plot3
if flag ==16
% 伪三维显示
t1 = t{1};data_vel = t{2};y1=1:50:50*size(data_vel,2);
figure('Name','速度瀑布图');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
for i=1:size(data_vel,2)
   % y=1:size(data_vel,2);
    y = y1(i).*ones(size(data_vel,1));
    plot3(t1,y,data_vel(:,i));
    hold on
end
set(gca,'YTickLabel',text1,'FontWeight','bold','FontSize',15);
xlabel('Time');zlabel('Velocity(mm/per-image)')
legend(text1);
grid on
end
%% mesh 图
if flag ==17
[Te,Fe]=meshgrid(t{1},t{2});

end
%% 导出所有大气校正稳定点随时间变化关系
if flag ==18
    n=1;
    DEM_Result = text1.DEM_Result;
    p_r        = text1.p_r;
    zzcell     = t;
    %-------------统计cursor数--------------
handle = allchild(gca);
num = length(handle);
   hhh = allchild(gca);
    zzcell = zzcell';
  for i = 1:num-1
   position{i} = hhh(i).Cursor.Position;
   % 找出每个点对应的时序形变
   ii =  find(DEM_Result(:,1) == position{i}(1) & DEM_Result(:,2) == position{i}(2) & DEM_Result(:,3) == position{i}(3)); 
   r1{i}       = p_r(ii,1); 
   m = DEM_Result(ii,end-1);
    n = DEM_Result(ii,end);
   
    [r,c] = size(zzcell{1});zz = zeros(r,c);
        for ii = 1:length(zzcell)
         a(ii)  = zzcell{ii,1}(m(1),n(1)); % 曲线图中每一个值都从zzcell中取出
         zz               =  zz + zzcell{ii,1}; % 
    %zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;

            zzcumulate{ii,1}  =  zz;
             a1(ii) = zzcumulate{ii,1}(m(1),n(1));% 
        end
     phidata{i} = a1;
     kpqc{i} = phidata{i}./r1{i};
  n = 1; 
  end
 
gcp.position = position;
gcp.phidata  = phidata;
gcp.r        = r1;
gcp.kpqc     = kpqc;
figure; 
for j = 1:length(kpqc)
    plot(kpqc{j});hold on;
    kpqc2(j,:) = kpqc{j};
end
hold off;
gcp.dk = max(kpqc2)-min(kpqc2);
save gcp.mat   gcp;
%n  =1;
helpdlg('稳定点保存成功');
end

end
