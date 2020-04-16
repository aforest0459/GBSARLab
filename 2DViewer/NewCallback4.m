function output_txt = myfunction(obj,event_obj,h,zz,zzcell,zzcumulate,xuhao,DEM_Result)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
%deformation = get(event_obj,'DataSource.CData(ind);
%output_txt = {['X: ',num2str(pos(1),4)],...
    %['Y: ',num2str(pos(2),4)],['Z: ',num2str(pos(3),4)]};
%-------------统计cursor数--------------
handle = allchild(gca);
num = length(handle);
%--------------------------------------
output_txt = {[num2str(num-1),'点',num2str(pos(3))],['Index:',num2str(h.CData(ind))]};

%b = zz; 
%
ii =  find(DEM_Result(:,1) == pos(1) & DEM_Result(:,2) == pos(2) & DEM_Result(:,3) == pos(3)); 
m = DEM_Result(ii,4);
n = DEM_Result(ii,5);
%[m,n] = find(b > (h.CData(ind)-0.001) & b  < (h.CData(ind)+0.001)); 
%[m,n] = find(zz >h.CData(ind)-0.000001 & zz<h.CData(ind)+0.000001);                         % h.表示把图像的参数传递过来，然后使用里面的CData（颜色值）属性
 for i = 1:length(zzcell)
    a(i)  = zzcell{i,1}(m(1),n(1));
    a1(i) = zzcumulate{i,1}(m(1),n(1));
 end
%
figure; set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w')
text1 = uicontrol('Style', 'edit', 'String', {['X: ',num2str(pos(1)*1e-5)],...
    ['Y: ',num2str(pos(2)*1e-5)],['Z: ',num2str(pos(3))]},...
        'Position', [5 5 85 60],'BackgroundColor',[1 1 1],'Max',3);
%text(1 ,0,{['X: ',num2str(pos(1)*1e-5)],...
%    ['Y: ',num2str(pos(2)*1e-5)],['Z: ',num2str(pos(3))]});
subplot(2,1,1)
plot(a,'--*');grid minor;hold on;
g = findobj(gca,'type','line');
yy = get(g,'YData');yy =yy';
xx = get(g,'XData');xx =xx';
global yycursor
yycursor(1,num-1)                  = num-1;

yycursor(2:length(zzcell)+1,num-1) = yy; 

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

subplot(2,1,2)
plot(a1,'--*');grid minor;hold on;
g = findobj(gca,'type','line');
yy1 = get(g,'YData');
yy1 = yy1';
global yycursor1
yycursor1(1,num-1)                  = num-1;

yycursor1(2:length(zzcell)+1,num-1) = yy1; 
 p2 = polyfit(xx,yy1,3);
 y2 = polyval(p2,xx);
 %y2mean = mean(y2);
 plot(xx,y2,':o');title(['第',num2str(num-1),'点累计位移',num2str(h.CData(ind)),'mm']); 
 set(gca,'Xticklabel',xuhao1(nxuhao1+1,:));
 set(gca,'XTickLabelRotation',-45);
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback5(obj,event_obj,xuhao1);

saveas (gca,['第',num2str(num-1),'点.tif']);

 save 每一帧形变.txt yycursor -ascii
 save 累积形变.txt yycursor1 -ascii
%}
