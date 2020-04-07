function varargout = Points_Cloud(varargin)
% POINTS_CLOUD MATLAB code for Points_Cloud.fig
%      POINTS_CLOUD, by itself, creates a new POINTS_CLOUD or raises the existing
%      singleton*.
%
%      H = POINTS_CLOUD returns the handle to a new POINTS_CLOUD or the handle to
%      the existing singleton*.
%
%      POINTS_CLOUD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POINTS_CLOUD.M with the given input arguments.
%
%      POINTS_CLOUD('Property','Value',...) creates a new POINTS_CLOUD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Points_Cloud_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Points_Cloud_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Points_Cloud

% Last Modified by GUIDE v2.5 20-Feb-2020 20:13:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Points_Cloud_OpeningFcn, ...
                   'gui_OutputFcn',  @Points_Cloud_OutputFcn, ...
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


% --- Executes just before Points_Cloud is made visible.
function Points_Cloud_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Points_Cloud (see VARARGIN)

% Choose default command line output for Points_Cloud
handles.output = hObject;
%---------------------------关闭各axes初始显示 坐标轴--------------------------
set(handles.axesShow3D ,'visible','off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Points_Cloud wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Points_Cloud_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonSelectPCLFile.
function pushbuttonSelectPCLFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSelectPCLFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% -----------------------选取点云数据------------------
if ~isfield('handles','pclfile') 
     % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.txt'},'点云文件选取',handles.prjdir);
         handles.prjdir  = PathName;
    end

fullnamepcl = strcat(PathName,FileName);
pclfile = fullnamepcl;
handles.pclfile = pclfile;
end

% 未选择即报错
if isempty(handles.pclfile)
    errordlg('先选择点云文件');
end

%% 
%set(handles.edit1,'String',fullname);
%% 句柄整理
guidata(hObject, handles);


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fullname = get(handles.edit1,'String');
k = get(handles.edit2,'String');
fun_lsqnormest(fullname,k);



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('data.txt');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = load('data.txt');
figure;scatter3(data(:,1),data(:,2),data(:,3),4,'filled');grid on;axis equal; 

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = load('data.txt');
figure;
quiver3(data(:,1),data(:,2),data(:,3),data(:,4),data(:,5),data(:,6));


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%open('erweima.fig');set(gcf,'Toolbar','none');set(gcf,'Menubar','none');
winopen('updatalog.txt');


% --- Executes on button press in pushbutton7.
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
if(~iscell(fullname))
    fullname1{1,1} = fullname;
    fullname1{1,2} = fullname;
    fullname = fullname1;
end

handles.DiffImage = fullname;
guidata(hObject,handles);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% ----------------------选取轨道文件---------------------
if ~isfield('handles','my_position')
[FileName,PathName] = uigetfile({'*.txt';'*.*'},'轨道文件选取',handles.prjdir);
fullnamerail=strcat(PathName,FileName);
my_position =fullnamerail;
handles.my_position = my_position;
else
    my_position =handles.my_position ;
end
 % --------------------------------如果未选择文件即报错---------------------------   
    if length(PathName)==1
            clearvars handles.prjdir FileName PathName
            errordlg('请选取文件');
    end
guidata(hObject,handles);

% --- Executes on button press in pushbuttonPlotPCL.
function pushbuttonPlotPCL_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlotPCL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pclfile = handles.pclfile;
pcl  = pclfile;
helpdlg('数据读取中....');

d_deleteUseless   =  load (pcl);
close(gcf);
xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
% 处理z值接近0点数据
temp  = d_deleteUseless(:,3);
temp(d_deleteUseless(:,3) == d_deleteUseless(1,3))=0;
d_deleteUseless(:,3)  = temp;
%-------------------------------------------
pA_3d_fusion     = d_deleteUseless; 
pcloud = pointCloud(pA_3d_fusion(:,1:3));
clearvars ya xa d_deleteUseless
%% scatter3绘制
% figure('Name','三维点云查看');set(gcf,'Color','w');                                 % 图形界面背景以白色显示
% %x,y,z,粗细，强度，形状（默认是圈）
% h = scatter3(pA_3d_fusion(:,1),pA_3d_fusion(:,2),pA_3d_fusion(:,3),2,'filled');
% axis image;
% xlabel('x(m)');ylabel('y(m)');zlabel('z(m)');
% view(15,20);
% colorbar;
%figure('Name','三维点云查看');set(gcf,'Color','w'); 
set(handles.axesShow3D ,'visible','on','Color','w');
%% show pointCloud in embed axes
%handles.axesShow3D=pcshow( pcloud);
%% show pointCloud in new figure window
figure('Name','Terrain point cloud');pcshow( pcloud); set(gcf,'color','w');
colorbar(handles.axesShow3D);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
fullname = handles.DiffImage;
% for i = 1:length(fullname)
%     fullname(i,:) = fullname{i};
% end
%[zz,zzcell,xuhao]=deformation_cumulate2(fullname');
%[m,n1] = size(zz);

if(iscell(fullname))
    [diffImageData, diffImageM, diffImageN, diffImageRAxis, diffImageAAxis]=funDiffImageReader(fullname{1,1});
    diffImageData(diffImageData > -1001 & diffImageData< -999) = 4.5;
    figure;imagesc(diffImageAAxis,diffImageRAxis,diffImageData);
    colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');set(gcf,'color','w');
else
    [diffImageData, diffImageM, diffImageN, diffImageRAxis, diffImageAAxis]=funDiffImageReader(fullname);
    diffImageData(diffImageData > -1001 & diffImageData< -999) = 4.5;
    figure;imagesc(diffImageAAxis,diffImageRAxis,diffImageData);
    colorbar;axis xy;xlabel('方位向（m）');ylabel('距离向（m）');set(gcf,'color','w');
end
   
%colormap parula;

handles.def = diffImageData;
%handles.def_cumulate = zzcell;
%handles.def_xuhao    = xuhao;
guidata(hObject,handles);





% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.DEM_Result,rail,handles.pA_3d_fusion] = peizhun_deformation_temporal(handles.DiffImage,handles.pclfile,handles.my_position,1);
set(handles.edit4,'String',num2str(rail));
guidata(hObject,handles);



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


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.DEM_Result,rail,handles.pA_3d_fusion] = peizhun_deformation_temporal(handles.DiffImage,handles.pclfile,handles.my_position,2);
set(handles.edit4,'String',num2str(rail));
guidata(hObject,handles);


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[DEM_Result,rail] = peizhun_deformation_temporal(handles.DiffImage,handles.pclfile,handles.my_position,3);
set(handles.edit4,'String',num2str(rail));
guidata(hObject,handles);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
raw = handles.DEM_Result;
DEM_XYZ = [raw(:,end-1:end),raw(:,1:end-4)];
%DEM_XYZ = DEM_XYZ';
if ~exist('.\FusionResult\DEM_XYZ.txt','file')
    mkdir('.\FusionResult');
