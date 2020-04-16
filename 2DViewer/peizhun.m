%% �½��Ͻ�������׼
% =====================================================

% �ó���ʵ���˵����α�ͼ�ļ���ӳ����׼
% last edit:20180701
% 180525�������γ�DEM_Result.dat���ܣ��α����ݱ������������[X Y xa ya za];ǰ���ж�Ӧ(δ��֤)
% 180629�½��Ͻ𵥷�������׼
% 180701�½�������׼�෴�ˣ������ݽ������ҵ���

%======================================================
%clear all;
%close all;
%===================================

%��ά�ռ�㵽����ľ������

%===================================
function [] = peizhun(difffile,pclfile,my_position)
%�½��Ͻ���������
%data              =  '2018_06_29_12_26_02';
data = difffile;%��.DiffImage��׺
%% -------------------------------��һ�����������ݶ�ȡ--------------------------
%�����ļ���ȡ��������
%path   =  'D:\001�״����\xingbian\180629xinjiangzijin\xinjiangzijin\initial_miyun_xyz\';
%pclfile = 'xinjianzijin.xyz';
pcl  = pclfile;
d_deleteUseless   =  load (pcl);
%clearvars            ScanPos001___POINTCLOUDS___180523_145753_2cm;        % �����ʱ����
% save                 initial_miyun_xyz.mat d_deleteUseless;
% load                 'initial_miyun_xyz.mat';                            % ��ȡ����õĵ������ݣ�ʹ��ʵ��������� 
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

%file3            = [data,'.DiffImage'];
file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% ��ȡ�α�ͼ���е�����
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
zz               = fliplr(get(xingbian,'cdata'));
%zz(zz>3.5 | zz<-3.5) = zz(1,1);                                     % �α��쳣ֵ����
close(figure(gcf));
%�鿴�����α�����
%figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');
%title(strrep(data,'_','\_'));
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
%DEM_Result       = [X Y pa];
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % �����γ�4ά����x��y��z���α�ֵ
% DEM_Result       = [d_deleteUseless(:,1);d_deleteUseless(:,2);d_deleteUseless(:,3); dxx;dyy ];
% % save DEM_Result.dat DEM_Result -ascii
% fid = fopen('DEM_Result.dat','wb');
% fwrite(fid,DEM_Result,'double');
% fclose(fid);

%% ��ɢ��ͼ���α�ֵ��Ӧ��ɫ
figure;set(gcf,'Color','w');                                     % ͼ�ν��汳���԰�ɫ��ʾ
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��
h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;
%title([strrep(data,'_','\_'),'�α�ӳ����']);
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-130,24);
colorbar;
caxis([-4,4]);                                                      % �ı�ɫ����ʾ��Χ
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback(obj,event_obj,h);



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
