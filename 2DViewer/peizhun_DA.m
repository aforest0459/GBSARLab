% =====================================================

% �ó���ʵ���˵���DAͼ�ļ���ӳ����׼
% last edit:20180603
% 
%======================================================
clear all;
%close all;
clc;

%����ʵ����ϰ����
data              =  '2018_05_23_14_23_08';
%% -------------------------------��һ�����������ݶ�ȡ--------------------------
%�����ļ���ȡ��������
pcldata           =  'ScanPos001 - POINTCLOUDS - 180523_145753_2cm';
d_deleteUseless   =  load([pcldata,'.txt']);
 

%% ����ռ��pa������Ĵ���pk֮�����dY���Լ�pk������е�p0��λ����dX
% ���������˵����꣬Ȼ�������λ����

pleft_1           = [6.957 -7.016 -0.139];
pleft_2           = [7.131 -6.976 -0.141];
p1                = (pleft_1 +pleft_2)/2;                                 % ��˵�

pright_1          = [5.877 -7.287 -0.148];
pright_2          = [6.048 -7.241 -0.147];
p2                = (pright_1+pright_2)/2;                                % �Ҷ˵�
%p0               = (p1+p2)/2;

rail              = norm(p1-p2);disp(['����Ĺ������',num2str(rail)]);

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                     % ����Ѱ��ͼ���϶�ά����



%% �������ݻ�õĶ�ά������ʵ���α�ͼ�еĶ�ά����ƥ��
%=========================================================================

%��ʱ��pA��������ʵ���α�ͼ�еĶ�ά����һһ��Ӧ��������ҪѰ���ٽ��㷽�������ڽ�����α�ֵ����pA
%�Ȼ��ʵ���α����ݵľ�����yy�����ᣬ��λ��xx�����ᣬ�α�����zz

%��DiffImage�ж�ȡ�����������
file3            = [data,'.AfterFilter'];
fun_show_xingbian  (file3,3);
title              (strrep(data,'_','\_'));
% ��ȡ�α�ͼ���е�����
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
zz               = get(xingbian,'cdata');

close(figure(gcf));
%�鿴�����α�����
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('��λ��m��');ylabel('������m��');

% ������������
datalist      = 'AfterFilterlist';
list          = importdata([datalist,'.txt']);                      % Ϊafterfilter�ļ���Ԫ�����飬char��ʽ
DA            = coef_stdev(list);

figure;imagesc(-xx,yy,DA);axis xy;xlabel('��λ��(m)');ylabel('������(m)');title(strrep(data,'_','\_'));
%==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_zΪ��Ӧ���α�ֵ
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % ��Ӧ������y������±�
dxx(j)           = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % ��Ӧ��λ��x������±�
X(j)             = nxx(dyy(j),dxx(j));
Y(j)             = nyy(dyy(j),dxx(j));
fusion_z(j)      = DA(dyy(j),dxx(j));                               % ��zz_coef���ҵ�dyy��j����dxx��j����Ӧ���α�ֵ
end
DEM_Result       = [X Y d_deleteUseless];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % �����γ�4ά����x��y��z���α�ֵ


%% ��ɢ��ͼ���α�ֵ��Ӧ��ɫ
figure;set(gcf,'Color','w');                                        % ͼ�ν��汳���԰�ɫ��ʾ
scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
title([strrep(data,'_','\_'),'��ɷ������ӳ����']);xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(15,20);
colorbar;
caxis([0,0.025]);                                                   % �ı�ɫ����ʾ��Χ
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);
hold on;
%�Ƿ������ǵ�����
p_reflector = [2.243 19.577 -1.316;                                 % ���ϽǷ���������
               -1.372 18.821 -1.085;                                % ��Ƿ���������
               1.738 5.806 -1.179];                                 % �²�Ƿ���������
scatter3(p_reflector(:,1),p_reflector(:,2),p_reflector(:,3),12,'r','filled');
hold off;
