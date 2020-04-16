% =====================================================

% �ó���ʵ���˵������ͼ�ļ���ӳ����׼
% last edit:20180701
% 20180701 �������޸ĳɺ�����gui����
%======================================================
%clear all;
%clear all;
%clc;
function [] = peizhun_correlation(pclfile,my_position)
%�½��Ͻ���������
%data              =  '2018_06_29_12_26_02';
data = filterfile;
%% -------------------------------��һ�����������ݶ�ȡ--------------------------
%�����ļ���ȡ��������
pcl  = pclfile;
d_deleteUseless   =  load (pcl);
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


%p0                = 0.5*[x1+x2 y1+y2 z1+z2];                              % �������ĵ�����,��Ϊ��λ����

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                      % ����Ѱ��ͼ���϶�ά����


%% �������ݻ�õĶ�ά������ʵ���α�ͼ�еĶ�ά����ƥ��
%=========================================================================

%��ʱ��pA��������ʵ���α�ͼ�еĶ�ά����һһ��Ӧ��������ҪѰ���ٽ��㷽�������ڽ�����α�ֵ����pA
%�Ȼ��ʵ���α����ݵľ�����yy�����ᣬ��λ��xx�����ᣬ�α�����zz

%��DiffImage�ж�ȡ�����������
file3            = strrep(filterfile,'.AfterFilter','.DiffImage');
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% ��ȡ�α�ͼ���е�����
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
close(figure(gcf));
%�鿴�����α�����
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('��λ��m��');ylabel('������m��');
%% �鿴��ɽ��

  fun_show(filterfile,2)
%��ȡ���ͼ���е�����
xianggan  = findobj(gcf,'type','image');  
zz_coef   = fliplr(get(xianggan,'cdata'));
close(figure(gcf));
figure;imagesc(xx,yy,zz_coef);colorbar;axis xy;colormap hot;title(strrep(data,'_','\_'));xlabel('��λ��m��');ylabel('������m��');

%==========================================================================
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
        fusion_z(j)      = zz_coef(dyy(j),dxx(j));                               % ��zz���ҵ�dyy��j����dxx��j����Ӧ���α�ֵ
end
end
%DEM_Result       = [X Y d_deleteUseless];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % �����γ�4ά����x��y��z���α�ֵ


%% ��ɢ��ͼ���α�ֵ��Ӧ��ɫ
figure;set(gcf,'Color','w');                                     % ͼ�ν��汳���԰�ɫ��ʾ
scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
%title([strrep(data,'_','\_'),'���ӳ����']);
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
colormap hot;
view(-147,27);
colorbar;
%caxis([0,1.2]);                                                      % �ı�ɫ����ʾ��Χ
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);

%�Ƿ������ǵ�����

