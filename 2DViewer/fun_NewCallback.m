function output_txt = myfunction(obj,event_obj,h,zz,zzcell,xuhao,DEM_Result,flag)
if flag == 1
%% ������άDA����ͼ��cursor callback
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
% h            ͼ����
% zz           ���ͼ����ʾ��ֵ
% zzcell       �����ۻ�ֵ
% xuhao        ʱ�����еĶ�Ӧʱ��
% DEM_Result   ��ά���ά��Ӧ��ϵ�ļ���mat

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
%deformation = get(event_obj,'DataSource.CData(ind);
%output_txt = {['X: ',num2str(pos(1),4)],...
    %['Y: ',num2str(pos(2),4)],['Z: ',num2str(pos(3),4)]};
%-------------ͳ��cursor��--------------
% handle = allchild(gca);
% num = length(handle);
%--------------------------------------
output_txt = {num2str(h.CData(ind))};

%% �����α�ͼ��ʾʱ������
elseif flag == 2
%% ������άdef3����ͼ��cursor callback
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
% h            ͼ����
% zz           ���ͼ����ʾ��ֵ
% zzcell       �����ۻ�ֵ
% xuhao        ʱ�����еĶ�Ӧʱ��
% DEM_Result   ��ά���ά��Ӧ��ϵ�ļ���mat

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
%deformation = get(event_obj,'DataSource.CData(ind);
% output_txt = {['X: ',num2str(pos(1),4)],...
%     ['Y: ',num2str(pos(2),4)],['Z: ',num2str(pos(3),4)]};
%-------------ͳ��cursor��--------------
handle = allchild(gca);
num = length(handle);
%--------------------------------------

%
ii =  find(DEM_Result(:,1) == pos(1) & DEM_Result(:,2) == pos(2) & DEM_Result(:,3) == pos(3)); 
m = DEM_Result(ii,end-1);
n = DEM_Result(ii,end);
output_txt = {[num2str(m),',',num2str(n)],['P',num2str(num-1),':',num2str(h.CData(ind))]};
%[m,n] = find(b > (h.CData(ind)-0.001) & b  < (h.CData(ind)+0.001)); 
%[m,n] = find(zz >h.CData(ind)-0.000001 & zz<h.CData(ind)+0.000001);  % h.��ʾ��ͼ��Ĳ������ݹ�����Ȼ��ʹ�������CData����ɫֵ������
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
 %---------------------------------�������-------------------------------------
 %��Ϸ���polyfitΪxֵ��yֵ�ͽ������õ���pΪ����ʽ�ĸ���ϵ����polyval�õ���Ӧ��yֵ
 p = polyfit(xx,yy,3);
 y1 = polyval(p,xx);
 y1mean = mean(y1);
 plot(xx,y1,':o');
 title(['��',num2str(num-1),'��','ƽ������',num2str(y1mean),'mmÿ֡']);hold off;
 nxuhao = get(gca,'Xticklabel');
 for i = 1:length(nxuhao)
    nxuhao1(i)=floor(str2num(nxuhao{i}));
 end
 nxuhao1(1,length(nxuhao)) = size(xuhao1,1)-1;
 set(gca,'Xticklabel',xuhao1(nxuhao1+1,:));
 set(gca,'XTickLabelRotation',-45);
%  I=getimage(gcf); % ��ȡ����ϵ�е�ͼ���ļ�����
%    imwrite(I,['��',num2str(num-1),'��.tif'],'Tiff','Resolution','300');%����ͼ��Ϊ�ļ�
%}
end
