function []=deformation_cumulate2movie(fps,yuzhi,fullname)
%% ��ά�α䶯����ʾ
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
theAxis = axis;
xingbian         = findobj(gcf,'type','image');
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
zz               = get(xingbian,'cdata');
close(gcf);
[nr,nx]  = size(zz);
% ����ÿ�����ص��ۼ��α�ֵ
zz   = zeros(nr,nx);

fmat = moviein(col);
% ѭ����ȡ�α���
h = waitbar(0,'������...');
for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);
%��ȡ�α�ͼ���е�����
xingbian1         = findobj(gcf,'type','image');  
zzcell{i,1}       = get(xingbian1,'cdata');
zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15)) = zzcell{i,1}(zzcell{i,1}==zzcell{i,1}(15,15) | zzcell{i,1}==-zzcell{i,1}(15,15))*1e-6;
close(gcf);

waitbar(i/col,h);
end

for i = 1:col
    zz                = zz + zzcell{i,1};

%zz = fliplr(zz);
figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel({('��λ��m��'),(strrep(xuhao(i,:),'_','\_'))});ylabel('������m��');set(gcf,'color','w');

caxis([-str2double(yuzhi),str2double(yuzhi)]); 
fmat(:,i) = getframe(gcf);
close(gcf);
end
close(h);


%% ������ʾ
v= VideoWriter('��ά�ۻ��α䶯��.avi');
v.FrameRate = str2double(fps);
open(v);
writeVideo(v,fmat)
close(v);
figure;set(gcf,'color','w');set(gcf,'Position',[ 670   433   711   545]);axis off;box off;
%colorbar;
xlabel([strrep(xuhao(1,:),'_','\_'),'��',strrep(xuhao(end,:),'_','\_')]);
%caxis([-str2double(yuzhi) str2double(yuzhi)]);
%axis(theAxis);
movie(fmat,5,str2double(fps));


