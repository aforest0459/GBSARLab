function [] = cumulate_correlation2(fullname)

%��ʱ��pA��������ʵ���α�ͼ�еĶ�ά����һһ��Ӧ��������ҪѰ���ٽ��㷽�������ڽ�����α�ֵ����pA
%�Ȼ��ʵ���α����ݵľ�����yy�����ᣬ��λ��xx�����ᣬ�α�����zz
list = fullname;                      % Ϊafterfilter�ļ���Ԫ�����飬char��ʽ

%list = list.fullname;
%list = list';%��DiffImage�ж�ȡ�����������
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]  = size(list1);

file3            = list1(1,1:end);
file3            = strrep(file3,'.AfterFilter','.DiffImage');
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% ��ȡ�α�ͼ���е�����
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');

close(figure(gcf));
%�鿴�����α�����
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('��λ��m��');ylabel('������m��');
%% �鿴��ɽ��

% ѭ����ȡ��ɽ��
h = waitbar(0,'������...');

for i = 1:col

  file2           = list1(i,1:row);
  fun_show(file2,2);
%��ȡ���ͼ���е�����
xianggan          = findobj(gcf,'type','image');  
zzcell{i,1}       = fliplr(get(xianggan,'cdata'));
close(gcf);
waitbar(i/col,h);
end
[nr,nx]  = size(zzcell{1,1});
% ����ÿ�����ص��ۼӷ���MA(i,j)
zz   = zeros(nr,nx);
for i = 1:col
    zz   =  zz + zzcell{i,1};
    
    %zzcumulate{i,1}  =  zz;
    
end
close(h);
%==========================================================================
%�鿴�����α�����
figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');set(gca,'color','w');
colormap hot;
%set(gcf,'Position',[ 670   433   711   545]);
btn1 = uicontrol('Style', 'pushbutton', 'String', '������������',...
        'Position', [5 5 70 20]);
btn2 = uicontrol('Style', 'pushbutton', 'String', '������ֵ����',...
        'Position', [85 5 70 20]);
btn3 = uicontrol('Style', 'pushbutton', 'String', '�鿴����',...
        'Position', [165 5 70 20]);
btn4 = uicontrol('Style', 'pushbutton', 'String', '�޿ؼ�ͼ��',...
        'Position', [545 5 70 20]);
 title([strrep(xuhao(1,:),'_','\_'),'��',strrep(xuhao(end,:),'_','\_')]);
text1 = uicontrol('Style','edit','String','<10��','Position',[5 25 50 20]);   % �����յ�
text2 = uicontrol('Style','edit','String','>1500','Position',[5 45 50 20]);   % �������
text3 = uicontrol('Style','edit','String','0.8~1','Position',[5 65 50 20]);   % ��ֵ

cmean = sort(zz(:),'descend');
cmean = cmean(1);
%cmean = mean(mean(zz));
%caxis([cmean*0.8,cmean]); 

set(btn1,'Callback', @(x,y)fun_savecorrelation(xx,yy,zz,text1,text2)); % ʹ�þ�����ûص�����
set(btn2,'Callback', @(x,y)fun_savecorrelation1(xx,yy,zz,text3));
set(btn3,'Callback', @(x,y)fun_opencorrelexcel());
set(btn4,'Callback', @(x,y)fun_exceptuicontrol(xx,yy,zz,xuhao));
%a = {'���ͼ�����к�', '���ͼ�����к�';corrm,corrn};
% a = [corrm corrn];
% xlswrite('correlationgreatpoints.xlsx',a)