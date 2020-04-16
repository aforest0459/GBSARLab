function output_txt = myfunction(obj,event_obj,h,zz,zzcell,zzcumulate)
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
output_txt = {['点',num2str(num-2)],['Index:',num2str(h.CData(ind))]};

b = zz; 
[m,n] = find(zz >h.CData(ind)-0.0001 & zz<h.CData(ind)+0.0001);                         % h.表示把图像的参数传递过来，然后使用里面的CData（颜色值）属性
 for i = 1:length(zzcell)
    a(i)  = zzcell{i,1}(m,n);
    a1(i) = zzcumulate{i,1}(m,n);
 end
 
figure; set(gcf,'color','w');
subplot(2,1,1)
plot(a,'--*');grid minor;hold on;
g = findobj(gca,'type','line');
yy = get(g,'YData');yy =yy';
xx = get(g,'XData');xx =xx';
global yycursor
yycursor(1,num-2)                  = num-2;
yycursor(2:length(zzcell)+1,num-2) = yy; 
 
 p = polyfit(xx,yy,2);
 y1 = polyval(p,xx);
 y1mean = mean(y1);
 plot(xx,y1,':o');title(['第',num2str(num-2),'点',num2str(h.CData(ind)),'平均移速',num2str(y1mean),'每帧']);hold off;
%  I=getimage(gcf); % 获取坐标系中的图像文件数据
%    imwrite(I,['第',num2str(num-2),'点.tif'],'Tiff','Resolution','300');%保存图像为文件

subplot(2,1,2)
plot(a1,'--*');grid minor;hold on;
g = findobj(gca,'type','line');
yy1 = get(g,'YData');
yy1 = yy1';
global yycursor1
yycursor1(1,num-2)                  = num-2;
yycursor1(2:length(zzcell)+1,num-2) = yy1; 
p2 = polyfit(xx,yy1,2);
 y2 = polyval(p2,xx);
 y2mean = mean(y2);
 plot(xx,y2,':o');title(['第',num2str(num-2),'点累计位移',num2str(h.CData(ind)),'平均位移',num2str(y2mean)]); 

saveas (gca,['第',num2str(num-2),'点.tif']);

 save 每一帧形变.txt yycursor -ascii
 save 累积形变.txt yycursor1 -ascii
%h = get(event_obj,'DataIndex');

%event_obj.DataSource.CData(ind)
% If there is a Z-coordinate in the position, display it as well

   % output_txt{end+1} = {['Deformation:',num2str(pos(3))]};

