function varargout = ShenzhenSSAR(varargin)
% 瞬态边坡雷达数据分析软件 MATLAB code for SSARLAB.fig
%     SSARLAB, by itself, creates a new XINJIANGZIJIN_GUI or raises the existing
%      singleton*.
%
%      H = SSARLAB returns the handle to a new XINJIANGZIJIN_GUI or the handle to
%      the existing singleton*.
%
%     SSARLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XINJIANGZIJIN_GUI.M with the given input arguments.
%
%     SSARLAB('Property','Value',...) creates a new XINJIANGZIJIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xinjiangzijin_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xinjiangzijin_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xinjiangzijin_gui

% Last Modified by GUIDE v2.5 25-Oct-2018 19:21:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xinjiangzijin_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @xinjiangzijin_gui_OutputFcn, ...
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


% --- Executes just before xinjiangzijin_gui is made visible.
function xinjiangzijin_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xinjiangzijin_gui (see VARARGIN)

% Choose default command line output for xinjiangzijin_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes xinjiangzijin_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xinjiangzijin_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





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

% --- Executes on button press in pushbutton22.%二维形变数据选取
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.%单帧形变图查看
function pushbutton1_Callback(hObject, eventdata, handles)
%%单帧形变图查看
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%difffile = get(handles.text11,'String');
%global diffpath
difffile = get(handles.edit7,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
peizhun(difffile,pclfile,my_position);
% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
%%单帧形变网格配准
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in pushbutton33.
difffile = get(handles.edit7,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
rangegrid = get(handles.edit11,'String');
fangweigrid = get(handles.edit12,'String');
peizhun_regrid(difffile,pclfile,my_position,rangegrid,fangweigrid);

% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = get(handles.edit7,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
rangegrid = get(handles.edit11,'String');
fangweigrid = get(handles.edit12,'String');
peizhun_deformation_temporalgrid(fullname,pclfile,my_position,rangegrid,fangweigrid);

function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filterfile = get(handles.edit8,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
peizhun_correlation(filterfile,pclfile,my_position);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = get(handles.edit7,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
peizhun_deformation_temporal(fullname,pclfile,my_position);

% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = get(handles.edit8,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
peizhun_correlation_temporal(fullname,pclfile,my_position);

% --- Executes on button press in pushbutton2.
function help_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('erweima.fig');set(gcf,'Toolbar','none');set(gcf,'Menubar','none');


% --- Executes on button press in pushbutton3.% 点云路径选取
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取');

fullname=strcat(PathName,FileName);
set(handles.text10,'String',fullname);
% --- Executes on button press in pushbutton38.%成像文件选取
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 选取文件，如果未设定文件存储路径即手动选取设置为存储路径
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.RadarImage';'*.*'},'成像文件选取','MultiSelect', 'on');
        handles.prjdir  = PathName;
%         if length(PathName)==1 
%             clearvars handles.prjdir FileName PathName
%             errordlg('请选取文件');
%         end
    else
        [FileName,PathName] = uigetfile({'*.RadarImage';'*.*'},'成像文件选取','MultiSelect', 'on',handles.prjdir);
        handles.prjdir  = PathName;
    end
%---------------------------如果未选取文件即报错    
if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
end    
fullname=strcat(PathName,FileName);
set(handles.edit9,'String',fullname);
handles.RadarImage = fullname;
guidata(hObject,handles);

% --- Executes on button press in pushbutton7.%形变文件选取支持多选
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取','MultiSelect', 'on');
        handles.prjdir  = PathName;

    else
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取','MultiSelect', 'on',handles.prjdir);
        handles.prjdir  = PathName;
        
    end
 % --------------------------------如果未选择文件即报错---------------------------   
    if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
    end

if length(FileName)~=29
timespan = [FileName(1,1),num2str(size(FileName,2)),FileName(1,end)];%计算首尾的形变文件的时间，然后算出时间跨度
%disp(FileName);

else
timespan = FileName(1,1:19);%计算首尾的形变文件的时间，然后算出时间跨度    
end
%global diffpath
fullname=strcat(PathName,FileName);
save FileName.mat fullname 
set(handles.edit7,'String',fullname);
set(handles.text13,'String',timespan);
handles.DiffImage = fullname;
guidata(hObject,handles);


% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = strrep(get(handles.edit7,'String'),'.DiffImage','.AfterFilter');
%fullname = fullname';
timespan = strrep(get(handles.text13,'String'),'.DiffImage','.AfterFilter');
set(handles.edit8,'String',fullname);
set(handles.text17,'String',timespan);

[c,r] = size(fullname);
if c>r;fullname = fullname';end
save FileName.mat fullname 
handles.AfterFilter = fullname;
guidata(hObject,handles);

% --- Executes on button press in pushbutton28.%相干文件选取
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.AfterFilter';'*.*'},'相干文件选取','MultiSelect', 'on');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.AfterFilter';'*.*'},'相干文件选取','MultiSelect', 'on',handles.prjdir);
end
 % --------------------------------如果未选择文件即报错---------------------------   
    if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
    end
% if(length(FileName))
%      set(hObject,'String','0')
% end
if length(FileName)~=31
timespan = [FileName(1,1),num2str(size(FileName,2)),FileName(1,end)];%计算首尾的相干文件的时间，然后算出时间跨度
%disp(FileName);

else
timespan = FileName(1,1:19);%计算首尾的相干文件的时间，然后算出时间跨度    
end
%global diffpath
fullname=strcat(PathName,FileName);
save FileName.mat fullname 
set(handles.edit8,'String',fullname);
set(handles.text17,'String',timespan);
handles.AfterFilter = fullname;
guidata(hObject,handles);

% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = strrep(get(handles.edit8,'String'),'.AfterFilter','.DiffImage');
%fullname = fullname';
timespan = strrep(get(handles.text17,'String'),'.AfterFilter','.DiffImage');
set(handles.edit7,'String',fullname);
set(handles.text13,'String',timespan);
[c,r] = size(fullname);
if c>r;fullname = fullname';end
save FileName.mat fullname 
handles.DiffImage = fullname;
guidata(hObject,handles);
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.txt';'*.*'},'轨道文件选取');
fullname=strcat(PathName,FileName);
set(handles.text12,'String',fullname);

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)%单帧形变图查看
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% -----------------------先选取形变文件-------------------------------
if ~isfield(handles,'DiffImage')
 % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取','MultiSelect', 'on');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取','MultiSelect', 'on',handles.prjdir);
    end
if length(FileName)~=29
timespan = [FileName(1,1),num2str(size(FileName,2)),FileName(1,end)];%计算首尾的形变文件的时间，然后算出时间跨度
%disp(FileName);

else
timespan = FileName(1,1:19);%计算首尾的形变文件的时间，然后算出时间跨度    
end
%global diffpath
fullname=strcat(PathName,FileName);
save FileName.mat fullname 
set(handles.edit7,'String',fullname);
set(handles.text13,'String',timespan);
handles.DiffImage = fullname;
end
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
difffile = handles.DiffImage;
a = strfind(difffile,'.');b = strfind(difffile,'\');
xuhao = difffile(max(b)+1:max(a)-1);
fun_show_xingbian(difffile,3);

% 读取形变图像中的数据
xingbian = findobj(gcf,'type','image');   
xx = get(xingbian,'xdata');
yy = get(xingbian,'ydata');
def = get(xingbian,'cdata');
[m,n] = size(def);
sizedef = [m n min(xx) max(xx) min(yy) max(yy)];
save sizedef.mat sizedef;
handles.def = def;
close(figure(gcf));
guidata(hObject,handles);
% 这里xx加负号是因为由fun_show_xingbian函数获取到的x坐标是左右相反的
figure;imagesc(-xx,yy,def);colorbar;axis xy;title(strrep(xuhao,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');set(gcf,'color','w');

%--------------------------图像保存------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_adjustfig([],xuhao,5)); % 使用句柄调用回调函数
%--------------------------均值滤波------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'MeanFilter',...
        'Position', [330 5 90 20],'Backgroundcolor','w');
%滤波窗口大小
text1 = uicontrol('Style','edit','String','3','Position',[430 5 20 20]);   % 区间终点

figuredata  = {xx,yy,def};
set(btn,'Callback', @(x,y)fun_adjustfig(figuredata,text1,6)); % 使用句柄调用回调函数
%--------------------------SurfPlot------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SurfPlot',...
        'Position', [455 5 90 20],'Backgroundcolor','w');

%figuredata  = {xx,yy,def};
set(btn,'Callback', @(x,y)fun_adjustfig(figuredata,[],7)); % 使用句柄调用回调函数


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'AfterFilter')

 % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.AfterFilter';'*.*'},'相干文件选取','MultiSelect', 'on');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.AfterFilter';'*.*'},'相干文件选取','MultiSelect', 'on',handles.prjdir);
    end
