% =====================================================

% �ó���ʵ���˵����α�ͼ�ļ���ӳ����׼
% last edit:20180626
% 180525 ������α���ʾ�α�ֵ�Ĺ���
% 180602 ����������ݱ�������ֱ��Ϊd_deleteUseless,ע�͵������Ϊinitial_miyun_xyz.mat
%        ���ռ���ƶ�Ӧ�Ķ�άSARͼ������д���˺���pcl2image.m
% 180603 �����˸��ݷ������ֵɸѡ���ݵĹ��ܣ�����coef_stdev.m
%        ��ֵ�˲��޳��쳣ֵ����  
% 180626 �������ۼ��α�ͼ������ĳ������ʾ�α���ʱ��仯ͼ
%======================================================
clear all;
%clear all;
clc;

%�½��Ͻ���������
data              =  '2018_06_29_12_26_02';
%% -------------------------------��һ�����������ݶ�ȡ--------------------------
%�����ļ���ȡ��������
path   =  'D:\001�״����\xingbian\180629xinjiangzijin\xinjiangzijin\initial_miyun_xyz\';
pclfile = 'initial_miyun_xyz.mat';
d_deleteUseless   =  cell2mat(struct2cell(load ([path,pclfile])));
%clearvars            ScanPos001___POINTCLOUDS___180523_145753_2cm;        % �����ʱ����
% save                 initial_miyun_xyz.mat d_deleteUseless;
% load                 'initial_miyun_xyz.mat';                            % ��ȡ����õĵ������ݣ�ʹ��ʵ��������� 

%% ����ռ��pa������Ĵ���pk֮�����dY���Լ�pk������е�p0��λ����dX
% ���������˵����꣬Ȼ�������λ����
railfile          = 'my_position.txt';
p_rail            = load ([path,railfile]);

p1                = p_rail(1,:);                                  % ��˵�


p2                = p_rail(2,:);                                 % �Ҷ˵�
%p0               = (p1+p2)/2;

rail              = norm(p1-p2);disp(['����Ĺ������',num2str(rail)]);

[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                      % ����Ѱ��ͼ���϶�ά����



%% �������ݻ�õĶ�ά������ʵ���α�ͼ�еĶ�ά����ƥ��
%=========================================================================

%��ʱ��pA��������ʵ���α�ͼ�еĶ�ά����һһ��Ӧ��������ҪѰ���ٽ��㷽�������ڽ�����α�ֵ����pA
%�Ȼ��ʵ���α����ݵľ�����yy�����ᣬ��λ��xx�����ᣬ�α�����zz

%��DiffImage�ж�ȡ�����������

file3            = [data,'.DiffImage'];
fun_show_xingbian  (file3,3);
title              (strrep(data,'_','\_'));
% ��ȡ�α�ͼ���е�����
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
zz               = get(xingbian,'cdata');
close(figure(gcf));

%{
%% �������ͼ��������
% �鿴��ɽ��
  file2   = [data,'.AfterFilter'];
  fun_show(file2,2)
%��ȡ���ͼ���е�����
xianggan  = findobj(gcf,'type','image');  
zz_coef   = get(xianggan,'cdata');
close(figure(gcf));
% ������������
datalist      = 'AfterFilterlist';
list          = importdata([datalist,'.txt']);                    % Ϊafterfilter�ļ���Ԫ�����飬char��ʽ
DA            = coef_stdev(list);

% �α��쳣ֵ����
% zz_reflector     = zz(90:92,64:67);
zz(zz==zz(2,1) | zz==-zz(2,1)) = 1e-6;
zz(zz_coef<0.9 & zz_coef>0)    = 1e-5;                            % ���ϵ������0.9
zz(DA>0.065 & DA<1)            = 1e-5;                            % �������С��0.065
% zz = zz*0.5;
% zz(90:92,64:67)  = zz_reflector;



%------------------------------
%��������ֵ�˲�
%------------------------------

[col,row]                  = size(zz);
n_mean                     = 7;                                  % ������������
m_mean                     = 3;                                  % ��λ��������
n_meanmid                  = (n_mean+1)/2;                       % ���������������ĵ�
m_meanmid                  = (m_mean+1)/2;                       % ��λ�����������ĵ�
mean_ES                    = ones(col,row);                      % ��ά��rho�ĵ�����Figͼ����ͬ
%mean_ES(n_rhomid,m_rhomid) = 0;
%mean_ES(n_rhomid+1)        = mean(mean(zz(1:n_mean+1,1:m_mean+1))); 

e             = waitbar(0,'��ֵ�˲�������...');
for i      = 1:col-n_mean-1
    for j  = 1:row-m_mean-1
              mean_ES(n_meanmid+i-1,m_meanmid+j-1)   = mean(mean(zz(i:n_mean+i-1,j:m_mean+j-1)));
    end
    waitbar(i/(col-n_mean-1),e);
end
close(e);

zz         = mean_ES;


%�鿴�����α�����
figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('��λ��m��');ylabel('������m��');
%}

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
fusion_z(j)      = zz(dyy(j),dxx(j));                               % ��zz���ҵ�dyy��j����dxx��j����Ӧ���α�ֵ
end
DEM_Result       = [X Y d_deleteUseless];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % �����γ�4ά����x��y��z���α�ֵ


%% ��ɢ��ͼ���α�ֵ��Ӧ��ɫ
figure;set(gcf,'Color','w');                                     % ͼ�ν��汳���԰�ɫ��ʾ
scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
title([strrep(data,'_','\_'),'�α�ӳ����']);xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-147,27);
colorbar;
caxis([-4,4]);                                                      % �ı�ɫ����ʾ��Χ
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);

%�Ƿ������ǵ�����


%% ������ά���溯��

% % ��ϡ
% n_sparse      =  1:1000:length(pA_3d_fusion); % ���ڵľ�����2cm���ٸ�5��ȡһ����Ӧ��Ϊ10cm
% 
% [Axx,Ayy,Azz]  = meshgrid(pA_3d_fusion(n_sparse,1),pA_3d_fusion(n_sparse,2),pA_3d_fusion(n_sparse,3));
% figure;set(gcf,'Color','w');
% mesh(Axx,Ayy,Azz);


%������ά�����Լ�����ǿ�ȵĹ�ϵ
% figure;set(gcf,'Color','w'); 
% scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,d_deleteUseless(:,4),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ
% axis image;title('���Ʒ���ǿ��ͼ');xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
% view(15,20);
% colorbar;
% caxis([0 3000])


% %������ά�����Լ�����Ĺ�ϵ
% pa_range  = zeros(col_pA,1);
% for i = 1:col_pA
%         pa_range(i,1) = norm(pA_3d_fusion(i,1:3));
% end
% figure;set(gcf,'Color','w'); 
% scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pa_range(:,1),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ
% axis image;title('���ƾ�����ʾͼ');xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
% view(15,20);
% colorbar;
% %caxis([0 3000])
