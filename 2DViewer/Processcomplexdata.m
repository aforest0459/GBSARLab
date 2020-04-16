function varargout = Processcomplexdata(varargin)
% PROCESSCOMPLEXDATA MATLAB code for Processcomplexdata.fig
%      PROCESSCOMPLEXDATA, by itself, creates a new PROCESSCOMPLEXDATA or raises the existing
%      singleton*.
%
%      H = PROCESSCOMPLEXDATA returns the handle to a new PROCESSCOMPLEXDATA or the handle to
%      the existing singleton*.
%
%      PROCESSCOMPLEXDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROCESSCOMPLEXDATA.M with the given input arguments.
%
%      PROCESSCOMPLEXDATA('Property','Value',...) creates a new PROCESSCOMPLEXDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Processcomplexdata_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Processcomplexdata_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Processcomplexdata

% Last Modified by GUIDE v2.5 15-Oct-2018 00:09:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Processcomplexdata_OpeningFcn, ...
                   'gui_OutputFcn',  @Processcomplexdata_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Processcomplexdata is made visible.
function Processcomplexdata_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Processcomplexdata (see VARARGIN)

% Choose default command line output for Processcomplexdata
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Processcomplexdata wait for user response (see UIRESUME)
% uiwait(handles.Dataprocess);