% if(length(FileName))
%      set(hObject,'String','0')
% end
if length(FileName)~=31
timespan = [FileName(1,1),num2str(size(FileName,2)),FileName(1,end)];%计算首尾的相干文件的时间，然后算出时间跨度
%disp(FileName);

else
timespan = FileName(1,1:19);%计算首尾的相干文件的时间，然后算出时间跨度    
end
%global diffpath
fullname=strcat(PathName,FileName);
save FileName.mat fullname 
set(handles.edit8,'String',fullname);
set(handles.text17,'String',timespan);
handles.AfterFilter = fullname;
end
if isempty(handles.AfterFilter)
    errordlg('先选择相干文件');
end
aa = handles.AfterFilter;
difffile = strrep(aa,'.AfterFilter','.DiffImage');
% 如果存在difffile，即先显示相干fun_show_xingbian，如果不存在就使用fun_show
if exist(difffile,'file')
fun_show_xingbian(difffile,3);

   
%读取形变图像中的数据
xingbian = findobj(gcf,'type','image');   
xx = get(xingbian,'xdata');
yy = get(xingbian,'ydata');
close(figure(gcf));
%figure;imagesc(-xx,yy,def);colorbar;axis xy;title(strrep(xuhao,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');
filterfile = handles.AfterFilter;
a = strfind(filterfile,'.');b = strfind(filterfile,'\');
xuhao = filterfile(max(b)+1:max(a)-1);
 
  fun_show(filterfile,2)
%读取相干图像中的数据
xianggan = findobj(gcf,'type','image');  
zz = get(xianggan,'cdata');
close(figure(gcf));
figure;imagesc(-xx,yy,zz);colorbar;axis xy;colormap hot;title(strrep(xuhao,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');
else
filterfile = handles.AfterFilter;
a = strfind(filterfile,'.');b = strfind(filterfile,'\');
xuhao = filterfile(max(b)+1:max(a)-1);
 
  fun_show(filterfile,2);title(strrep(xuhao,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');
end
  % --- Executes on button press in pushbutton27.二维累积形变
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ---------------------------------先选取形变文件------------------------------
if ~isfield(handles,'DiffImage')
 % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取','MultiSelect', 'on');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取','MultiSelect', 'on',handles.prjdir);
    end
if length(FileName)~=29
timespan = [FileName(1,1),num2str(size(FileName,2)),FileName(1,end)];%计算首尾的形变文件的时间，然后算出时间跨度
%disp(FileName);

else
timespan = FileName(1,1:19);%计算首尾的形变文件的时间，然后算出时间跨度    
end
%global diffpath
fullname=strcat(PathName,FileName);
save FileName.mat fullname 
set(handles.edit7,'String',fullname);
set(handles.text13,'String',timespan);
handles.DiffImage = fullname;
end

if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
fullname = handles.DiffImage;
% for i = 1:length(fullname)
%     fullname(i,:) = fullname{i};
% end
[zz,zzcell,xuhao]=deformation_cumulate2(fullname');
[m,n1] = size(zz);
sizedef=[m n1];save sizedef.mat sizedef;

handles.def = zz;
handles.def_cumulate = zzcell;
handles.def_xuhao    = xuhao;
guidata(hObject,handles);


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'AfterFilter')
if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.AfterFilter';'*.*'},'相干文件选取','MultiSelect', 'on');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.AfterFilter';'*.*'},'相干文件选取','MultiSelect', 'on',handles.prjdir);
    end
% if(length(FileName))
%      set(hObject,'String','0')
% end
if length(FileName)~=31
timespan = [FileName(1,1),num2str(size(FileName,2)),FileName(1,end)];%计算首尾的相干文件的时间，然后算出时间跨度
%disp(FileName);

else
timespan = FileName(1,1:19);%计算首尾的相干文件的时间，然后算出时间跨度    
end
%global diffpath
fullname=strcat(PathName,FileName);
save FileName.mat fullname 
set(handles.edit8,'String',fullname);
set(handles.text17,'String',timespan);
handles.AfterFilter = fullname;
end
if isempty(handles.AfterFilter)
    errordlg('先选择相干文件');
end
fullname = handles.AfterFilter;

cumulate_correlation2(fullname');

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%用来清理残余变量
global yycursor
global yycursor1
clearvars -global yycursor yycursor1;
%clear all;
helpdlg('清理完成','清理数据');


% --- Executes on button press in pushbutton14.%文件路径
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

winopen('E:\SSARLAB\');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%a = fullname;
%set(handles.edit1,'String',a);


%计算器数据1
function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
input = str2num(get(hObject,'String'));
if(isempty(input))
    set(hObject,'String','0')
end
guidata(hObject,handles);

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


%文本2
function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
input = str2num(get(hObject,'String'));
if(isempty(input))
    set(hObject,'String','0')
end
guidata(hObject,handles);

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


% --- Executes on button press in pushbutton6.%加法计算按钮
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.edit3,'String');
b = get(handles.edit4,'String');
total = str2num(a)+str2num(b);
c = num2str(total);
set(handles.edit6,'String',c);
set(handles.text6,'String','+');
guidata(hObject,handles);

% --- Executes on button press in pushbutton10.减法计算按钮
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.edit3,'String');
b = get(handles.edit4,'String');
total = str2num(a)-str2num(b);
c = num2str(total);
set(handles.edit6,'String',c);
set(handles.text6,'String','-');
guidata(hObject,handles);

% --- Executes on button press in pushbutton11.乘法
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.edit3,'String');
b = get(handles.edit4,'String');
total = str2num(a)*str2num(b);
c = num2str(total);
set(handles.edit6,'String',c);
set(handles.text6,'String','×');
guidata(hObject,handles);

% --- Executes on button press in pushbutton12.除法
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.edit3,'String');
b = get(handles.edit4,'String');
total = str2num(a)/str2num(b);
c = num2str(total);
set(handles.edit6,'String',c);
set(handles.text6,'String','÷');
guidata(hObject,handles);
% --- Executes on button press in pushbutton15.%乘方
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes during object creation, after setting all properties.
a = get(handles.edit3,'String');
b = get(handles.edit4,'String');
total = str2num(a)^str2num(b);
c = num2str(total);
set(handles.edit6,'String',c);
set(handles.text6,'String','^');
guidata(hObject,handles);

% --- Executes on button press in pushbutton17.%清除clear按钮
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit3,'String','数值1');
set(handles.edit4,'String','数值2');
set(handles.edit6,'String','结果');

function text9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called






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


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)










% --- Executes during object creation, after setting all properties.
function text13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'DiffImage')
[FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取');
fullname=strcat(PathName,FileName);
handles.DiffImage = fullname;
end
if class(handles.DiffImage) =='cell'
    file = handles.DiffImage{1};
else
    file = handles.DiffImage;
end

if ~exist('测试','dir')
    mkdir('测试','input');
    mkdir('测试','output');
end

path = [pwd,'\测试\input\'];
copyfile(file,path)
a = strfind(file,'.');b = strfind(file,'\');
xuhao = file(max(b)+1:max(a)-1);
fun_test_reverse([xuhao,'.DiffImage']);
guidata(hObject,handles);

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'DiffImage')
[FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取');
fullname=strcat(PathName,FileName);
handles.DiffImage = fullname;
end
if class(handles.DiffImage)=='cell'
    file = handles.DiffImage{1};
else
    file = handles.DiffImage;
end
if ~exist('测试','dir')
    mkdir('测试','input');
    mkdir('测试','output');
end
path = [pwd,'\测试\input\'];
copyfile(file,path)
a = strfind(file,'.');b = strfind(file,'\');
xuhao = file(max(b)+1:max(a)-1);
fun_test([xuhao,'.DiffImage']);
guidata(hObject,handles);


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen([pwd,'\测试\output\']);

function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'RadarImage')
    % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.RadarImage';'*.*'},'成像文件选取');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.RadarImage';'*.*'},'成像文件选取',handles.prjdir);
    end
    fullname=strcat(PathName,FileName);
   
end
if isempty(handles.RadarImage)
    errordlg('先选择成像文件');
end
%-------------------------------获取文件对应的时刻---------------------
    fullname =  handles.RadarImage;
    
    a = strfind( fullname,'.');b = strfind( fullname,'\');
    xuhao = fullname(max(b)+1:max(a)-1);
    set(handles.edit9,'String',fullname);
%----------------------------------------------------------------------    
a = handles.RadarImage;                          % 成像文件路径传参
b = get(handles.edit10,'String');
fun_show(a,1,str2num(b));
set(gca,'FontName','Helvetica','position',[0.05,0.158,0.8,0.76] );set(gcf,'color','w');
%--------------------------图像保存------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_adjustfig([],[],5)); % 使用句柄调用回调函数
%--------------------------图像数据导出------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'DataOutput',...
        'Position', [130 5 120 20],'Backgroundcolor','w');%
set(btn,'Callback', @(x,y)fun_adjustfig(fullname,xuhao,10)); % 使用句柄调用回调函数
%--------------------------导出数据查看------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'ResultFolder',...
        'Position', [255 5 90 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_adjustfig([],[],11)); % 使用句柄调用回调函数
guidata(hObject,handles);



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double
input = str2num(get(hObject,'String'));
if(isempty(input))
    set(hObject,'String','0.8')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setHvisible(handles,1,41)

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setHvisible(handles,2,[1,3])

function setHvisible(handles,Iyes,Ino)
%% 设置对象的的visible属性
% 将Iyes序号对应的uipanel设置为显示 对应的pushbutton的enable设置成off
% 将Ino序号对应的uipanel设置为隐藏 对应的pushbutton的enable设置成on
for i=1:length(Iyes)
    eval( ['set(handles.uipanel',num2str(Iyes(i)),',','''visible'',''on'')'])   %设置为显示
    eval( ['set(handles.pushbutton',num2str(Iyes(i)),',','''enable'',''off'')'])%按钮变灰
end
for i=1:length(Ino)
    eval( ['set(handles.uipanel',num2str(Ino(i)),',','''visible'',''off'')'])   %设置为隐藏
    eval( ['set(handles.pushbutton',num2str(Ino(i)),',','''enable'',''on'')'])  %激活按钮
end


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uipanel11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%h = helpdlg('待加入...ver0.22','正在开发中');
%close(h);
%-----------------------选取点云数据------------------
if ~exist('DEM_Result.mat','file')
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
    pclfile = handles.pclfile;


%----------------------选取轨道文件---------------------
if ~isfield('handles','my_position')
[FileName,PathName] = uigetfile({'*.txt';'*.*'},'轨道文件选取',handles.prjdir);
fullnamerail=strcat(PathName,FileName);
my_position =fullnamerail;
handles.my_position = my_position;
else
    my_position =handles.my_position ;
end
%----------------------先生成DEM_Result-----------------
[FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'累积形变文件选取','MultiSelect', 'on',handles.prjdir);
fullname=strcat(PathName,FileName);
%[FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取',handles.prjdir);
%fullnamerail=strcat(PathName,FileName);
difffile =fullname{1};
fun_save3DEM(difffile,pclfile,my_position);
end
%----------------------选取配准形变文件---------------------
if ~isfield('handles','prjdir')
    [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'累积形变文件选取','MultiSelect', 'on');
    handles.prjdir  = PathName;
else
    [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'累积形变文件选取','MultiSelect', 'on',handles.prjdir);
end

fullname=strcat(PathName,FileName);

handles.DiffImage = fullname;
handles.prjdir  = PathName;
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
fps = get(handles.edit15,'String');
yuzhi = get(handles.edit16,'String');
view1 = get(handles.edit22,'String');view2 = get(handles.edit23,'String');
view = [str2double(view1) str2double(view2)];
fullname = handles.DiffImage;
deformation_cumulate3movie(fps,yuzhi,fullname',view);

guidata(hObject,handles);


% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
%% 二维形变动画
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'DiffImage')
errordlg('先选择形变文件');
end
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
fps = get(handles.edit15,'String');
fullname = handles.DiffImage;
deformation_2movie(fps,fullname');
guidata(hObject,handles);


% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'DiffImage')
errordlg('先选择形变文件');
end
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
fps = get(handles.edit15,'String');
yuzhi = get(handles.edit16,'String');
fullname = handles.DiffImage;
deformation_cumulate2movie(fps,yuzhi,fullname');
guidata(hObject,handles);

function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
difffile = get(handles.edit7,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
peizhun_reverse(difffile,pclfile,my_position);

% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = get(handles.edit7,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
peizhun_deformation_temporalreverse(fullname,pclfile,my_position);


% --- Executes during object creation, after setting all properties.
function text17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
%% 坡角、高程、朝向
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = get(handles.text10,'String');
azimuth  = get(handles.edit12,'String');
range    = get(handles.edit11,'String');
fun_savenormal(fullname,azimuth,range);


% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fullname = get(handles.edit7,'String');
pclfile = get(handles.text10,'String');
my_position = get(handles.text12,'String');
fun_save3DEM(fullname,pclfile,my_position)


% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_saveBPslope();


% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_saveweather();


% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('data.xlsx');


% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%h=gcf;
updatalog;
%close(h);

% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_save3DEM2XYZ()


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%open('erweima.fig');set(gcf,'Toolbar','none');set(gcf,'Menubar','none');
winopen('软件说明1.pdf');
% --- Executes during object creation, after setting all properties.
function uipanel3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.jpg';'*.*'},'图像文件选取');

fullname             = strcat(PathName,FileName);
temp                 = imread(fullname);
[m,n]                = size(temp);
imsize=['  ',num2str(m),'*',num2str(n)];
handles.viewfullname = fullname;
handles.viewsize     = imsize;
handles.viewdispname = strrep(FileName,'_','\_');
guidata(hObject,handles);
figure;imshow(temp);title([handles.viewdispname,'大小',handles.viewsize]);


% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('D:\bxsy\tomcat\webapps\minesafe\exedo\webv3\dangqian');


% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h1 = helpdlg('先选择形变数据或累计形变数据及光学图像','注意！');
if ~isfield(handles,'DiffImage')
 % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取',handles.prjdir);
    end
if length(FileName)~=29
timespan = [FileName(1,1),num2str(size(FileName,2)),FileName(1,end)];%计算首尾的形变文件的时间，然后算出时间跨度
%disp(FileName);

else
timespan = FileName(1,1:19);%计算首尾的形变文件的时间，然后算出时间跨度    
end
%global diffpath
fullname=strcat(PathName,FileName);
save FileName.mat fullname 
set(handles.edit7,'String',fullname);
set(handles.text13,'String',timespan);
handles.DiffImage = fullname;
end
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
difffile = handles.DiffImage;
a = strfind(difffile,'.');b = strfind(difffile,'\');
xuhao = difffile(max(b)+1:max(a)-1);
fun_show_xingbian(difffile,3);

%读取形变图像中的数据
xingbian = findobj(gcf,'type','image');   
xx = get(xingbian,'xdata');
yy = get(xingbian,'ydata');
def = get(xingbian,'cdata');
[m,n] = size(def);
sizedef = [m n min(xx) max(xx) min(yy) max(yy)];
save sizedef.mat sizedef;
handles.def = def;
close(figure(gcf));
input   = handles.def;
if exist('input','var')
 close(h1);
end
if ~isfield('handles','viewfullname')
    errordlg('先单击雷达同视角图像');
end
base2   = imread(handles.viewfullname);

base   = rgb2gray(base2);
base   = im2double(base);
[c,r]  = size(base);x= 1:r;y = 1:c;
input  = imresize(input,[r,c],'bicubic');
[input_points,base_points] = cpselect(input,base,'Wait',true);%此处需等待操作者选点，为人机交互过程


%按affine进行图像配准 至少3对点
%mytform2 = cp2tform(input_points,base_points,'affine');
mytform2 = fitgeotrans(input_points,base_points,'affine');
Improcess2 = imwarp(input,mytform2,'OutputView',imref2d(size(base)));
falsecolorOverlay = imfuse(base,Improcess2);


figure
imshow(falsecolorOverlay,'InitialMagnification','fit');
[y,x] = find(input <input(15,15)-0.1 & input >-input(15,15)+0.1);                            %y为行号，对应纵坐标x为列号对应横坐标
input(input >input(15,15)-0.001 | input <-input(15,15)+0.001) = 0;
[x1,y1] = transformPointsForward(mytform2,x,y);
x1 = round(x1);y1 = round(y1); x1(x1<0 | x1 ==0) = 1;y1(y1<0 | y1 ==0) = 1;
x1(x1>r) = max(r); y1(y1>c) = max(c);
%label  = [x1 y1 x y];
base1 = base;
for i = 1:length(x1)
base1(y1(i),x1(i)) = base(y1(i),x1(i)) + input(y(i),x(i));
end
cmap = colormap(jet(256));
base1_rgb = im2uint8(base1);
base1_rgb = ind2rgb(base1_rgb,cmap);
base1_rgb = im2uint8(base1_rgb);
K = imlincomb(1,base2,0.3,base1_rgb);

figure;
imshow(K);
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) deformationCallback(obj,event_obj,input);
btn = uicontrol('Style', 'pushbutton', 'String', '保存配准数据',...
        'Position', [5 5 120 20]);
set(btn,'Callback', @(x,y)fun_savephotomatch(input_points,base_points)); % 使用句柄调用回调函数

% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=helpdlg('先进行手动粗配准','注意！');
load('input_points.mat');load('base_points.mat');
if exist('input_points','var')
close(h);
end
xishu = get(handles.edit17,'String');
input   = handles.def;
base2   = imread(handles.viewfullname);
base   = rgb2gray(base2);
base   = im2double(base);
[c,r]  = size(base);x= 1:r;y = 1:c;
input = imresize(input,[r,c],'bicubic');
%[input_points,base_points] = cpselect(input,base,'Wait',true);%此处需等待操作者选点，为人机交互过程
%按affine进行图像配准 至少3对点
%mytform2 = cp2tform(input_points,base_points,'affine');
mytform2 = fitgeotrans(input_points,base_points,'affine');
Improcess2 = imwarp(input,mytform2,'OutputView',imref2d(size(base)));

[y,x] = find(abs(input)>1e-4);              %y为行号，对应纵坐标x为列号对应横坐标
if input(15,15)>4 || input(15,15)<-4
[y,x] = find(abs(input)-0.00000001 & input >-abs(input(15,15))+0.00000001); 
input(input >abs(input(15,15))-0.00000001 | input <-abs(input(15,15))+0.00000001) = 0;
end
[x1,y1] = transformPointsForward(mytform2,x,y);
x1 = round(x1);y1 = round(y1); x1(x1<0 | x1 ==0) = 1;y1(y1<0 | y1 ==0) = 1;
x1(x1>r) = max(r); y1(y1>c) = max(c);
%label  = [x1 y1 x y];
base1 = base;
for i = 1:length(x1)
base1(y1(i),x1(i)) = base(y1(i),x1(i)) + input(y(i),x(i));
end
cmap = colormap(jet(256));
base1_rgb = im2uint8(base1);
base1_rgb = ind2rgb(base1_rgb,cmap);
base1_rgb = im2uint8(base1_rgb);
K = imlincomb(1,base2,str2double(xishu),base1_rgb);
figure;
imshow(K);
hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) deformationCallback(obj,event_obj,input);


% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'点折线图文件选取');
jingdu               = str2double(get(handles.edit18,'String'));
%jiaodu               = str2double(get(handles.edit20,'String'));
filename             = strcat(PathName,FileName);
handles.dian_file    = filename;
h = waitbar(0,'计算中....');
%% ---------------------第一步：导入形变.csv数据-------------------------
data_dian = csvread(filename,1,1);                      %import点数据文件到data中
%data_dian = data_dian;
[column,row] = size(data_dian);                         %计算data中数据的行数
%% 获取时间列
delimiter = ',';
startRow = 2;



table  = readtable(filename);
data_date = table.DATE;
data_date = datetime(data_date);

%列1: 日期时间 (%{yyyy-MM-dd HH:mm}D)
%formatSpec = '%{yyyy-MM-dd HH:mm}D%f%f%f%f%f%f%f%[^\n\r]';
formatSpec = '%f%f%f%f%f%f%f';
fileID = fopen(filename,'r');
%%根据格式读取数据列
title = textscan(fileID,repmat('%s',1,31),1,'delimiter',',');
%dataarray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
%%关闭文本文件。
fclose(fileID);
%将导入的数组分配给列变量名称
%data_date = dataarray{:, 1};
% 对于要求日期序列(datenum)而不是日期时间的代码，请取消注释以下行，以便以 datenum 形式返回导入的日期。
%data_date_num =datenum(data_date);
%清除临时变量
clearvars filename delimiter table dataarray startRow formatSpec fileID ans;
%% ---------------------第二步：每个点位整体时间段内的极大值、极小值、平均值-----------------------------
waitbar(1/5,h);
%% 整体分析
%获取每一列数据的最大值及对应的时间
[data_max_row,max_date] = max(data_dian);
%获取每一列数据的最小值及对应的时间
[data_min_row,min_date] = min(data_dian);
% 求取极值，正向位移最大值或负向位移最大值
[data_max,ind]  = max([abs(data_max_row);abs(data_min_row)],[],1);
data_max(ind == 1) = data_max(ind == 1);
data_max(ind == 2) = -data_max(ind == 2);
dateformat = 'yyyy/mm/dd HH:MM';
ii =1;
for i = 1:length(ind)
    if ind(i) ==1
        data_maxdate{ii,1} = datestr(data_date(max_date(ii)),dateformat);
        ii = ii+1;
    elseif ind(i )==2
        data_maxdate{ii,1} = datestr(data_date(min_date(ii)),dateformat);
        ii = ii+1;
    end
%data_maxdate(ind == 1,1) = datestr(data_date(max_date(ind == 1)),dateformat);
%data_maxdate(ind == 2,1) = datestr(data_date(min_date(ind == 2)),dateformat);
    
end
%获取每一列数据的平均值
data_mean_row = mean(data_dian);


%disp(['自',datestr(data_date(1),dateformat),'到',datestr(data_date(column),dateformat),'止：']);
timespan = {['自',datestr(data_date(1),dateformat),'到',datestr(data_date(column),dateformat),'止：']};


% chart_total = cell(1,7);
% for i = 1:row
%     chart_total{1,1}(i,1) = 'P';
%     chart_total{1,2}(i,1) = i;
% end
% for i = 1:row
%     chart_total(i,1) = i;%整体分析表第一列为点号   
% end
%% ---------------------第三步：每个点位按天分析极大值、极小值、平均值-----------------------------
waitbar(2/5,h);
%% 每天分析最大值以及最小值
%分析整个文档中数据分别属于哪一天
t = datevec(data_date);%将datetime形式转换成向量保存
%获取监测天数date_duration
date_duration = datevec(datetime(data_date(column)) - datetime(data_date(1)));
date_duration = date_duration(1,3)+1;
%分天获取数据中分界点存在date_change_column中
ii = 1;
date_change_column = zeros(1,date_duration-1);
for i = 1:column-1
    if t(i,3) == t(i+1,3)
        continue;
    else
        date_change_column(ii) = i+1;
        ii = ii+1;
    end
end
date_change_column = [1 date_change_column column+1];
waitbar(3/5,h);
%% 将累积位移转换成每日位移
%每天的累积形变为该天自分界点的数据减去前一天最后一组总累积位移数据
% i = 1; data_dian_day(date_change_column(1):date_change_column(2)-1,:) = data_dian(date_change_column(1):date_change_column(2)-1,:);
% i = 2; data_dian_day(date_change_column(2):date_change_column(3)-1,:) = data_dian(date_change_column(2):date_change_column(3)-1,:) - data_dian(date_change_column(2)-1);
% i = 3; data_dian_day(date_change_column(3):date_change_column(4)-1,:) = data_dian(date_change_column(3):date_change_column(4)-1,:) - data_dian(date_change_column(3)-1);
data_dian_day = zeros(column,row);
for i = 1:length(date_change_column)-1
    if i == 1
        data_dian_day(date_change_column(1):date_change_column(2)-1,:)...
            = data_dian(date_change_column(1):date_change_column(2)-1,:);
    else
        data_dian_day(date_change_column(i):date_change_column(i+1)-1,:)...
            = data_dian(date_change_column(i):date_change_column(i+1)-1,:) - data_dian(date_change_column(i)-1);
    end
end
%% 获取每一天中的最大值以及最小值及其对应时刻
data_daymax = zeros(date_duration,row);data_daymin = zeros(date_duration,row);
max_daytime = zeros(date_duration,row);min_daytime = zeros(date_duration,row);
data_daymean = zeros(date_duration,row);data_daymeanmax = zeros(date_duration,1);
for i = 1:length(date_change_column)-1
    disp(['自',datestr(data_date(date_change_column(1,i)),dateformat),'到',datestr(data_date(date_change_column(1,i+1)-1),dateformat),'止：']);
    disp(['当日扫描',num2str(date_change_column(1,i+1)-date_change_column(1,i)),'轨数据']);
    disp(['累积扫描',num2str(date_change_column(1,i+1)-1),'轨数据']);
    %------------------获取每一列数据的最大值及对应的时间----------------
    [data_daymax(i,:),max_daytime(i,:)] = max(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%获取每个时间变化区间内的最大值以及对应的行号
    [data_daymin(i,:),min_daytime(i,:)] = min(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%获取每个时间变化区间内的最小值以及对应的行号 
    data_daymean(i,:) = mean(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%获取日平均值
    %获取每一天每个点的位移,每日最后一个点位移减去前一个点位移
    data_daydef(i,:)  = data_dian_day(date_change_column(1,i+1)-1,:)-data_dian_day(date_change_column(1,i),:);
    %获取每一天每个点的累积位移,每日最后一个点累积位移
    data_daycum(i,:)  = data_dian(date_change_column(1,i+1)-1,:);
   %获取每一天内取得最大值的点
  %  data_daymeanmax(i,1) = max(data_daymean(i,1:4));%获取区域1，前4个点中的每一天平均值最大值
    
end
waitbar(4/5,h);
%% 自动生成xlsx报告
%将时间跨度、写入xlsx文件
%------------------ 报告清空--------------------
x = ' ';
Filename1 = strrep(FileName,'.csv','.xlsx'); 

[status,message]=xlswrite(Filename1,x,1,'A1');
if ~isempty(message.message)
msgbox(message.message,'提示信息');
end
delete(Filename1);
%------------------ 时间跨度、点号写入表头--------------------
%sheethead1 = {{'点号'} {'最大值'} {'发生时间'} {'累积值'}};
sheethead1 = {('点号') ('最大值') ('发生时间') ('累积值') };
for i = 1:size(data_dian,2)
sheetpointNO{i,1} = ['P',num2str(i)];
end
xlswrite(Filename1,timespan,1,'A1');
xlswrite(Filename1,sheethead1,1,'A2:D2');
% for i = 1:length(sheethead1)
% xlswrite(Filename1,sheethead1(i),1,[char(i+96),num2str(2)]);%i+96表示由数字转字母
% end
xlswrite(Filename1,sheetpointNO,1,'A3');% 写入点号
%data_max = round(data_max,jingdu  );
xlswrite(Filename1,round(data_max',jingdu),1,'B3'); %写入最大值（正向或负向位移最大值）
xlswrite(Filename1,data_maxdate,1,'C3');% 写入发生时间
xlswrite(Filename1,round(data_dian(end,:)',jingdu  ),1,'D3') %写入累积值

%----------------------表2单日点位移分析----------------------
%目前应该写入的行号
current_col = 4+size(data_dian,2);
%dateformat2 =  'yyyy/mm/dd';
%获取表2日期
sheethead2{1,1} = '测量日期';
for i = 1:length(date_change_column)-1

sheethead2{1,i+1}=datestr(data_date(date_change_column(i)),dateformat);
sheethead2{1,i+1}=sheethead2{1,i+1}(6:10);
sheethead2{1,i+1}=[strrep(sheethead2{1,i+1},'/','月'),'日'];
end
%sheethead2 = {'测量日期' sheethead2 };
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % 写入点号

xlswrite(Filename1,round(data_daydef',jingdu),1,['B',num2str(current_col)]);   % 写入数据
current_col =current_col+size(data_dian,2);
[d_max ,ind_max]=max(max(round(data_daydef',jingdu)));
[d_min, ind_min]=min(min(round(data_daydef',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col)]);
xlswrite(Filename1,round(mean(data_daydef(:)),jingdu),1,['E',num2str(current_col)]);
%----------------------表3累积点位移分析----------------------
current_col =current_col+1;
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % 写入点号
xlswrite(Filename1,round(data_daycum',jingdu),1,['B',num2str(current_col)]);     % 写入累积形变值
current_col =current_col+size(data_dian,2);
xlswrite(Filename1,{'平均值'},1,['A',num2str(current_col)]);                      % 写入平均值表头
xlswrite(Filename1,round(mean(data_daycum,2)',jingdu),1,['B',num2str(current_col)]); % 写入平均值
[d_max ,ind_max]=max(max(round(data_daycum',jingdu)));
[d_min, ind_min]=min(min(round(data_daycum',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col+1)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col+1)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col+1)]);
xlswrite(Filename1,round(mean(data_daycum(:)),jingdu),1,['E',num2str(current_col+1)]);
current_col =current_col+1;
xlswrite(Filename1,{['累积处理',num2str(date_change_column(end)-1),'帧形变图像']},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,{['连续监测',num2str(round((date_change_column(end)-1)*0.25)),'小时']},1,['A',num2str(current_col+2)]);  
waitbar(5/5,h);
close(h);
%----------------------handles 整理---------------------------------
handles.dian_processed = Filename1;
handles.allpoints      = data_dian;

handles.alldatetime    = data_date;
handles.currentcol     = current_col;
handles.sheetNO = sheetpointNO;
guidata(hObject,handles);%n =1;
helpdlg('处理完成','处理完成');


function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double
input = str2num(get(hObject,'String'));
if(isempty(input))
    set(hObject,'String','0.3')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'dian_processed')
errordlg('先运行选点结果分析');
end
%n  = 1;

%if 
winopen(handles.dian_processed);


% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'位移图文件选取');
if exist('sizedef.mat','file')==0 
errordlg('先任意选择单帧形变数据并查看');
end
load('sizedef.mat');
filename             = strcat(PathName,FileName);
handles.contour_file    = filename;
data           = csvread(filename,2,0);                % import数据文件到data中
%[column,row]  = size(data);                           % 计算data中数据的行数
data(data == -1000) = 0;                               % 异常值置零
data           = [data(:,1) data(:,2) data(:,4)];      % 将三列数据合成一个
x              = data(:,1);
y              = data(:,2);
z              = data(:,3);
%% ---------------------第二步：建立x，y网格--------------------------
%x升序排列
%data_sort = sortrows(data,1);
% data_sort = sortrows(data,2);
% data_sortx = sort(data(:,1));
% data_sorty = sort(data(:,2));
nx             = linspace(min(x),max(x),sizedef(1));         % 距离向网格数量1000
ny             = linspace(min(y),max(y),sizedef(2));          % 方位向网格数量200
[xx,yy]        = meshgrid(nx,ny);                      % 生成网格
zz             = griddata(x,y,z,xx,yy);
%% 等高线图
%figure;contour(ny,nx,zz',8);axis([-300 250 500 780]);
figure; set(gcf,'Color','w');contourf(ny,nx,zz',18);axis(sizedef(3:6));
colorbar;caxis([-40 20]);grid on;
%获得文件名并作为图像的标题
a = strfind(filename,'.');b = strfind(filename,'\');
xuhao = filename(max(b)+1:a-1);
xuhao = strrep(xuhao,'_','\_');xuhao = strrep(xuhao,'-','\_');
title(xuhao);
%title([strrep(xuhao,'_','\_'),'\_',num2str(length(nx)),'*',num2str(length(ny))]);
xlabel('方位向（m）');ylabel('距离向（m）'); 
%btn = uicontrol('Style', 'pushbutton', 'String', '保存图像',...
        %'Position', [5 5 120 20],'Callback',saveas(gcf,'myfig.jpg'));
%set(btn,'Callback', @(x,y)fun_savecontourfig()); % 使用句柄调用回调函数

% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 %helpdlg('正在开发...','功能正在开发');
prjdir = uigetdir('D:\');
handles.prjdir = prjdir;
guidata(hObject,handles);

% --- Executes on button press in pushbutton68.
function pushbutton68_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'allpoints')
errordlg('先运行选点结果分析或投影结果分析');
end
data  = handles.allpoints;
t = handles.alldatetime;
figure; set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w')
plot(t,data); set(gca,'XTickLabelRotation',45);%set(gca,'xtick',(t(1):1:t(end)));
set(gca,'FontWeight','bold');set(gca,'FontSize',15);
ylabel('Deformation/mm');
legend(handles.sheetNO);
%--------------------------图像保存------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_adjustfig([],[],4)); % 使用句柄调用回调函数
%横轴调整参数
text1 = uicontrol('Style','edit','String','0.25','Position',[170 5 20 20]);   % 区间终点
btn2 = uicontrol('Style', 'pushbutton', 'String', 'Xaxis',...
        'Position', [125 5 40 20],'Backgroundcolor','w');
set(btn2,'Callback', @(x,y)fun_adjustfig(t,text1,1)); % 使用句柄调用回调函数
%纵轴调整参数
text2 = uicontrol('Style','edit','String','1.2','Position',[235 5 20 20]);   % 区间终点
btn3 = uicontrol('Style', 'pushbutton', 'String', 'Yaxis',...
        'Position', [190 5 40 20],'Backgroundcolor','w');
set(btn3,'Callback', @(x,y)fun_adjustfig(data,text2,2)); % 使用句柄调用回调函数
% 网格
btn4 = uicontrol('Style', 'pushbutton', 'String', 'grid',...
        'Position', [260 5 20 20],'Backgroundcolor','w');
set(btn4,'Callback', @(x,y)fun_adjustfig(data,text2,3)); % 使用句柄调用回调函数

% --- Executes on button press in pushbutton69.
function pushbutton69_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'allpoints')
errordlg('先运行选点结果分析或投影结果分析');
end
data_vel  = gradient(handles.allpoints);
t = handles.alldatetime;
xx = 1:length(data_vel);
%拟合方法polyfit为x值、y值和阶数，得到的p为多项式的各个系数，polyval得到相应的y值
for i = 1:size(data_vel,2)
p  = polyfit(xx',data_vel(:,i),3);
 y1(:,i) = polyval(p,xx');
% y1mean = mean(y1);
end
figure; set (gcf,'Position',[291  , 49 ,  781 ,  635], 'color','w')
plot(t,y1,'Linewidth',3); set(gca,'XTickLabelRotation',45);%set(gca,'xtick',(t(1):1:t(end)));
hold on;plot(t,data_vel);
ylabel('Velocity(mm/per-image)');
set(gca,'FontWeight','bold');set(gca,'FontSize',15);
% A = 'fit';
% fitlabel = repmat(A,length(data_vel),1);
legend(handles.sheetNO);
%--------------------------图像保存------------------------------------
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_adjustfig([],[],4)); % 使用句柄调用回调函数
% 横轴调整参数
text1 = uicontrol('Style','edit','String','0.25','Position',[170 5 20 20]);   % 区间终点
btn2 = uicontrol('Style', 'pushbutton', 'String', 'axis',...
        'Position', [125 5 40 20],'Backgroundcolor','w');
set(btn2,'Callback', @(x,y)fun_adjustfig(t,text1,1)); % 使用句柄调用回调函数
% 纵轴调整参数
text2 = uicontrol('Style','edit','String','1.2','Position',[235 5 20 20]);   % 区间终点
btn3 = uicontrol('Style', 'pushbutton', 'String', 'Yaxis',...
        'Position', [190 5 40 20],'Backgroundcolor','w');
set(btn3,'Callback', @(x,y)fun_adjustfig(data_vel,text2,2)); % 使用句柄调用回调函数
% 网格
btn4 = uicontrol('Style', 'pushbutton', 'String', 'grid',...
        'Position', [260 5 20 20],'Backgroundcolor','w');
set(btn4,'Callback', @(x,y)fun_adjustfig(data_vel,text2,3)); % 使用句柄调用回调函数


function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double
input = str2num(get(hObject,'String'));
if(isempty(input))
    set(hObject,'String','2')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton70.
function pushbutton70_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'点折线图文件选取');
jingdu               = str2double(get(handles.edit18,'String'));
jiaodu               = str2double(get(handles.edit20,'String'));
filename             = strcat(PathName,FileName);
handles.dian_file    = filename;

%% ---------------------第一步：导入形变.csv数据-------------------------
data_dian = csvread(filename,1,1);                      %import点数据文件到data中
data_dian = data_dian.*sind(jiaodu);
[column,row] = size(data_dian);                         %计算data中数据的行数
%% 获取时间列
delimiter = ',';
startRow = 2;


table  = readtable(filename);
data_date  = table.DATE;   
data_date = datetime(data_date);

%列1: 日期时间 (%{yyyy-MM-dd HH:mm}D)
%formatSpec = '%{yyyy-MM-dd HH:mm}D%f%f%f%f%f%f%f%[^\n\r]';
formatSpec = '%f%f%f%f%f%f%f';
fileID = fopen(filename,'r');
%%根据格式读取数据列
title = textscan(fileID,repmat('%s',1,31),1,'delimiter',',');
%dataarray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
%%关闭文本文件。
fclose(fileID);
%将导入的数组分配给列变量名称
%data_date = dataarray{:, 1};
% 对于要求日期序列(datenum)而不是日期时间的代码，请取消注释以下行，以便以 datenum 形式返回导入的日期。
%data_date_num =datenum(data_date);
%清除临时变量
clearvars filename delimiter table dataarray startRow formatSpec fileID ans;
%% ---------------------第二步：每个点位整体时间段内的极大值、极小值、平均值-----------------------------
%% 整体分析
%获取每一列数据的最大值及对应的时间
[data_max_row,max_date] = max(data_dian);
%获取每一列数据的最小值及对应的时间
[data_min_row,min_date] = min(data_dian);
% 求取极值，正向位移最大值或负向位移最大值
[data_max,ind]  = max([abs(data_max_row);abs(data_min_row)],[],1);
data_max(ind == 1) = data_max(ind == 1);
data_max(ind == 2) = -data_max(ind == 2);
dateformat = 'yyyy/mm/dd HH:MM';
ii =1;
for i = 1:length(ind)
    if ind(i) ==1
        data_maxdate{ii,1} = datestr(data_date(max_date(ii)),dateformat);
        ii = ii+1;
    elseif ind(i )==2
        data_maxdate{ii,1} = datestr(data_date(min_date(ii)),dateformat);
        ii = ii+1;
    end
%data_maxdate(ind == 1,1) = datestr(data_date(max_date(ind == 1)),dateformat);
%data_maxdate(ind == 2,1) = datestr(data_date(min_date(ind == 2)),dateformat);
    
end
%获取每一列数据的平均值
data_mean_row = mean(data_dian);


%disp(['自',datestr(data_date(1),dateformat),'到',datestr(data_date(column),dateformat),'止：']);
timespan = {['自',datestr(data_date(1),dateformat),'到',datestr(data_date(column),dateformat),'止：']};


% chart_total = cell(1,7);
% for i = 1:row
%     chart_total{1,1}(i,1) = 'P';
%     chart_total{1,2}(i,1) = i;
% end
% for i = 1:row
%     chart_total(i,1) = i;%整体分析表第一列为点号   
% end
%% ---------------------第三步：每个点位按天分析极大值、极小值、平均值-----------------------------
%% 每天分析最大值以及最小值
%分析整个文档中数据分别属于哪一天
t = datevec(data_date);%将datetime形式转换成向量保存
%获取监测天数date_duration
date_duration = datevec(datetime(data_date(column)) - datetime(data_date(1)));
date_duration = date_duration(1,3)+1;
%分天获取数据中分界点存在date_change_column中
ii = 1;
date_change_column = zeros(1,date_duration-1);
for i = 1:column-1
    if t(i,3) == t(i+1,3)
        continue;
    else
        date_change_column(ii) = i+1;
        ii = ii+1;
    end
end
date_change_column = [1 date_change_column column+1];
%% 将累积位移转换成每日位移
%每天的累积形变为该天自分界点的数据减去前一天最后一组总累积位移数据
% i = 1; data_dian_day(date_change_column(1):date_change_column(2)-1,:) = data_dian(date_change_column(1):date_change_column(2)-1,:);
% i = 2; data_dian_day(date_change_column(2):date_change_column(3)-1,:) = data_dian(date_change_column(2):date_change_column(3)-1,:) - data_dian(date_change_column(2)-1);
% i = 3; data_dian_day(date_change_column(3):date_change_column(4)-1,:) = data_dian(date_change_column(3):date_change_column(4)-1,:) - data_dian(date_change_column(3)-1);
data_dian_day = zeros(column,row);
for i = 1:length(date_change_column)-1
    if i == 1
        data_dian_day(date_change_column(1):date_change_column(2)-1,:)...
            = data_dian(date_change_column(1):date_change_column(2)-1,:);
    else
        data_dian_day(date_change_column(i):date_change_column(i+1)-1,:)...
            = data_dian(date_change_column(i):date_change_column(i+1)-1,:) - data_dian(date_change_column(i)-1);
    end
end
%% 获取每一天中的最大值以及最小值及其对应时刻
data_daymax = zeros(date_duration,row);data_daymin = zeros(date_duration,row);
max_daytime = zeros(date_duration,row);min_daytime = zeros(date_duration,row);
data_daymean = zeros(date_duration,row);data_daymeanmax = zeros(date_duration,1);
for i = 1:length(date_change_column)-1
    disp(['自',datestr(data_date(date_change_column(1,i)),dateformat),'到',datestr(data_date(date_change_column(1,i+1)-1),dateformat),'止：']);
    disp(['当日扫描',num2str(date_change_column(1,i+1)-date_change_column(1,i)),'轨数据']);
    disp(['累积扫描',num2str(date_change_column(1,i+1)-1),'轨数据']);
    %------------------获取每一列数据的最大值及对应的时间----------------
    [data_daymax(i,:),max_daytime(i,:)] = max(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%获取每个时间变化区间内的最大值以及对应的行号
    [data_daymin(i,:),min_daytime(i,:)] = min(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%获取每个时间变化区间内的最小值以及对应的行号 
    data_daymean(i,:) = mean(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%获取日平均值
    %获取每一天每个点的位移,每日最后一个点位移减去前一个点位移
    data_daydef(i,:)  = data_dian_day(date_change_column(1,i+1)-1,:)-data_dian_day(date_change_column(1,i),:);
    %获取每一天每个点的累积位移,每日最后一个点累积位移
    data_daycum(i,:)  = data_dian(date_change_column(1,i+1)-1,:);
   %获取每一天内取得最大值的点
    data_daymeanmax(i,1) = max(data_daymean(i,1:4));%获取区域1，前4个点中的每一天平均值最大值
    
end
%% 自动生成xlsx报告
%将时间跨度、写入xlsx文件
%------------------ 报告清空--------------------
x = ' ';
Filename1 = strrep(FileName,'.csv','.xlsx'); 

[status,message]=xlswrite(Filename1,x,1,'A1');
if ~isempty(message.message)
msgbox(message.message,'提示信息');
end
delete(Filename1);
%------------------ 时间跨度、点号写入表头--------------------
%sheethead1 = {{'点号'} {'最大值'} {'发生时间'} {'累积值'}};
sheethead1 = {('点号') ('最大值') ('发生时间') ('累积值') };
for i = 1:size(data_dian,2)
sheetpointNO{i,1} = ['P',num2str(i)];
end
xlswrite(Filename1,timespan,1,'A1');
xlswrite(Filename1,sheethead1,1,'A2:D2');
% for i = 1:length(sheethead1)
% xlswrite(Filename1,sheethead1(i),1,[char(i+96),num2str(2)]);%i+96表示由数字转字母
% end
xlswrite(Filename1,sheetpointNO,1,'A3');% 写入点号
%data_max = round(data_max,jingdu  );
xlswrite(Filename1,round(data_max',jingdu),1,'B3'); %写入最大值（正向或负向位移最大值）
xlswrite(Filename1,data_maxdate,1,'C3');% 写入发生时间
xlswrite(Filename1,round(data_dian(end,:)',jingdu  ),1,'D3') %写入累积值

%----------------------表2单日点位移分析----------------------
%目前应该写入的行号
current_col = 4+size(data_dian,2);
%dateformat2 =  'yyyy/mm/dd';
%获取表2日期
sheethead2{1,1} = '测量日期';
for i = 1:length(date_change_column)-1

sheethead2{1,i+1}=datestr(data_date(date_change_column(i)),dateformat);
sheethead2{1,i+1}=sheethead2{1,i+1}(6:10);
sheethead2{1,i+1}=[strrep(sheethead2{1,i+1},'/','月'),'日'];
end
%sheethead2 = {'测量日期' sheethead2 };
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % 写入点号

xlswrite(Filename1,round(data_daydef',jingdu),1,['B',num2str(current_col)]);   % 写入数据
current_col =current_col+size(data_dian,2);
[d_max ,ind_max]=max(max(round(data_daydef',jingdu)));
[d_min, ind_min]=min(min(round(data_daydef',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col)]);
xlswrite(Filename1,round(mean(data_daydef(:)),jingdu),1,['E',num2str(current_col)]);
%----------------------表3累积点位移分析----------------------
current_col =current_col+1;
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % 写入点号
xlswrite(Filename1,round(data_daycum',jingdu),1,['B',num2str(current_col)]);     % 写入累积形变值
current_col =current_col+size(data_dian,2);
xlswrite(Filename1,{'平均值'},1,['A',num2str(current_col)]);                      % 写入平均值表头
xlswrite(Filename1,round(mean(data_daycum,2)',jingdu),1,['B',num2str(current_col)]); % 写入平均值
[d_max ,ind_max]=max(max(round(data_daycum',jingdu)));
[d_min, ind_min]=min(min(round(data_daycum',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col+1)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col+1)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col+1)]);
xlswrite(Filename1,round(mean(data_daycum(:)),jingdu),1,['E',num2str(current_col+1)]);
current_col =current_col+1;
xlswrite(Filename1,{['累积处理',num2str(date_change_column(end)-1),'帧形变图像']},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,{['连续监测',num2str(round((date_change_column(end)-1)*0.25)),'小时']},1,['A',num2str(current_col+2)]);  
%----------------------handles 整理---------------------------------
handles.dian_processed = Filename1;
handles.allpoints      = data_dian;
handles.alldatetime    = data_date;
handles.currentcol     = current_col;
handles.sheetNO = sheetpointNO;
guidata(hObject,handles);%n =1;
helpdlg('处理完成','处理完成');


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
axis off;
 a = imread('erweima.jpg');
imshow(a);%set(gcf,'color','')


% --- Executes on button press in pushbutton72.
function pushbutton72_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname1 = strrep(get(handles.edit9,'String'),'.RadarImage','.DiffImage');
fullname2 = strrep(get(handles.edit9,'String'),'.RadarImage','.AfterFilter');
%fullname = fullname';
%timespan = strrep(get(handles.text13,'String'),'.DiffImage','.AfterFilter');
set(handles.edit7,'String',fullname1);
set(handles.edit8,'String',fullname2);
%set(handles.text17,'String',timespan);

[c,r] = size(fullname1);
if c>r;fullname1 = fullname1';fullname2 = fullname2';end
%save FileName.mat fullname1 
handles.AfterFilter = fullname2;
handles.DiffImage = fullname1;
guidata(hObject,handles);



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton73.
function pushbutton73_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~exist('DEM_Result.mat','file')
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
    pclfile = handles.pclfile;


%----------------------选取轨道文件---------------------
if ~isfield('handles','my_position')
[FileName,PathName] = uigetfile({'*.txt';'*.*'},'轨道文件选取',handles.prjdir);
fullnamerail=strcat(PathName,FileName);
my_position =fullnamerail;
handles.my_position = my_position;
else
    my_position =handles.my_position ;
end
%----------------------先生成DEM_Result-----------------
[FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'累积形变文件选取','MultiSelect', 'on',handles.prjdir);
fullname=strcat(PathName,FileName);
%[FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'形变文件选取',handles.prjdir);
%fullnamerail=strcat(PathName,FileName);
difffile =fullname{1};

fun_save3DEM(difffile,pclfile,my_position);
end
%----------------------选取配准形变文件---------------------
if ~isfield('handles','prjdir')
    [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'累积形变文件选取','MultiSelect', 'on');
    handles.prjdir  = PathName;
else
    [FileName,PathName] = uigetfile({'*.DiffImage';'*.*'},'累积形变文件选取','MultiSelect', 'on',handles.prjdir);
end

fullname=strcat(PathName,FileName);

handles.DiffImage = fullname;
handles.prjdir  = PathName;
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
fps = get(handles.edit15,'String');
yuzhi = get(handles.edit16,'String');
view1 = get(handles.edit22,'String');view2 = get(handles.edit23,'String');
view = [str2double(view1) str2double(view2)];
%fullname = handles.DiffImage;
deformation_cumulate3test(yuzhi,fullname',view);

guidata(hObject,handles);


% --- Executes on button press in pushbutton74.
function pushbutton74_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton75.
function pushbutton75_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%open('csvprocess.fig');
%h=gcf;
csvprocess;
%close(h);


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



% --- Executes on button press in pushbutton76.
function pushbutton76_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton76 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('DEM_Result.mat','file')
delete('DEM_Result.mat');
end
helpdlg('清除成功','清除成功');


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3
axis off;
A = imread('erweima.jpg');
imshow(A);


% --- Executes on button press in pushbutton77.
function pushbutton77_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'RadarImage')
    errordlg('先选取.RadarImage文件');
end
%----------------------循环获得文件名----------------------------------------
fullname = handles.RadarImage;
fullname = fullname';
list = fullname;                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);
end
%---------------------循环保存成像图像数据-------------------------------------
[col,row]  = size(list1);
h = waitbar(0,'计算中....');
for i = 1:col
filename        = list1(i,:);
fid             = fopen(filename,'rb');
fid2            = fopen(filename,'rb');
fid3            = fopen(filename,'rb');
data_read3      = fread(fid3,'uint16');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  % 该方法可以读取行数和列数
%% 计算行数列数

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
% 读取成像图像中的数据
fun_show(filename,1,str2double(get(handles.edit10,'String')));
Ampimg                      = findobj(gcf,'type','image');   
AmpData.xaxis               = data_read1(a1+1:end,:);
AmpData.yaxis               = data_read1(1:a1,:);
AmpData.amplitude           = get(Ampimg,'CData');
AmpData.complex             = data_read3;
close(gcf);

if ~exist('E:\SSARLAB\SSARamplitude\','dir')
    mkdir('E:\SSARLAB\SSARamplitude\');
end
save (['E:\SSARLAB\SSARamplitude\',xuhao(i,:),'AmpData','.mat'],'AmpData');
waitbar(i/col,h);  
end
close(h);
%------------------------------打开保存路径--------------------
winopen('E:\SSARLAB\SSARamplitude\');
%n= 1;


% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'DiffImage')
    errordlg('先选取.DiffImage文件');
end
%----------------------循环获得文件名----------------------------------------
fullname = handles.DiffImage;
fullname = fullname';
list = fullname;                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);               % 获得文件的序号（时间）
end
[col,row]  = size(list1);
for i = 1:col
    if exist(list1(i,1:end),'file')        % 如果文件路径类存在该文件及读取形变图像中的数据
        file3            = list1(i,1:end);
    end
end
%file3 = data;
fun_show_xingbian  (file3,3);
%title              (strrep(data,'_','\_'));
% 读取形变图像中的数据
xingbian         = findobj(gcf,'type','image');   
xx               = get(xingbian,'xdata');
yy               = get(xingbian,'ydata');
%[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% 循环获取形变结果
h = waitbar(0,'计算中...');
for i = 1:col

  file2           = list1(i,1:row);
  if exist(file2,'file')                 % 如果文件路径类存在该文件及读取形变图像中的数据
  fun_show_xingbian (file2,3);

%读取形变图像中的数据
xingbian1         = findobj(gcf,'type','image');  
%zzcell{i,1}       = get(xingbian1,'CData');


DiffData.xaxis               = xx;
DiffData.yaxis               = yy;
DiffData.deformation         = get(xingbian1,'CData');
close(gcf);

if ~exist('E:\SSARLAB\SSARdeformation\','dir')
    mkdir('E:\SSARLAB\SSARdeformation\');
end
save (['E:\SSARLAB\SSARdeformation\',xuhao(i,:),'DiffData','.mat'],'DiffData');
  end
waitbar(i/col,h);

end
close(h);
winopen('E:\SSARLAB\SSARdeformation\');


% --- Executes on button press in pushbutton79.
function pushbutton79_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Processcomplexdata;



% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
adjustreference;


% --- Executes on button press in pushbutton81.
function pushbutton81_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'AfterFilter')
    errordlg('先选取.AfterFilter文件');
end
%----------------------循环获得文件名----------------------------------------
fullname = handles.AfterFilter;
fullname = fullname';
list = fullname;                      % 为afterfilter文件的元胞数组，char形式
%list = list.fullname;
%list = list';
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
a = strfind(list1(i,:),'.');b = strfind(list1(i,:),'\');
xuhao(i,:) = list{i,:}(max(b)+1:max(a)-1);               % 获得文件的序号（时间）
end
[col,row]  = size(list1);
for i = 1:col
    if exist(list1(i,1:end),'file')        % 如果文件路径类存在该文件及读取形变图像中的数据
        file2            = list1(i,1:end);
    end
end
%file3 = data;
fun_show_xingbian  (file2,3);
%title              (strrep(data,'_','\_'));
% 读取相干图像中的数据
xianggan         = findobj(gcf,'type','image');   
xx               = get(xianggan,'xdata');
yy               = get(xianggan,'ydata');
%[nxx,nyy]        = meshgrid(xx,yy);
%zz               = get(xingbian,'cdata');
close(figure(gcf));
% 循环获取形变结果
h = waitbar(0,'计算中...');
for i = 1:col

  file2           = list1(i,1:row);
  if exist(file2,'file')                 % 如果文件路径类存在该文件及读取形变图像中的数据
  fun_show (file2,2);

%读取形变图像中的数据
xianggan1         = findobj(gcf,'type','image');  
%zzcell{i,1}       = get(xingbian1,'CData');


AFData.xaxis               = xx;
AFData.yaxis               = yy;
AFData.afterfilter         = get(xianggan1,'CData');
close(gcf);

if ~exist('E:\SSARLAB\SSARafterfilter\','dir')
    mkdir('E:\SSARLAB\SSARafterfilter\');
end
save (['E:\SSARLAB\SSARafterfilter\',xuhao(i,:),'AFData','.mat'],'AFData');
  end
waitbar(i/col,h);

end
close(h);
winopen('E:\SSARLAB\SSARafterfilter\');


% --- Executes on button press in pushbutton82.
function pushbutton82_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SSARwarndataprocess;
