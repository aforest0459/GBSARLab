function []=deformation_2movie(fps,fullname)
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
close(gcf);


fmat = moviein(col);
% ѭ����ȡ�α���
h = waitbar(0,'������...');
for i = 1:col

  file2           = list1(i,1:row);
  fun_show_xingbian (file2,3);set(gcf,'color','w');
xlabel({('��λ��m��'),(strrep(xuhao(i,:),'_','\_'))});
  fmat(:,i) = getframe(gcf);
close(gcf);


waitbar(i/col,h);
end
close(h);

%% ������ʾ
v= VideoWriter('��ά˲ʱ�α䶯��.avi');
v.FrameRate = str2double(fps);
open(v);
writeVideo(v,fmat)
close(v);
figure;set(gcf,'color','w');set(gcf,'Position',[ 670   433   711   545]);axis off;box off;
btn = uicontrol('Style', 'pushbutton', 'String', '���',...
        'Position', [5 40 50 20],'callback','cla');
%colorbar;
%axis(theAxis);
movie(fmat,5,str2double(fps));


