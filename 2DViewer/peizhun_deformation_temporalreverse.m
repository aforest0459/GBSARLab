% =====================================================

% �ó���ʵ���˵����α�ͼ�ļ���ӳ����׼
% last edit:20180701
% 180525 ������α���ʾ�α�ֵ�Ĺ���
% 180602 ����������ݱ�������ֱ��Ϊd_deleteUseless,ע�͵������Ϊinitial_miyun_xyz.mat
%        ���ռ���ƶ�Ӧ�Ķ�άSARͼ������д���˺���pcl2image.m
% 180603 �����˸��ݷ������ֵɸѡ���ݵĹ��ܣ�����coef_stdev.m
%        ��ֵ�˲��޳��쳣ֵ����  
% 180626 �������ۼ��α�ͼ������ĳ������ʾ�α���ʱ��仯ͼ
%        �α�ͼ���Զ����棬���cursor���������һ��yy.txt�ĵ�
% 180701 ���ļ��޸ĳɺ�����ʽ�����뵽�½��Ͻ����ݷ���gui��
%        
%======================================================
% clear all;
% %clear all;
% clc;
function [] = peizhun_deformation_temporalreverse(fullname,pclfile,my_position)
%�½��Ͻ���������
%data              =  '2018_06_29_12_26_02';
%data = difffile;
%% -------------------------------��һ�����������ݶ�ȡ--------------------------
%�����ļ���ȡ��������
% path   =  'D:\001�״����\xingbian\180629xinjiangzijin\xinjiangzijin\initial_miyun_xyz\';
% pclfile = 'xinjianzijin.xyz';
h = waitbar(0,'������...');d_deleteUseless   =  load (pclfile);

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
[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% ѭ����ȡ�α���

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

[nr,nx]  = size(zzcell{1,1});
% ����ÿ�����ص��ۼ��α�ֵ
zz   = zeros(nr,nx);
for i = 1:col
    zz               =  zz + zzcell{i,1};
    %zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;

    zzcumulate{i,1}  =  zz;
end
close(h);
%==========================================================================


%�鿴�����α�����
figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(10);
%cmean = mean(mean(zz));
caxis([-cmean,cmean]);  


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
        fusion_z(j)      = zz(dyy(j),dxx(j));                               % ��zz���ҵ�dyy��j����dxx��j����Ӧ���α�ֵ
end

end
DEM_Result       = [d_deleteUseless dyy dxx];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % �����γ�4ά����x��y��z���α�ֵ
clearvars za yy ya Y xx xingbian xingbian1 xa X pak pa pA nxx nyy list1 list fusion_z  d_deleteUseless

%% ��ɢ��ͼ���α�ֵ��Ӧ��ɫ
figure;set(gcf,'Color','w');                                     % ͼ�ν��汳���԰�ɫ��ʾ
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��

h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-147,27);
colorbar;
caxis([-cmean,cmean]);                                                      % �ı�ɫ����ʾ��Χ
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback4(obj,event_obj,h,zz,zzcell,zzcumulate,xuhao,DEM_Result);



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
