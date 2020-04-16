function []=fun_adjustfig(t,text1,flag)
%% ����
if flag ==1
set(gca,'xtick',(t(1):str2double(get(text1,'String')):t(end)))
end
%% ����
if flag ==2
%(gca,'ytick',(t(1):str2double(get(text1,'String')):t(end)))
ylim([(min(min(t))-5)*str2double(get(text1,'String')) max(max(t))*str2double(get(text1,'String'))])  ;
end
%% grid
if flag ==3
%(gca,'ytick',(t(1):str2double(get(text1,'String')):t(end)))
% �ж��Ƿ����grid������ڹرգ���������ڣ���
if length(get(gca,'XGrid')) ==3
    set(gca,'XGrid','on');
    set(gca,'YGrid','on');
elseif length(get(gca,'XGrid')) == 2
    set(gca,'XGrid','off');
    set(gca,'YGrid','off');
end
end
%% ����˲ʱ�ٶȼ��ۻ��α�ͼ�񱣴�ģ�� SSARLAB
if flag ==4
%Ѱ��ͼ���еĿؼ�
aaa = findall(gcf,'Type','UIControl');
set(aaa,'Visible','off');
%%�ж��ļ�����ͼ���ļ�
for i =1:100
if exist(['myfig',num2str(i),'.tif'],'file')
continue;
elseif ~exist(['myfig',num2str(i),'.tif'],'file')
break;
end
  
end
%saveas(gcf,['myfig',num2str(i),'.tiff'])
print (['myfig',num2str(i)], '-r600', '-dtiff');
helpdlg('ͼ�񱣴�ɹ�','ͼ�񱣴�ɹ�');
%winopen(['myfig',num2str(i),'.tiff']);
set(aaa,'Visible','on');
end

%% ��ά�α�ͼ����ģ�� SSARLAB

if flag ==5
%Ѱ��ͼ���еĿؼ�
aaa = findall(gcf,'Type','UIControl');
set(aaa,'Visible','off');
%%�ж��ļ�����ͼ���ļ�
for i =1:100
if exist([text1,'SSARImage(',num2str(i),')','.tif'],'file')
continue;
elseif ~exist([text1,'SSARImage(',num2str(i),')','.tif'],'file')
break;
end
  
end
%saveas(gcf,['myfig',num2str(i),'.tiff'])
print ([text1,'SSARImage(',num2str(i),')'], '-r600', '-dtiff');
helpdlg('ͼ�񱣴�ɹ�','ͼ�񱣴�ɹ�');
%winopen(['myfig',num2str(i),'.tiff']);
set(aaa,'Visible','on');
end
%% ��ά�α�ͼ��ֵ�˲�ģ�� MeanFilter
if flag ==6
%�����α����ݹ���
xx  = t{1};yy = t{2}; zz=t{3};
zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;

%zz(nyy<20)  = zz(nyy<20)*0.1;
filterwindow = get(text1,'String');
zz_mean = mean_filter(zz,filterwindow);
figure('Name','MeanFiltered Figure');
imagesc(-xx,yy,zz_mean);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');set(gcf,'color','w');colormap parula
%-----------------------------�α�ͼ��ֵ��ʾ-------------------------------
[c,r] = size(zz_mean);
c = round(str2double(filterwindow))*c; r = round(str2double(filterwindow))*r; 
def_cubic  = imresize(zz_mean,[r,c],'bicubic');
figure('Name','Interpolated Figure');imagesc(-xx,yy,def_cubic);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');
set(gcf,'color','w');colormap parula
end
%% ��ά�α�ͼ��ֵ�˲�ģ�� SurfPlot
if flag ==7
%�����α����ݹ���
xx  = t{1};yy = t{2}; zz=t{3};[nxx,nyy]  = meshgrid(-xx,yy);
zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;
min_x = min(min(-xx));
min_y = min(min(yy));
max_x = max(max(-xx));
max_y = max(max(yy));
figure('Name','Surf Figure');
surf(nxx,nyy,zz);colormap gray;zlim([-20 20]);shading interp;hold on;
% plot the image plane using surf.
imgzposition = -15;
% the image data you want to show as a plane.
planeimg = zz;
% scale image between [0, 255] in order to use a custom color map for it.
minplaneimg = min(min(planeimg)); % find the minimum
scaledimg = (floor(((planeimg - minplaneimg) ./ ...
    (max(max(planeimg)) - minplaneimg)) * 255)); % perform scaling
 
