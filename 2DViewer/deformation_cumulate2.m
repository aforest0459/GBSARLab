function [zz,zzcell,xuhao]=deformation_cumulate2(fullname)
%% �������ݻ�õĶ�ά������ʵ���α�ͼ�еĶ�ά����ƥ��
%=========================================================================

%��ʱ��pA��������ʵ���α�ͼ�еĶ�ά����һһ��Ӧ��������ҪѰ���ٽ��㷽�������ڽ�����α�ֵ����pA
%�Ȼ��ʵ���α����ݵľ�����yy�����ᣬ��λ��xx�����ᣬ�α�����zz

%��DiffImage�ж�ȡ�����������

%datalist          = 'FileName.mat';
list = fullname;                      % Ϊafterfilter�ļ���Ԫ�����飬char��ʽ
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
% ��ȡ�α�ͼ���е�����
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
%[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% ѭ����ȡ�α���
h = waitbar(0,'������...');
for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);

%��ȡ�α�ͼ���е�����
xingbian1         = findobj(gcf,'type','image');  
zzcell{i,1}       = get(xingbian1,'cdata');
close(gcf);
zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;

waitbar(i/col,h);
end
close(h);
[nr,nx]  = size(zzcell{1,1});
% ����ÿ�����ص��ۼ��α�ֵ
zz   = zeros(nr,nx);
for i = 1:col
    zz               =  zz + zzcell{i,1};
    %zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;
    zzcumulate{i,1} = zz;
end
%clearvars zzcell
%==========================================================================

%�鿴�����α�����
figure;h=imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');set(gcf,'color','w');
title([strrep(xuhao(1,:),'_','\_'),'��',strrep(xuhao(end,:),'_','\_')]);
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback6(obj,event_obj,h,zz,zzcell,zzcumulate,xuhao);

cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(10);
%cmean = mean(mean(zz));
caxis([-cmean,cmean]); 
%--------------------------ͼ�񱣴�------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
txt = [xuhao(1,:),'��',xuhao(end,:)];
set(btn,'Callback', @(x,y)fun_adjustfig([],txt,5)); % ʹ�þ�����ûص�����
