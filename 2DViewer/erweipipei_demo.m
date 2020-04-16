%% ��ά����άӳ��ƥ�����

% load '.\lianxishuju\range_y.mat';
% load '.\lianxishuju\fangwei_x.mat';
% load '.\lianxishuju\zz.mat';
%% ��ʼ��
clear all;
clc;
close all;
%% ʹ�õ�����һ���α�����
data      =  '2018_05_23_14_53_08';
%% ------------------------------��һ�����鿴�α���---------------------------------
 file3    = [data,'.DiffImage'];
 fun_show_xingbian(file3,3);
 title(strrep(data,'_','\_'));
%��ȡ�α�ͼ���е�����
xingbian  = findobj(gcf,'type','image');   
xx        = -get(xingbian,'xdata');                             % �α�ͼ����
yy        = get(xingbian,'ydata');                              % �α�ͼ����
zz        = get(xingbian,'cdata');                              % �α�ֵ
%�γ�������������
[nxx,nyy] = meshgrid(xx,yy);                                    % nxxΪ�α�ͼÿ���Ӧ�ĺ����꣬nyyΪÿ���Ӧ��������
close(figure(gcf));
figure;imagesc(xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('��λ��m��');ylabel('������m��');

%% ------------------------------�ڶ������鿴�α���---------------------------------
%{
[colum_pA,row_pA] = size(pA);
dxx = zeros(colum_pA,1);dyy = zeros(colum_pA,1);
fusion_z = zeros(colum_pA,1);
for j = 1:colum_pA
dyy(j) = round((pA(j,2)-yy(1))/0.3)+1;%��Ӧ������y������±�
dxx(j) = round((pA(j,1)-xx(1))/5.3216)+1;%��Ӧ��λ��x������±�
fusion_z(j) = zz(dyy(j),dxx(j));%��zz���ҵ�dyy��j����dxx��j����Ӧ���α�ֵ
end
pA_fusion = [pA fusion_z];
pA_3d_fusion = [d_deleteUseless fusion_z];%�γ�4ά����x��y��z���α�ֵ

%% ��ɢ��ͼ���α�ֵ��Ӧ��ɫ
figure(1);set(gcf,'Color','w');%ͼ�ν��汳���԰�ɫ��ʾ
scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,4),'filled');%x,y,z,��ϸ��ǿ�ȣ���״��Ĭ����Ȧ��
axis image;
colorbar;
caxis([-0.5,0.5]);%�ı�ɫ����ʾ��Χ

%
%% ŷʽ�������ƥ�䷽��
%==========================================================================

%�ټ����pA��ÿ������img��ÿ����ľ��룬ѡ����̾����Ӧ�ĵ㣬�α�ֵһ��

%==========================================================================
r_fusion = zeros(Nimg,1);
pA_fusion = zeros(colum_pA,1);

        for i = 1:Nimg
             
            r_fusion(i,1) = sqrt((pA(1,1)-img(i,2))^2+(pA(1,2)-img(i,3))^2);
            
        end
[minx, id] = min(r_fusion);%���Ҿ�������С��Ԫ�ز��ҷ������Ӧ�к����к�
pA_fusion(1) = img(id,1);
%}
%==========================================================================