% convert the image to a true color image with the jet colormap.
colorimg = ind2rgb(scaledimg,parula(256));
s = surf([min_x max_x],[min_y max_y],repmat(imgzposition, [2 2]),...
    colorimg,'facecolor','texture');
view(27,32);
xlabel('Azimuth\m');ylabel('Range\m');zlabel('Deformation\mm');
set(gcf,'color','w');set(gca,'FontSize',18,'FontWeight','bold');
%--------------------------ͼ�񱣴�------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_adjustfig([],[],5)); % ʹ�þ�����ûص�����
end
%% ��ά��֡�α�ͼȥ���쳣ֵȻ����ʾ
if flag ==8
helpdlg('��Ҫ�˲�');
end
%% �������ֺŵ���
if flag ==9
 aaa = get(gca,'FontSize');
    if aaa ==10
        set(gca,'FontSize',15,'FontWeight','bold');
        colorbar1   = findobj(gcf,'Type','ColorBar');
        axespos     = get(gca,'Position');
        colorbarpos = colorbar1.Position;colorbarpos(1) = axespos(1)+axespos(3)+0.05;
        set(colorbar1,'Position',colorbarpos,'TrickDirection','out');
    elseif aaa ==15
        set(gca,'FontSize',20,'FontWeight','bold');
        colorbar1   = findobj(gcf,'Type','ColorBar');
        axespos     = get(gca,'Position');
        colorbarpos = colorbar1.Position;colorbarpos(1) = axespos(1)+axespos(3)+0.05;
        set(colorbar1,'Position',colorbarpos,'TrickDirection','out');
        set(gca,'FontSize',10);
    elseif aa ==20
        colorbar1 = findobj(gcf,'Type','ColorBar');
         axespos     = get(gca,'Position');
        colorbarpos = colorbar1.Position;colorbarpos(1) =  axespos(1)+axespos(3)+0.05;
        set(colorbar1,'Position',colorbarpos,'TrickDirection','out');
    end
end
%% ��֡����ͼ���ݵ�����DataOutput��
if flag ==10
filename         = t;
fid              = fopen(filename,'rb');
fid2            = fopen(filename,'rb');
fid3            = fopen(filename,'rb');
data_read3      = fread(fid3,'uint16');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  % �÷������Զ�ȡ����������
%% ������������

a1 = data_read3(1);a2 = data_read3(3);
% a1 = length(find(rem(data_read,0.3) ==0 & data_read~=0));
% a2 = length(find(abs(data_read)>data_read(a1+3)-data_read(a1+2)-0.001))+1-a1;
data_read0 =   [a1;a2];
data_read1 =   data_read(2:data_read0(1)+data_read0(2)+1);

fclose(fid);fclose(fid2);fclose(fid3);
data_read_int     = data_read_int((a1+a2)*2+3:end,:);
imgamp            = data_read_int(1:2:end,:);
imgphase          = data_read_int(2:2:end,:);
j = sqrt(-1);
defo = imgamp +j*imgphase;
data_read3 = reshape(defo,a1,a2);
% ��ȡ����ͼ���е�����
Ampimg                      = findobj(gcf,'type','image');   
AmpData.xaxis               = data_read1(a1+1:end,:);
AmpData.yaxis               = data_read1(1:a1,:);
AmpData.amplitude           = get(Ampimg,'CData');
AmpData.complex             = data_read3;

