function []=deformation_cumulate3test(yuzhi,fullname,view1)
%% ��ά�α䶯����ʾ
%=========================================================================

%��ʱ��pA��������ʵ���α�ͼ�еĶ�ά����һһ��Ӧ��������ҪѰ���ٽ��㷽�������ڽ�����α�ֵ����pA
%�Ȼ��ʵ���α����ݵľ�����yy�����ᣬ��λ��xx�����ᣬ�α�����zz

%��DiffImage�ж�ȡ�����������

%datalist          = 'FileName.mat';
list = fullname;                      % Ϊafterfilter�ļ���Ԫ�����飬char��ʽ
%list = list.fullname;
%list = list';
%-----------------------------������׼�����ļ�---------------
load('DEM_Result.mat');
%----------------------------�����ļ���---------------------
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]        = size(list1);
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

% ---------------------����ÿ�����ص��ۼ��α�ֵ-------------------
zz   = zeros(nr,nx);
h = waitbar(0,'�α��ۼ���...');
for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);

%ѭ����ȡ�α�ͼ���е�����
xingbian1         = findobj(gcf,'type','image');  
% ȡ���������෴�����ʹ��
%zzcell{i,1}       = fliplr(get(xingbian1,'cdata'));
zzcell{i,1}       = get(xingbian1,'cdata');
close(gcf);
%���ƴ���
%zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;
zz                =  zz + zzcell{i,1};
zzcumulate{i,1}   =  zz;
waitbar(i/col,h);
end
close(h);
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(10);
%% ѭ����ȡ��ά�α���

h1 = waitbar(0,'ͼ��ɼ���...');
%% ������
minzz = min(min(zz));
% ����У��,�ҵ��Ƿ��������ڵ����񣬲����������
zz(4650:4750,195:205) = minzz;
% ѭ����ȡ�α���
for i = 1:length(DEM_Result)
    % �����ж���������ж�DEM_Result������zz����ά��
    if DEM_Result(i,end-1)< nr && DEM_Result(i,end)<nx
    fusion_z(i,1)  = zz(DEM_Result(i,end-1),DEM_Result(i,end));
    else
    fusion_z(i,1)  = zz(1,1);
    end

end


%��ȡ�α�ͼ���е�����
pA_3d_fusion     = [DEM_Result(:,1:3) fusion_z]; 
figure;set(gcf,'Color','w'); 
h=scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;view(view1(1),view1(2));
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');colorbar;
title(strrep(xuhao(1,:),'_','\_'));
caxis([-str2double(yuzhi),str2double(yuzhi)]);
close(h1);
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);

