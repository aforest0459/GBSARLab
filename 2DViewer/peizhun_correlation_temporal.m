% =====================================================

% �ó���ʵ�����ۼ����ͼ�ļ���ӳ����׼�����ҵ���Ŀ���ɻ��Ŀ����������ʱ��仯����
% last edit:20180701
% 20180701 �޸ĳ��½��Ͻ�gui���õ��ۻ�����Է���
%======================================================

function [] = peizhun_correlation_temporal(fullname,pclfile,my_position)
%�½��Ͻ���������
h = waitbar(0,'������...');
%% -------------------------------��һ�����������ݶ�ȡ--------------------------
d_deleteUseless   =  load (pclfile);

xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
Na                = length(xa);                                           % ���Ƶĵ���
 

%% ����ռ��pa������Ĵ���pk֮�����dY���Լ�pk������е�p0��λ����dX
% ���������˵����꣬Ȼ�������λ����
railfile          = my_position;
p_rail            = load (railfile);

p1                = p_rail(1,:);                                  % ��˵�


p2                = p_rail(2,:);                                 % �Ҷ˵�
%p0               = (p1+p2)/2;

rail              = norm(p1-p2);disp(['����Ĺ������',num2str(rail)]);


x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % �����a��


%p0               = 0.5*[x1+x2 y1+y2 z1+z2];                              % �������ĵ�����,��Ϊ��λ����

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                     % ����Ѱ��ͼ���϶�ά����

%% �������ݻ�õĶ�ά������ʵ���α�ͼ�еĶ�ά����ƥ��
%=========================================================================

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


for i = 1:col

  file2           = list1(i,1:row);
  fun_show(file2,2);
%��ȡ���ͼ���е�����
xianggan          = findobj(gcf,'type','image');  
zzcell{i,1}  = fliplr(get(xianggan,'cdata'));
close(gcf);
waitbar(i/col,h);
end
[nr,nx]  = size(zzcell{1,1});
% ����ÿ�����ص��ۼӷ���MA(i,j)
zz   = zeros(nr,nx);
for i = 1:col
    zz   =  zz + zzcell{i,1};
    
    zzcumulate{i,1}  =  zz;
end
close(h);
%==========================================================================
%�鿴�����α�����
figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(1);
%cmean = mean(mean(zz));
caxis([cmean*0.8,cmean]);  


[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_zΪ��Ӧ���α�ֵ
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % ��Ӧ������y������±�
dxx(j)           = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % ��Ӧ��λ��x������±�
if dyy(j)>0 && dyy(j) < length(nxx) && dxx(j) >0 && dxx(j) < length(nyy)
   
        X(j)             = nxx(dyy(j),dxx(j));
        Y(j)             = nyy(dyy(j),dxx(j));
        fusion_z(j)      = zz(dyy(j),dxx(j));                               % ��zz���ҵ�dyy��j����dxx��j����Ӧ���α�ֵ
end
end
DEM_Result       = [d_deleteUseless dyy dxx];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % �����γ�4ά����x��y��z���α�ֵ

clearvars za yy ya Y xx xianggan xianggan1 xa X pak pa pA nxx nyy list1 list fusion_z  d_deleteUseless
%% ��ɢ��ͼ���α�ֵ��Ӧ��ɫ
figure;set(gcf,'Color','w');                                     % ͼ�ν��汳���԰�ɫ��ʾ
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),0.05,pA_3d_fusion(:,end),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
title([strrep(xuhao(1,:),'_','\_'),'��',strrep(xuhao(end,:),'_','\_')]);  
%title([strrep(data,'_','\_'),'���ӳ����']);
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
colormap hot;
view(-147,27);
colorbar;
caxis([cmean*0.8,cmean]);                                                       % �ı�ɫ����ʾ��Χ
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback2(obj,event_obj,h,zz,zzcell,xuhao,DEM_Result);


% axis([0 16 0.85 1 ])
% a = findobj(gca,'type','line');
% yy = get(a,'YData');yy =yy';
