%���������ڽ�Ԥ��ϵͳ�ڵ����������ۻ��α����ɵ��α���ͼ��contour��
%         180403��������α�
%lastedit 180518ʹ����ɫ����ʾһ��
%% ��ʼ��
%clear all
%clc
%function  xingbian_plot(data)
%% ---------------------��һ���������α�.csv����-------------------------
%filename       = data;
filename       = 'D:\001�״����\chenjiang\xingbian\data-5_2-5_11.csv';
data           = csvread(filename,2,0);                % import�����ļ���data��
%[column,row]  = size(data);                           % ����data�����ݵ�����
data(data == -1000) = 0;                               % �쳣ֵ����
data           = [data(:,1) data(:,2) data(:,4)];      % ���������ݺϳ�һ��
x              = data(:,1);
y              = data(:,2);
z              = data(:,3);
%% ---------------------�ڶ���������x��y����--------------------------
%x��������
%data_sort = sortrows(data,1);
% data_sort = sortrows(data,2);
% data_sortx = sort(data(:,1));
% data_sorty = sort(data(:,2));
nx             = linspace(min(x),max(x),1000);         % ��������������1000
ny             = linspace(min(y),max(y),200);          % ��λ����������200
[xx,yy]        = meshgrid(nx,ny);                      % ��������
zz             = griddata(x,y,z,xx,yy);

%% --------------------����������ͼ----------------------------------
% figure;imagesc(ny,nx,zz');axis xy;
% figure;contour(ny,nx,xingbianzz,8);
%% �ȸ���ͼ
%figure;contour(ny,nx,zz',8);axis([-300 250 500 780]);
figure; set(gcf,'Color','w');contourf(ny,nx,zz',18);axis([-300 300 500 750]);
colorbar;caxis([-40 20]);grid on;
%����ļ�������Ϊͼ��ı���
a = strfind(filename,'.');b = strfind(filename,'\');
xuhao = filename(max(b)+1:a-1);
title(strrep(xuhao,'_','\_'));
%title([strrep(xuhao,'_','\_'),'\_',num2str(length(nx)),'*',num2str(length(ny))]);
xlabel('��λ��m��');ylabel('������m��'); 
%��ȡͼ��ɫ��
if  xuhao(6)=='3'
mycmap = get(gcf,'Colormap');
save('MyColormaps','mycmap')     %��mycmap��������ΪMyColormaps.mat��λ����matlab��ǰĿ¼

else
    load MyColormaps.mat
    colormap(mycmap);
    colorbar;
end   
%% ɢ��ͼ
%figure;scatter3(data(:,2),data(:,1),data(:,4),2); %��figure�л�ͼ
%% ����α�

%===========================
%text(134.4067,595.6662,sprintf('(%.3f,%.3f)',134.4067,595.6662,'verticalAlignment','bottom') 
% ���⣬���磺
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
%��ȡ�α�ṹ����ֵcat(1,STATS.Centroid)
% load cursor_1.mat
% a = cat(1,cursor_1.Position);
% for i = 1:7
%     text(a(i,1),a(i,2),sprintf('(%.3f,%.3f)',a(i,1),a(i,2)),'VerticalAlignment','bottom')
% end

%end
