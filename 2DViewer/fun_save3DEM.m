function [] = fun_save3DEM(fullname,pclfile,my_position)
%�½��Ͻ���������
h = waitbar(0,'������....');
data = fullname;%��.DiffImage��׺
%data = difffile;%��.DiffImage��׺
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
% ��ͼ���л��xx
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
[nxx,nyy]        = meshgrid(xx,yy);
% ȡ���������෴ʱ��ʹ��
zz               = fliplr(get(xingbian,'cdata'));
%zz               = zz';
%zz               = get(xingbian,'cdata');

%zz(zz>3.5 | zz<-3.5) = zz(1,1);                                     % �α��쳣ֵ����
close(figure(gcf));
%�鿴�����α�����
%figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');
%title(strrep(data,'_','\_'));
%% ����yy����Զ�෴�㣬����ÿ�����ص㼫������ֱ������ת�����ȡ��Ӧ����ͼ
file1 = strrep(file3,'DiffImage','RadarImage');
%% �鿴������
 
 fun_show(file1,1,0.05);
% ��ȡ�α�ͼ���е�����
Image         = findobj(gcf,'type','image');   
% ��ͼ���л��theta��rou
theta             = get(Image,'xdata');
rou               = get(Image,'ydata');
amp               = get(Image,'cdata');
close(figure(gcf));
figure;imagesc(amp);colorbar;axis xy;colormap gray;%title(strrep(data,'_','\_'));
caxis([min(min(amp))*0.05 max(max(amp))*0.05]);

% ʹ��forѭ��������ÿ�����ض�Ӧ��ֱ������dX��dY
for c = 1:length(rou)
    for r = 1:length(theta)
        X(c,r)  = rou(c)*cosd(theta(r));
        Y(c,r)  = rou(c)*sind(theta(r));
    end
end


%% ==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_zΪ��Ӧ���α�ֵ
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % ��Ӧ������y������±�
dxx(j)           = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % ��Ӧ��λ��x������±�
if dyy(j)>0 && dyy(j) < size(nxx,2) && dxx(j) >0 && dxx(j) < length(nyy)
   
        X(j)             = nxx(dyy(j),dxx(j));
        Y(j)             = nyy(dyy(j),dxx(j));
        fusion_z(j)      = zz(dyy(j),dxx(j));                               % ��zz���ҵ�dyy��j����dxx��j����Ӧ���α�ֵ
end

end
%  �����ά����ת���ɵȼ۵�һά���飬ԭ��ά������Ԫ��ת����һά������һά�����е��±�
%���ά������n��m�У����(i,j)��Ԫ����һά�����е��±���(i-1)*m+j
%dd = (dyy-1)*size(nxx,2)+dxx;
DEM_Result       = [d_deleteUseless dyy dxx];
DEM_Result       = DEM_Result(dyy>0 & dxx>0,:);
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % �����γ�4ά����x��y��z���α�ֵ
save DEM_Result.mat DEM_Result
%clearvars za yy ya Y xx xingbian  xa X pak pa pA nxx nyy  fusion_z  d_deleteUseless
close(h);
figure;set(gcf,'Color','w');                                     % ͼ�ν��汳���԰�ɫ��ʾ
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��
h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
axis image;

%title([strrep(data,'_','\_'),'�α�ӳ����']);
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(-130,24);
colorbar;
caxis([-4,4]);                                     