% --- Outputs from this function are returned to the command line.
function varargout = Processcomplexdata_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 数据批量读取，默认搜索路径为E:\SSARLAB 或E:\SSARLAB3D
if exist('E:\SSARLAB','dir')
[FileName,PathName] = uigetfile({'*.mat';'*.*'},'成像文件选取','MultiSelect', 'on','E:\SSARLAB\SSARamplitude');
elseif exist('E:\SSARLAB3D','dir')
[FileName,PathName] = uigetfile({'*.mat';'*.*'},'成像文件选取','MultiSelect', 'on','E:\SSARLAB3D\SSARamplitude');
else 
[FileName,PathName] = uigetfile({'*.mat';'*.*'},'成像文件选取','MultiSelect', 'on');
end
%---------------------------如果未选取文件即报错----------------------------    
if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
end    
fullname=strcat(PathName,FileName);
handles.AmpData = fullname;
guidata(hObject,handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 计算相干图
if isfield(handles,'AmpData')==0
    errordlg('请先单击数据选取');
end
% 循环读取数据
list = handles.AmpData;list = list';                      
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
[col,row]  = size(list1);
for i = 1:col
    load(list1(i,1:end));
    s{i} = AmpData.complex;
    xaxis{i}= AmpData.xaxis;
    yaxis{i}= AmpData.yaxis;
end
%% 两两之间计算相干性
%a = struct('correlation',[],'xaxis',[],'yaxis',[]);
a = struct();
for i = 2:col
    [AfterFilter{i-1},deltaR{i-1}]=fun_correlation(s{i},s{i-1},get(handles.edit5,'String'),get(handles.edit6,'String'));
    %a = AfterFilter{i-1};
    a.correlation = AfterFilter{i-1};
    a.deltaR = deltaR{i-1};
    a.xaxis = xaxis{i};
    a.yaxis = yaxis{i};
    %--------------保存相干数据----------------------
    if ~exist('E:\SSARLAB\SSARafterFilter\','dir')
        mkdir('E:\SSARLAB\SSARafterFilter\');
    end
    save(['E:\SSARLAB\SSARafterFilter\',xuhao(i,:),'correlationData.mat'],'a');
end

winopen('E:\SSARLAB\SSARafterFilter\');

guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 读取相干图
[FileName,PathName] = uigetfile({'*.mat';'*.*'},'相干文件选取','MultiSelect', 'on','E:\SSARLAB\SSARafterFilter\');
%---------------------------如果未选取文件即报错----------------------------    
if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
end    

%%
fullname = strcat(PathName,FileName);
%% 先区分是选择了多个数据还是单个数据
if class(fullname) == 'cell'
    % 循环读取数据
    list =fullname';                      
    for i = 1:length(list)
    list1(i,:) = list{i,1}(:);
    a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
    xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
    end
    [col,row]  = size(list1);
     load(list1(1,1:end)); 
    xx = a.xaxis;yy = a.yaxis;
    zz = zeros(length(yy),length(xx));  
    def = zeros(length(yy),length(xx));  
for i = 1:col
    load(list1(i,1:end));
   zzcell{i} = a.correlation;
    zz   =  zz + zzcell{i};
    defcell{i} = a.deltaR;
    defcell{i}(zzcell{i}<0.7) = 0.0045;
    defcell{i} =  defcell{i}*1e3;
    def  =  def+ defcell{i};
end
   
   imagesc(handles.axes1,-xx,yy,zz); colorbar(handles.axes1);
   axis(handles.axes1,'xy')  ;xlabel(handles.axes1,'方位向（Rad）');ylabel(handles.axes1,'距离向（m）');
   title(handles.axes1,'相干系数图');
   colormap(handles.axes1,'hot') ;
   imagesc(handles.axes2,-xx,yy,def); colorbar(handles.axes2);
   axis(handles.axes2,'xy')  ;xlabel(handles.axes2,'方位向（Rad）');ylabel(handles.axes2,'距离向（m）');
   colormap(handles.axes2,'default') ;
   title(handles.axes2,'形变图');
else
    load(fullname);
    col = 1;
    zz = a.correlation;
    xx          = a.xaxis;
    yy          = a.yaxis;
    def         = a.deltaR;
    def(zz<0.7) = 0.0045;
    def = def*1e3;
   
   imagesc(handles.axes1,-xx,yy,zz); colorbar(handles.axes1);
   axis(handles.axes1,'xy')  ;xlabel(handles.axes1,'方位向（Rad）');ylabel(handles.axes1,'距离向（m）');
   title(handles.axes1,'相干系数图');
   colormap(handles.axes1,'hot') ;
   imagesc(handles.axes2,-xx,yy,def); colorbar(handles.axes2);
   axis(handles.axes2,'xy')  ;xlabel(handles.axes2,'方位向（Rad）');ylabel(handles.axes2,'距离向（m）');
   colormap(handles.axes2,'default') ;
   title(handles.axes2,'形变图');
end
handles.xaxis = -xx;
handles.yaxis = yy;
handles.corr = zz;
handles.def = def;
handles.imagenum = col;
handles.xuhao    = xuhao;

guidata(hObject,handles);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 读取相干图
[FileName,PathName] = uigetfile({'*.mat';'*.*'},'相干文件选取','MultiSelect', 'on','E:\SSARLAB\SSARafterFilter\');
%---------------------------如果未选取文件即报错----------------------------    
if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
end    

%%
fullname = strcat(PathName,FileName);
%% 先区分是选择了多个数据还是单个数据
if class(fullname) == 'cell'                                              % 选择了多个数据
    % 循环读取数据
    list =fullname';                      
    for i = 1:length(list)
    list1(i,:) = list{i,1}(:);
    a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
    xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
    xuhao1(i,:) = strrep(xuhao(i,:),'AmpDatacorrelationData','');
    end
    
    [col,row]  = size(list1);
    load(list1(1,1:end)); 
    xx = a.xaxis;yy = a.yaxis;                                            % 从相干文件中读入坐标
    zz = zeros(length(yy),length(xx));  
    def = zeros(length(yy),length(xx));
for i = 1:col
    load(list1(i,1:end));
    zzcell{i}  = a.correlation;                                           % 读取相干图
    defcell{i} = a.deltaR;                                                % 读取形变图△R
    defcell{i}(zzcell{i}<str2double(get(handles.edit1,'String'))) = 1e-8;                                   % 以0.7作为阈值
    defcell{i} = defcell{i}*1e3;
    zz   =  zz + zzcell{i};
    def  =  def+ defcell{i};
    
end
   
   imagesc(handles.axes1,xx,yy,zz); colorbar(handles.axes1);
   axis(handles.axes1,'xy')  ;xlabel(handles.axes1,'方位向（Rad）');ylabel(handles.axes1,'距离向（m）');
   title(handles.axes1,'相干系数图');
   colormap(handles.axes1,'hot') ;
   imagesc(handles.axes2,xx,yy,def); colorbar(handles.axes2);
   axis(handles.axes2,'xy')  ;xlabel(handles.axes2,'方位向（Rad）');ylabel(handles.axes2,'距离向（m）');
   colormap(handles.axes2,'default') ;
   title(handles.axes2,'形变图');
else
    load(fullname);
    col = 1;
    zz = a.correlation;
    xx          = a.xaxis;
    yy          = a.yaxis;
    def         = a.deltaR;
    def(zz<str2double(get(handles.edit1,'String'))) = 0.0045;
    def = def*1e3;
   
   imagesc(handles.axes1,xx,yy,zz); colorbar(handles.axes1);
   axis(handles.axes1,'xy')  ;xlabel(handles.axes1,'方位向（Rad）');ylabel(handles.axes1,'距离向（m）');
   title(handles.axes1,'相干系数图');
   colormap(handles.axes1,'hot') ;
   imagesc(handles.axes2,xx,yy,def); colorbar(handles.axes2);
   axis(handles.axes2,'xy')  ;xlabel(handles.axes2,'方位向（Rad）');ylabel(handles.axes2,'距离向（m）');
   colormap(handles.axes2,'default') ;
   title(handles.axes2,'形变图');
end

%% 句柄整理
handles.xaxis = xx;
handles.yaxis = yy;
handles.corr = zz;
handles.def = def;
handles.imagenum = col;
handles.xuhao    = xuhao1;
handles.defcell   = defcell;
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;imagesc(handles.xaxis,handles.yaxis,handles.corr);colorbar;axis xy;xlabel('方位向（Rad）');ylabel('距离向（m）');colormap hot;
set(gcf,'color','w');
guidata(hObject,handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%hz = zoom(handles.axes1);
close(gcf);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hd = datacursormode;
%hd.UpdateFcn = @(obj,event_obj) NewCallback6(obj,event_obj,h,zz,zzcell,zzcumulate,xuhao);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
def = handles.def;
corr = handles.corr;
col=handles.imagenum  ;
def(corr<str2double(get(handles.edit3,'String'))*col) = 1e-5;
imagesc(handles.axes2,handles.xaxis,handles.yaxis,def);colorbar(handles.axes2);
   axis(handles.axes2,'xy')  ;xlabel(handles.axes2,'方位向（Rad）');ylabel(handles.axes2,'距离向（m）');
   colormap(handles.axes2,'default') ;
   title(handles.axes2,'形变图');
%handles.def = def;
handles.def2 = def;
guidata(hObject,handles);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
def = handles.def;
corr = handles.corr;
col=handles.imagenum  ;
def(corr<str2double(get(handles.edit1,'String'))*col) = 4.5;
figure;imagesc(handles.xaxis,handles.yaxis,def);colorbar;axis xy;xlabel('方位向（Rad）');ylabel('距离向（m）');
set(gcf,'color','w');
   title('形变图');
%handles.def = def;
guidata(hObject,handles);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 幅度离差计算
%% 读取相干图
[FileName,PathName] = uigetfile({'*.mat';'*.*'},'相干文件选取','MultiSelect', 'on','E:\SSARLAB\SSARafterFilter\');
%---------------------------如果未选取文件即报错----------------------------    
if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
end    

%%
fullname = strcat(PathName,FileName);
%% 先区分是选择了多个数据还是单个数据
if class(fullname) == 'cell'
    % 循环读取数据
    list =fullname';                      
    for i = 1:length(list)
    list1(i,:) = list{i,1}(:);
    a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
    xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
    end
    [col,row]  = size(list1);
    load(list1(1,1:end)); 
    xx = a.xaxis;yy = a.yaxis;
    zz = zeros(length(yy),length(xx));  
%% 幅度离差MA(i,j)计算  
 % 循环读取相干数据
for i = 1:col
    load(list1(i,1:end));
    zz_coef{i,1} = a.correlation;
end
[nr,nx]  = size(zz_coef{1,1});
% 计算每个像素点均值幅度MA
MA = zeros(nr,nx);        % 初始化变量
for i = 1:col
    MA = MA+zz_coef{i,1};
end
MA    = MA/col;
SA     = cell(nr,nx);   % 初始化变量 
SA_std = zeros(nr,nx);  % 初始化变量
% 计算标准差
h             = waitbar(0,'计算中...');
 for m  = 1:nx 
     for n  = 1:nr
         for i = 1:col
              SA{n,m}      = [SA{n,m} zz_coef{i,1}(n,m)];               
         end
         a            = SA{n,m};
         SA_std(n,m)  = std(a);
     end
waitbar(m/nx,h);
 end
close(h);
% 计算幅度离差DA
DA  = SA_std./MA;

% DA图像显示
imagesc(handles.axes1,xx,yy,DA); colorbar(handles.axes1);
   axis(handles.axes1,'xy')  ;xlabel(handles.axes1,'方位向（Rad）');ylabel(handles.axes1,'距离向（m）');
   title(handles.axes1,'幅度离差图');
   colormap(handles.axes1,flipud(hot)) ;

%% 如果选取了单幅图即报错
else
     errordlg('请选取多个相干图导出文件');
end 
%% 句柄整理
handles.DA  = DA;
handles.xaxis= xx;  handles.yaxis = yy;
handles.imagenum = col;
%handles.def = def;
guidata(hObject,handles);
    


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 幅度离差分析弹窗图
DA = handles.DA;
figure;imagesc(handles.xaxis,handles.yaxis,DA);colorbar;axis xy;xlabel('方位向（Rad）');ylabel('距离向（m）');colormap(flipud(hot));
set(gcf,'color','w');
   title('幅度离差分析图');


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% DA值投射三维点云

data = handles.DA;          

%% -------------------------------第一步：点云数据读取--------------------------
h = waitbar(0,'三维计算中....');
%-----------------------选取点云数据------------------
if ~isfield('handles','pclfile') 
     % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取',handles.prjdir);
    end

fullnamepcl = strcat(PathName,FileName);
pclfile = fullnamepcl;
handles.pclfile = pclfile;
end
% 未选择即报错
if isempty(handles.pclfile)
    errordlg('先选择点云文件');
end

pclfile = handles.pclfile;
pcl  = pclfile;
d_deleteUseless   =  load (pcl);

xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
Na                = length(xa);                                           % 点云的点数
%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
%----------------------选取轨道文件---------------------
if ~isfield('handles','my_position')
[FileName,PathName] = uigetfile({'*.txt';'*.*'},'轨道文件选取',handles.prjdir);
fullnamerail=strcat(PathName,FileName);
my_position =fullnamerail;
handles.my_position = my_position;
else
    my_position =handles.my_position ;
end
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail            = load (railfile);
p1                = p_rail(1,:);                                  % 左端点
p2                = p_rail(2,:);                                  % 右端点
x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % 轨道外a点
[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                      % 点云寻找图像上二维坐标
%% 点云数据获得的二维坐标与DA图中的二维坐标匹配
%=========================================================================
%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz
%从handles中读取所需的坐标轴
% 方案1：从图像中获得xx
xx               = handles.xaxis;
xx               = -xx;                      % 上一语句读入会造成左右相反的情况，所以需要反转
yy               = handles.yaxis;
[nxx,nyy]        = meshgrid(xx,yy);
zz               = data;
%查看该组形变数据
figure;imagesc(-xx,yy,zz);colorbar;colormap(flipud(hot));axis xy;xlabel('方位向（rad）');ylabel('距离向（m）');
title(strrep(data,'_','\_'));
% 计算点云的方位角
p_view  = atan(pA(:,1)./pA(:,2));


%% ==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
%dxx(j)           = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
% 方案2 角度匹配如果p_view 超过了雷达最大角度即continue
    if p_view(j,1)>max(xx) || p_view(j,1)<min(xx)
        continue;
    else
            dxx(j)           = round((p_view(j,1)-xx(1))/(xx(2)-xx(1)))+1;
            if dyy(j)>0 && dyy(j) < size(nxx,1) && dxx(j) >0 && dxx(j) < size(nyy,2)  
                 X(j)             = nxx(dyy(j),dxx(j));
                 Y(j)             = nyy(dyy(j),dxx(j));
                 fusion_z(j)      = zz(dyy(j),dxx(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
            end
    end
end
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % 最终形成4维矩阵，x、y、z、形变值
clearvars za yy ya Y xx xingbian  xa X pak pa pA nxx nyy  fusion_z  d_deleteUseless
close(h);
figure('Name','幅度离差三维分析图');set(gcf,'Color','w');                                     % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）
h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
colormap(flipud(hot));
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(15,20);
colorbar;caxis([0,0.25]);   
%% 数据游标
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) fun_NewCallback(obj,event_obj,h,zz,[],[],[],1);


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 此时的def为第二个阈值之后的形变
if ~isfield('handles','def2')
def  = handles.def2;
else
def  = handles.def;
end
corr = handles.corr;
DA   = handles.DA;
col  = handles.imagenum;
def(DA>str2double(get(handles.edit2,'String'))) = 1e-5;
imagesc(handles.axes2,handles.xaxis,handles.yaxis,def);colorbar(handles.axes2);
   axis(handles.axes2,'xy')  ;xlabel(handles.axes2,'方位向（Rad）');ylabel(handles.axes2,'距离向（m）');
   colormap(handles.axes2,'default') ;
   title(handles.axes2,'形变图');
%handles.def = def;
handles.def3 = def;
guidata(hObject,handles);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% def3形变值投射三维点云

data = handles.def3;          

%% -------------------------------第一步：点云数据读取--------------------------
h = waitbar(0,'三维计算中....');
%-----------------------选取点云数据------------------
if ~isfield('handles','pclfile') 
     % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取',handles.prjdir);
    end

fullnamepcl = strcat(PathName,FileName);
pclfile = fullnamepcl;
handles.pclfile = pclfile;
end
% 未选择即报错
if isempty(handles.pclfile)
    errordlg('先选择点云文件');
end

pclfile = handles.pclfile;
pcl  = pclfile;
d_deleteUseless   =  load (pcl);

xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
Na                = length(xa);                                           % 点云的点数
%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
%----------------------选取轨道文件---------------------
if ~isfield('handles','my_position')
[FileName,PathName] = uigetfile({'*.txt';'*.*'},'轨道文件选取',handles.prjdir);
fullnamerail=strcat(PathName,FileName);
my_position =fullnamerail;
handles.my_position = my_position;
else
    my_position =handles.my_position ;
end
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail            = load (railfile);
p1                = p_rail(1,:);                                  % 左端点
p2                = p_rail(2,:);                                  % 右端点
x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % 轨道外a点
[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                      % 点云寻找图像上二维坐标
%% 点云数据获得的二维坐标与DA图中的二维坐标匹配
%=========================================================================
%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz
%从handles中读取所需的坐标轴
% 方案1：从图像中获得xx
xx               = handles.xaxis;
xx               = -xx;                      % 上一语句读入会造成左右相反的情况，所以需要反转
yy               = handles.yaxis;
[nxx,nyy]        = meshgrid(xx,yy);
zz               = data;
%查看该组形变数据
figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('方位向（rad）');ylabel('距离向（m）');
%title(strrep(data,'_','\_'));
% 计算点云的方位角
p_view  = atan(pA(:,1)./pA(:,2));


%% ==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
%dxx(j)          = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
% 方案2 角度匹配如果p_view 超过了雷达最大角度即continue
    if p_view(j,1)>max(xx) || p_view(j,1)<min(xx)
        continue;
    else
            dxx(j)           = round((p_view(j,1)-xx(1))/(xx(2)-xx(1)))+1;
            if dyy(j)>0 && dyy(j) < size(nxx,1) && dxx(j) >0 && dxx(j) < size(nyy,2)  
                 X(j)             = nxx(dyy(j),dxx(j));
                 Y(j)             = nyy(dyy(j),dxx(j));
                 fusion_z(j)      = zz(dyy(j),dxx(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
            end
    end
end
DEM_Result       = [d_deleteUseless dyy dxx];
pA_3d_fusion     = [d_deleteUseless fusion_z];                                       % 最终形成4维矩阵，x、y、z、形变值
clearvars za yy ya Y xx xingbian  xa X pak pa pA nxx nyy  dyy dxx fusion_z  d_deleteUseless
close(h);
figure('Name','形变三维分析图');set(gcf,'Color','w');                                 % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）
h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
%colormap(flipud(hot));
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(15,20);
colorbar;%caxis([0,0.25]); 
xuhao = handles.xuhao;zzcell = handles.defcell;
%% 数据游标
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) fun_NewCallback(obj,event_obj,h,zz,zzcell,xuhao,DEM_Result,2);
n=1;


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% def形变值投射三维点云
data = handles.def;          
%% -------------------------------第一步：点云数据读取--------------------------
h = waitbar(0,'三维计算中....');
%-----------------------选取点云数据------------------
if ~isfield('handles','pclfile') 
     % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取',handles.prjdir);
    end

fullnamepcl = strcat(PathName,FileName);
pclfile = fullnamepcl;
handles.pclfile = pclfile;
end
% 未选择即报错
if isempty(handles.pclfile)
    errordlg('先选择点云文件');
end

pclfile = handles.pclfile;
pcl  = pclfile;
d_deleteUseless   =  load (pcl);

xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
Na                = length(xa);                                           % 点云的点数
%% 任意空间点pa到轨道的垂足pk之间距离dY，以及pk到轨道中点p0方位坐标dX
%----------------------选取轨道文件---------------------
if ~isfield('handles','my_position')
[FileName,PathName] = uigetfile({'*.txt';'*.*'},'轨道文件选取',handles.prjdir);
fullnamerail=strcat(PathName,FileName);
my_position =fullnamerail;
handles.my_position = my_position;
else
    my_position =handles.my_position ;
end
% 计算轨道两端点坐标，然后计算相位中心
railfile          = my_position;
p_rail            = load (railfile);
p1                = p_rail(1,:);                                  % 左端点
p2                = p_rail(2,:);                                  % 右端点
x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % 轨道外a点
[pak,pA]          = pcl2image(d_deleteUseless,p1,p2);                      % 点云寻找图像上二维坐标
%% 点云数据获得的二维坐标与def形变值中的二维坐标匹配
%=========================================================================
%这时的pA并不能与实际形变图中的二维坐标一一对应，所以需要寻找临近点方法将最邻近点的形变值赋给pA
%先获得实际形变数据的距离向yy坐标轴，方位向xx坐标轴，形变数据zz
%从handles中读取所需的坐标轴
% 方案1：从图像中获得xx
xx               = handles.xaxis;
xx               = -xx;                      % 上一语句读入会造成左右相反的情况，所以需要反转
yy               = handles.yaxis;
[nxx,nyy]        = meshgrid(xx,yy);
zz1               = data;
%查看该组形变数据
zz = mean_filter(zz1,get(handles.edit4,'String'));
figure;imagesc(-xx,yy,zz);colorbar;axis xy;xlabel('方位向（rad）');ylabel('距离向（m）');
title(strrep(data,'_','\_'));
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(3);
caxis([-cmean,cmean]); 
% 计算点云的方位角
p_view  = atan(pA(:,1)./pA(:,2));


%% ==========================================================================
[col_pA,row_pA]  = size(pA);
dxx              = zeros(col_pA,1);dyy = zeros(col_pA,1);
fusion_z         = zeros(col_pA,1);                                 % fusion_z为对应的形变值
X                = zeros(col_pA,1);
Y                = zeros(col_pA,1);
for j = 1:col_pA
dyy(j)           = round((pA(j,2)-yy(1))/(yy(2)-yy(1)))+1;          % 对应距离向y方向的下标
%dxx(j)          = round((pA(j,1)-xx(1))/(xx(2)-xx(1)))+1;          % 对应方位向x方向的下标
% 方案2 角度匹配如果p_view 超过了雷达最大角度即continue
    if p_view(j,1)>max(xx) || p_view(j,1)<min(xx)
        continue;
    else
            dxx(j)           = round((p_view(j,1)-xx(1))/(xx(2)-xx(1)))+1;
            if dyy(j)>0 && dyy(j) < size(nxx,1) && dxx(j) >0 && dxx(j) < size(nyy,2)  
                 X(j)             = nxx(dyy(j),dxx(j));
                 Y(j)             = nyy(dyy(j),dxx(j));
                 fusion_z(j)      = zz(dyy(j),dxx(j));                               % 在zz中找到dyy（j）和dxx（j）对应的形变值
            end
    end
end
pA_3d_fusion     = [d_deleteUseless fusion_z];                      % 最终形成4维矩阵，x、y、z、形变值
clearvars za yy ya Y xx xingbian  xa X pak pa pA nxx nyy  fusion_z  d_deleteUseless
close(h);
figure('Name','形变三维分析图');set(gcf,'Color','w');                                     % 图形界面背景以白色显示
%scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');%x,y,z,粗细，强度，形状（默认是圈）
h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,pA_3d_fusion(:,end),'filled');
%colormap(flipud(hot));
axis image;
xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
view(15,20);
colorbar;%caxis([0,0.25]);
caxis([-cmean,cmean]);    
%% 数据游标
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) fun_NewCallback(obj,event_obj,h,zz,[],[],[],1);



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