end
fid = fopen('.\FusionResult\DEM_XYZ.txt','w');
%fprintf(fid,'%d,%d,%8.3f,%8.3f,%8.3f,%d,%d,%d\n',DEM_XYZ');
fprintf(fid,'%d,%d,%8.3f,%8.3f,%8.3f\n',DEM_XYZ');
fclose(fid);
helpdlg('点云txt保存成功','处理完成');
winopen('.\FusionResult\');


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.DEM_Result,rail] = peizhun_deformation_temporal(handles.DiffImage,handles.pclfile,handles.my_position,4);
set(handles.edit4,'String',num2str(rail));
guidata(hObject,handles);


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% -----------------------选取点云数据------------------
if ~isfield('handles','pclfile') 
     % 选取文件，如果未设定文件存储路径即手动选取
    if ~isfield(handles,'prjdir')
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.dat';'*.txt'},'点云文件选取');
        handles.prjdir  = PathName;
    else
        [FileName,PathName] = uigetfile({'*.*';'*.xyz';'*.dat';'*.txt'},'点云文件选取',handles.prjdir);
         handles.prjdir  = PathName;
    end

fullnamepcl = strcat(PathName,FileName);
pclfile = fullnamepcl;

pcl  = pclfile;
d_deleteUseless   =  load (pcl);

xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
% 处理z值接近0点数据利用高程均值处理高程数据
temp  = d_deleteUseless(:,3);
temp(d_deleteUseless(:,3) == d_deleteUseless(1,3))=min(temp);
mean_temp= mean(temp);
temp = temp-mean_temp;
d_deleteUseless(:,3)  = temp;
% 保存成xyz文件
raw = d_deleteUseless;
newfile  = strrep(pclfile,'.dat','.xyz');
newfile  = strrep(pclfile,'.txt','.xyz');

fid = fopen(newfile,'w');
%fprintf(fid,'%d,%d,%8.3f,%8.3f,%8.3f,%d,%d,%d\n',DEM_XYZ');
fprintf(fid,'%8.8f,%8.8f,%8.8f\n',raw');
fclose(fid);
helpdlg('点云xyz保存成功','处理完成');
winopen(PathName);
end

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
raw = handles.pA_3d_fusion;

if ~exist('.\FusionResult','dir')
    mkdir('.\FusionResult');
end
fid = fopen('.\FusionResult\3Dfusion.txt','w');
fprintf(fid,'%8.3f,%8.3f,%8.3f,%.3f\n',raw');
fclose(fid);
helpdlg('形变txt保存成功','处理完成');
winopen('.\FusionResult\');


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
raw = handles.pA_3d_fusion;
if ~exist('.\FusionResult','dir')
    mkdir('.\FusionResult');
end
helpdlg('功能开发中');
winopen('.\FusionResult\');


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
raw = handles.DEM_Result;
DEM_XYZ = [raw(:,end-1:end),raw(:,1:end-4)];
%DEM_XYZ = DEM_XYZ';
if ~exist('.\FusionResult\DEM_MNXYZRGB.txt','file')
    mkdir('.\FusionResult');
end
fid = fopen('.\FusionResult\DEM_MNXYZRGB.txt','w');
%fprintf(fid,'%d,%d,%8.3f,%8.3f,%8.3f,%d,%d,%d\n',DEM_XYZ');
fprintf(fid,'%d,%d,%8.3f,%8.3f,%8.3f,%.3f,%.3f,%.3f\n',DEM_XYZ');
fclose(fid);
helpdlg('点云txt保存成功','处理完成');
winopen('.\FusionResult\');


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%raw = handles.DEM_Result;
raw = handles.pA_3d_fusion;
%raw(raw(:,end)==0,end)=NaN;
%DEM_XYZ = [raw(:,end-1:end),raw(:,1:end-4)];
RGB = funGrayScaleMapToRGB(raw(:,end));
RGB(raw(:,end)==0,end-2)=NaN;
RGB(raw(:,end)==0,end-1)=NaN;
RGB(raw(:,end)==0,end)=NaN;
DEM_XYZRGB = [raw(:,1:3) double(RGB)];
%DEM_XYZ = DEM_XYZ';
if ~exist('.\FusionResult\DEM_XYZ.txt','file')
    mkdir('.\FusionResult');
end
fid = fopen('.\FusionResult\DEM_XYZ.txt','w');
%fprintf(fid,'%d,%d,%8.3f,%8.3f,%8.3f,%d,%d,%d\n',DEM_XYZ');
fprintf(fid,'%8.3f,%8.3f,%8.3f,%d,%d,%d\n',DEM_XYZRGB');
fclose(fid);
helpdlg('点云txt保存成功','处理完成');
winopen('.\FusionResult\');


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
raw = handles.DEM_Result;
DEM_XYZ = [raw(:,end-1:end),raw(:,1:end-4)];
% DEM_Result.dat文件的高程是不能有负值的
DEM_XYZCMN = [DEM_XYZ(:,3);DEM_XYZ(:,4);DEM_XYZ(:,5);DEM_XYZ(:,2);DEM_XYZ(:,1)];
%DEM_XYZ = DEM_XYZ';
if ~exist('.\FusionResult\DEM_XYZCMN.dat','file')
    mkdir('.\FusionResult');
end
fid = fopen('.\FusionResult\DEM_XYZCMN.dat','wb');
%fprintf(fid,'%d,%d,%8.3f,%8.3f,%8.3f,%d,%d,%d\n',DEM_XYZ');
fwrite(fid,DEM_XYZCMN,'single');
fclose(fid);
helpdlg('DEM.dat保存成功','处理完成');
winopen('.\FusionResult\');


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('D:\bxsy\tomcat\webapps\minesafe\exedo\webv3\dangqian');


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
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

handles.DiffImage = fullname;
guidata(hObject,handles);

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.DiffImage)
    errordlg('先选择形变文件');
end
fullname = handles.DiffImage;

diffImage = funDiffImageStructReader(fullname);
fun2DDEMBackgrdGenerator(diffImage);
helpdlg('DEM.dat保存成功','处理完成');
winopen('.\FusionResult\');

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('.\FusionResult\');


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.DEM_Result,rail,handles.pA_3d_fusion] = peizhun_deformation_temporal(handles.DiffImage,handles.pclfile,handles.my_position,4);
set(handles.edit4,'String',num2str(rail));
guidata(hObject,handles);


% --------------------------------------------------------------------
function uitoggletool7_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colorbar(handles.axesShow3D,'location','SouthOutSide');
guidata(hObject,handles);


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.DEM_Result,rail,handles.pA_3d_fusion] = peizhun_deformation_temporal(handles.DiffImage,handles.pclfile,handles.my_position,5);
set(handles.edit4,'String',num2str(rail));
guidata(hObject,handles);
