function []=deformation_cumulate3movie(fps,yuzhi,fullname,view1)
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
zzcell{i,1}       = fliplr(get(xingbian1,'cdata'));
close(gcf);
zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;
zz                =  zz + zzcell{i,1};
zzcumulate{i,1}   =  zz;
waitbar(i/col,h);
end
close(h);
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(10);
% ѭ����ȡ��ά�α���
fmat = moviein(col);
h = waitbar(0,'ͼ��ɼ���...');

% ѭ����ȡ�α���


for i = 1:col

  file2           = list1(i,1:row);
for j = 1:length(DEM_Result)
fusion_z(j,1)  = zzcumulate{i}(DEM_Result(j,4),DEM_Result(j,5));
end
%��ȡ�α�ͼ���е�����
pA_3d_fusion{i}     = [DEM_Result(:,1:3) fusion_z]; 
figure;set(gcf,'Color','w'); set(gcf,'Position',[ 1   1   711   545]);
scatter3(pA_3d_fusion{i}(:,1),pA_3d_fusion{i}(:,2),pA_3d_fusion{i}(:,3),2,pA_3d_fusion{i}(:,end),'filled');
%axis image;
view(view1(1),view1(2));
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');colorbar;
title(strrep(xuhao(i,:),'_','\_'));
caxis([-str2double(yuzhi),str2double(yuzhi)]); 
fmat(:,i) = getframe(gcf);
waitbar(i/col,h);
close(gcf);
end
close(h);



%% ������ʾ
v= VideoWriter('��ά�ۻ��α䶯��.avi');
v.FrameRate = str2double(fps);
open(v);
writeVideo(v,fmat)
close(v);
figure;set(gcf,'color','w');%set(gcf,'Position',[ 670   433   711   545]);axis off;box off;
%colorbar;
xlabel([strrep(xuhao(1,:),'_','\_'),'��',strrep(xuhao(end,:),'_','\_')]);
%caxis([-str2double(yuzhi) str2double(yuzhi)]);
%axis(theAxis);
movie(fmat,5,str2double(fps));