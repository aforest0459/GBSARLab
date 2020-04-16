function output_txt = myfunction(obj,event_obj,h,zz,zzcell,xuhao,DEM_Result,flag)
if flag == 1
%% 用于三维DA分析图的cursor callback
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
% h            图像句柄
% zz           最后图像显示的值
% zzcell       过程累积值
% xuhao        时间序列的对应时刻
% DEM_Result   三维与二维对应关系的检索mat

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
%deformation = get(event_obj,'DataSource.CData(ind);
%output_txt = {['X: ',num2str(pos(1),4)],...
    %['Y: ',num2str(pos(2),4)],['Z: ',num2str(pos(3),4)]};
%-------------统计cursor数--------------
% handle = allchild(gca);
% num = length(handle);
%--------------------------------------
output_txt = {num2str(h.CData(ind))};

%% 用于形变图显示时序曲线
elseif flag == 2
%% 用于三维def3分析图的cursor callback
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
% h            图像句柄
% zz           最后图像显示的值
% zzcell       过程累积值
% xuhao        时间序列的对应时刻
% DEM_Result   三维与二维对应关系的检索mat

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
%deformation = get(event_obj,'DataSource.CData(ind);
% output_txt = {['X: ',num2str(pos(1),4)],...
%     ['Y: ',num2str(pos(2),4)],['Z: ',num2str(pos(3),4)]};
%-------------统计cursor数--------------
handle = allchild(gca);
num = length(handle);
%--------------------------------------

%
ii =  find(DEM_Result(:,1) == pos(1) & DEM_Result(:,2) == pos(2) & DEM_Result(:,3) == pos(3)); 
m = DEM_Result(ii,end-1);
n = DEM_Result(ii,end);
output_txt = {[num2str(m),',',num2str(n)],['P',num2str(num-1),':',num2str(h.CData(ind))]};
%[m,n] = find(b > (h.CData(ind)-0.001) & b  < (h.CData(ind)+0.001)); 
%[m,n] = find(zz >h.CData(ind)-0.000001 & zz<h.CData(ind)+0.000001);  % h.表示把图像的参数传递过来，然后使用里面的CData（颜色值）属性
 %
 zzcell = zzcell';
for i = 1:length(zzcell)
    a(i)  = zzcell{i,1}(m(1),n(1));
    zz               =  zz + zzcell{i,1};
    %zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;

    zzcumulate{i,1}  =  zz;
    a1(i) = zzcumulate{i,1}(m(1),n(1));
end
 n=1;
 
%
figure; %set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w')
set (gcf, 'color','w')

plot(a,'--*');grid minor;hold on;
g = findobj(gca,'type','line');
yy = get(g,'YData');yy =yy';
xx = get(g,'XData');xx =xx';

for i = 1:size(xuhao,1)
    xuhao1(i,:) = strrep(xuhao(i,:),'_','\_');
end
xuhao1 = xuhao1(:,7:end-4);
 %---------------------------------进行拟合-------------------------------------
 %拟合方法polyfit为x值、y值和阶数，得到的p为多项式的各个系数，polyval得到相应的y值
 p = polyfit(xx,yy,3);
 y1 = polyval(p,xx);
 y1mean = mean(y1);
 plot(xx,y1,':o');
 title(['第',num2str(num-1),'点','平均移速',num2str(y1mean),'mm每帧']);hold off;
 nxuhao = get(gca,'Xticklabel');
 for i = 1:length(nxuhao)
    nxuhao1(i)=floor(str2num(nxuhao{i}));
 end
 nxuhao1(1,length(nxuhao)) = size(xuhao1,1)-1;
 set(gca,'Xticklabel',xuhao1(nxuhao1+1,:));
 set(gca,'XTickLabelRotation',-45);
%  I=getimage(gcf); % 获取坐标系中的图像文件数据
%    imwrite(I,['第',num2str(num-1),'点.tif'],'Tiff','Resolution','300');%保存图像为文件
%}
end