if ~exist('E:\SSARLAB\SSARamplitude\','dir')
    mkdir('E:\SSARLAB\SSARamplitude\');
end
save (['E:\SSARLAB\SSARamplitude\',text1,'AmpData','.mat'],'AmpData');
% filename = [text1,'AmpData','.mat'];
% save (filename,'AmpData');
helpdlg('����ɹ�','����ɹ�');
end
%% ����ͼ���ݵ�������鿴
if flag ==11
    winopen('E:\SSARLAB\SSARamplitude\');
end
%% ���ͼ���ݵ�������鿴
if flag ==12
    
end
%% ���ֵ�������л�
if flag ==13
% ֻ��ʾ���׶���ʽ�������
   figure('Name','���׶���ʽ����ٶ�');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
   plot(t,text1{1},'Linewidth',3);set(gca,'XTickLabelRotation',45,'FontWeight','bold','FontSize',15);
   legend(text1{2});ylabel('Velocity(mm/per-image)')
end
%% ��ƽ������
if flag ==14
% ֻ��ʾ���׶���ʽ�������
  
   time1 = t{1}; data_vel = t{2}; 
 % --------------------------��ֵ�˲�----------------------
   zz = data_vel;
[col,row]                  = size(zz);
n_mean                     = str2double(get(text1,'String'));                                  % ������������
%m_mean                     = 7;                                  % ��λ��������
n_meanmid                  = (n_mean+1)/2;                       % ���������������ĵ�
%m_meanmid                  = (m_mean+1)/2;                       % ��λ�����������ĵ�
mean_ES                    = ones(col,row);                      % ��ά��rho�ĵ�����Figͼ����ͬ
%mean_ES(n_rhomid,m_rhomid) = 0;
%mean_ES(n_rhomid+1)        = mean(mean(zz(1:n_mean+1,1:m_mean+1))); 

%e             = waitbar(0,'��ֵ�˲�������...');
for i      = 1:row
    for j  = 1:col-n_mean-1
              mean_ES(n_meanmid+j-1,i)   = mean(zz(j:n_mean+j-1,i));
    end
end
data_meanvel = mean_ES;
%close(e);
 figure('Name','������ƽ���ٶ�');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
  plot(time1(n_meanmid:col-n_mean-1,:),data_meanvel(n_meanmid:col-n_mean-1,:),'Linewidth',3);set(gca,'XTickLabelRotation',45,'FontWeight','bold','FontSize',15);
   legend(t{3});ylabel('Velocity(mm\h)');hold on;
   plot(time1(n_meanmid:col-n_mean-1,:),data_vel(n_meanmid:col-n_mean-1,:));
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_savefig()); % ʹ�þ�����ûص�����
end
%% ֻ��ʾԭʼ����
if flag ==15
% ֻ��ʾԭʼ����
t1 = t{1};data_vel = t{2};
   figure('Name','�ٶ�����');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
   plot(t1,data_vel);set(gca,'XTickLabelRotation',45,'FontWeight','bold','FontSize',15);
   legend(text1);ylabel('Velocity(mm/per-image)')
end

%% α��ά��ʾplot3
if flag ==16
% α��ά��ʾ
t1 = t{1};data_vel = t{2};y1=1:50:50*size(data_vel,2);
figure('Name','�ٶ��ٲ�ͼ');set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w');
for i=1:size(data_vel,2)
   % y=1:size(data_vel,2);
    y = y1(i).*ones(size(data_vel,1));
    plot3(t1,y,data_vel(:,i));
    hold on
end
set(gca,'YTickLabel',text1,'FontWeight','bold','FontSize',15);
xlabel('Time');zlabel('Velocity(mm/per-image)')
legend(text1);
grid on
end
%% mesh ͼ
if flag ==17
[Te,Fe]=meshgrid(t{1},t{2});

end
%% �������д���У���ȶ�����ʱ��仯��ϵ
if flag ==18
    n=1;
    DEM_Result = text1.DEM_Result;
    p_r        = text1.p_r;
    zzcell     = t;
    %-------------ͳ��cursor��--------------
handle = allchild(gca);
num = length(handle);
   hhh = allchild(gca);
    zzcell = zzcell';
  for i = 1:num-1
   position{i} = hhh(i).Cursor.Position;
   % �ҳ�ÿ�����Ӧ��ʱ���α�
   ii =  find(DEM_Result(:,1) == position{i}(1) & DEM_Result(:,2) == position{i}(2) & DEM_Result(:,3) == position{i}(3)); 
   r1{i}       = p_r(ii,1); 
   m = DEM_Result(ii,end-1);
    n = DEM_Result(ii,end);
   
    [r,c] = size(zzcell{1});zz = zeros(r,c);
        for ii = 1:length(zzcell)
         a(ii)  = zzcell{ii,1}(m(1),n(1)); % ����ͼ��ÿһ��ֵ����zzcell��ȡ��
         zz               =  zz + zzcell{ii,1}; % 
    %zz(zz==zz(15,15) | zz==-zz(15,15)) = zz(zz==zz(15,15) | zz==-zz(15,15))*1e-6;

            zzcumulate{ii,1}  =  zz;
             a1(ii) = zzcumulate{ii,1}(m(1),n(1));% 
        end
     phidata{i} = a1;
     kpqc{i} = phidata{i}./r1{i};
  n = 1; 
  end
 
gcp.position = position;
gcp.phidata  = phidata;
gcp.r        = r1;
gcp.kpqc     = kpqc;
figure; 
for j = 1:length(kpqc)
    plot(kpqc{j});hold on;
    kpqc2(j,:) = kpqc{j};
end
hold off;
gcp.dk = max(kpqc2)-min(kpqc2);
save gcp.mat   gcp;
%n  =1;
helpdlg('�ȶ��㱣��ɹ�');
end

end
