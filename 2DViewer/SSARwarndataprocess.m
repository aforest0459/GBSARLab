function varargout = SSARwarndataprocess(varargin)
% SSARWARNDATAPROCESS MATLAB code for SSARwarndataprocess.fig
%      SSARWARNDATAPROCESS, by itself, creates a new SSARWARNDATAPROCESS or raises the existing
%      singleton*.
%
%      H = SSARWARNDATAPROCESS returns the handle to a new SSARWARNDATAPROCESS or the handle to
%      the existing singleton*.
%
%      SSARWARNDATAPROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SSARWARNDATAPROCESS.M with the given input arguments.
%
%      SSARWARNDATAPROCESS('Property','Value',...) creates a new SSARWARNDATAPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SSARwarndataprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SSARwarndataprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SSARwarndataprocess

% Last Modified by GUIDE v2.5 15-Oct-2018 17:00:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SSARwarndataprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @SSARwarndataprocess_OutputFcn, ...
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


% --- Executes just before SSARwarndataprocess is made visible.
function SSARwarndataprocess_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SSARwarndataprocess (see VARARGIN)

% Choose default command line output for SSARwarndataprocess
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SSARwarndataprocess wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SSARwarndataprocess_OutputFcn(hObject, eventdata, handles) 
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
%% 打开区域划分模块
csvprocess;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 选点数据分析，生成excel文档,首先手动选取csv文档
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'点折线图文件选取');
if length(PathName)==1
    errordlg('请选择文件','错误！');
end
jingdu               = str2double(get(handles.edit1,'String'));
%jiaodu               = str2double(get(handles.edit20,'String'));
filename             = strcat(PathName,FileName);
handles.dian_file    = filename;
e = waitbar(0,'计算中...');
%% ---------------------第一步：导入形变.csv数据-------------------------
data_dian = csvread(filename,1,1);                      %import点数据文件到data中
%data_dian = data_dian;
[column,row] = size(data_dian);                         %计算data中数据的行数
%% 获取时间列,以table数据形式读入
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
waitbar(1/3,e);
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
  %  data_daymeanmax(i,1) = max(data_daymean(i,1:4));%获取区域1，前4个点中的每一天平均值最大值
    
end
waitbar(2/3,e);
%% 自动生成xlsx报告
% 将时间跨度、写入xlsx文件
% ------------------ 报告清空--------------------
x = ' ';
Filename1 = strrep(FileName,'.csv','.xlsx'); 

[status,message]=xlswrite(Filename1,x,1,'A1');
if ~isempty(message.message)
msgbox(message.message,'提示信息');
end
delete(Filename1);
%------------------ 时间跨度、点号写入表头--------------------
%sheethead1 = {{'点号'} {'最大值'} {'发生时间'} {'累积值'}};
sheethead1 = {('点号') ('最大值') ('发生时间') ('累积值') ('整体位移分析表')};
for i = 1:size(data_dian,2)
sheetpointNO{i,1} = ['P',num2str(i)];
end
xlswrite(Filename1,timespan,1,'A1');
xlswrite(Filename1,sheethead1,1,'A2:E2');                    % 表1表头写入表格
% for i = 1:length(sheethead1)
% xlswrite(Filename1,sheethead1(i),1,[char(i+96),num2str(2)]);% i+96表示由数字转字母
% end
xlswrite(Filename1,sheetpointNO,1,'A3');% 写入点号
%data_max = round(data_max,jingdu  );
xlswrite(Filename1,round(data_max',jingdu),1,'B3');        % 写入最大值（正向或负向位移最大值）
xlswrite(Filename1,data_maxdate,1,'C3');% 写入发生时间
xlswrite(Filename1,round(data_dian(end,:)',jingdu  ),1,'D3') %写入累积值

%----------------------表2单日点位移分析----------------------
%目前应该写入的行号
current_col = 4+size(data_dian,2);  %4行号分别监测时间段，及表头还有空行；
% 表2名称
xlswrite(Filename1,{'选点时间段位移分析表'},1,['A',num2str(current_col-1)]);
%dateformat2 =  'yyyy/mm/dd';
%获取表2日期
sheethead2{1,1} = '测量日期';
for i = 1:length(date_change_column)-1

sheethead2{1,i+1}=datestr(data_date(date_change_column(i)),dateformat);
sheethead2{1,i+1}=sheethead2{1,i+1}(6:10);
sheethead2{1,i+1}=[strrep(sheethead2{1,i+1},'/','月'),'日'];
end
% ------------------------------表2名称------------------------------

%sheethead2{1,length(date_change_column)}={'时间区间选点位移分析表'};
%sheethead2 = {'测量日期' sheethead2 };
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % 写入点号

xlswrite(Filename1,round(data_daydef',jingdu),1,['B',num2str(current_col)]);    % 写入数据

current_col =current_col+size(data_dian,2)+1;
% ----------------------表3名称-----------------------------------
xlswrite(Filename1,{'选点时间段累积位移分析表'},1,['A',num2str(current_col-1)]);
[d_max ,ind_max]=max(max(round(data_daydef',jingdu)));
[d_min, ind_min]=min(min(round(data_daydef',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col)]);
xlswrite(Filename1,round(mean(data_daydef(:)),jingdu),1,['E',num2str(current_col)]);
%----------------------表3累积点位移分析----------------------

current_col =current_col+1;
%sheethead2{1,length(date_change_column)}={'选点累积位移分析表'};         
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                       % 写入点号
xlswrite(Filename1,round(data_daycum',jingdu),1,['B',num2str(current_col)]);         % 写入累积形变值
current_col =current_col+size(data_dian,2);
xlswrite(Filename1,{'平均值'},1,['A',num2str(current_col)]);                          % 写入平均值表头
xlswrite(Filename1,round(mean(data_daycum,2)',jingdu),1,['B',num2str(current_col)]);  % 写入平均值
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
waitbar(3/3,e);
close(e);
guidata(hObject,handles);%n =1;
helpdlg('处理完成','处理完成');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('Warnprocesslog.txt');



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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'dian_processed')
errordlg('先运行选点结果分析');
end
%n  = 1;

%if 
winopen(handles.dian_processed);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 查看时序累积形变
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
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_savefig()); % 使用句柄调用回调函数
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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
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
btn = uicontrol('Style', 'pushbutton', 'String', 'SSARLAB',...
        'Position', [5 5 120 20],'Backgroundcolor','w');
set(btn,'Callback', @(x,y)fun_savefig()); % 使用句柄调用回调函数
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

% 仅拟合曲线
text = {y1,handles.sheetNO} ;
btn5 = uicontrol('Style', 'pushbutton', 'String', 'fit',...
        'Position', [285 5 20 20],'Backgroundcolor','w');
set(btn5,'Callback', @(x,y)fun_adjustfig(t,text,13)); % 使用句柄调用回调函数

% 5点平均曲线
text3 = uicontrol('Style','edit','String','5','Position',[335 5 20 20]);   % 区间终点
%text = {y1,handles.sheetNO} ;
t1 = {t,data_vel,handles.sheetNO};
btn6 = uicontrol('Style', 'pushbutton', 'String', 'avg',...
        'Position', [310 5 20 20],'Backgroundcolor','w');
set(btn6,'Callback', @(x,y)fun_adjustfig(t1,text3,14)); % 使用句柄调用回调函数
% 仅显示原始曲线

%text = {y1,handles.sheetNO} ;
t2 = {t,data_vel};ll = handles.sheetNO;
btn7= uicontrol('Style', 'pushbutton', 'String', 'orin',...
        'Position', [360 5 20 20],'Backgroundcolor','w');
set(btn7,'Callback', @(x,y)fun_adjustfig(t2,ll,15)); % 使用句柄调用回调函数

%t3 = {t,data_vel};ll = handles.sheetNO;
btn8= uicontrol('Style', 'pushbutton', 'String', 'mlt',...
        'Position', [385 5 20 20],'Backgroundcolor','w');
set(btn8,'Callback', @(x,y)fun_adjustfig(t2,ll,16)); % 使用句柄调用回调函数


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 选点数据分析，生成excel文档,首先手动选取csv文档
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'点折线图文件选取');
if length(PathName)==1
    errordlg('请选择文件','错误！');
end
jingdu               = str2double(get(handles.edit1,'String'));
jiaodu               = str2double(get(handles.edit2,'String'));
filename             = strcat(PathName,FileName);
handles.dian_file    = filename;
e = waitbar(0,'计算中...');
%% ---------------------第一步：导入形变.csv数据-------------------------
data_dian = csvread(filename,1,1);                      %import点数据文件到data中
data_dian = data_dian.*sind(jiaodu);
[column,row] = size(data_dian);                         %计算data中数据的行数
%% 获取时间列,以table数据形式读入
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
waitbar(1/3,e);
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
  %  data_daymeanmax(i,1) = max(data_daymean(i,1:4));%获取区域1，前4个点中的每一天平均值最大值
    
end
waitbar(2/3,e);
%% 自动生成xlsx报告
% 将时间跨度、写入xlsx文件
% ------------------ 报告清空--------------------
x = ' ';
Filename1 = strrep(FileName,'.csv','.xlsx'); 

[status,message]=xlswrite(Filename1,x,1,'A1');
if ~isempty(message.message)
msgbox(message.message,'提示信息');
end
delete(Filename1);
%------------------ 时间跨度、点号写入表头--------------------
%sheethead1 = {{'点号'} {'最大值'} {'发生时间'} {'累积值'}};
sheethead1 = {('点号') ('最大值') ('发生时间') ('累积值') ('整体位移分析表')};
for i = 1:size(data_dian,2)
sheetpointNO{i,1} = ['P',num2str(i)];
end
xlswrite(Filename1,timespan,1,'A1');
xlswrite(Filename1,sheethead1,1,'A2:E2');                    % 表1表头写入表格
% for i = 1:length(sheethead1)
% xlswrite(Filename1,sheethead1(i),1,[char(i+96),num2str(2)]);% i+96表示由数字转字母
% end
xlswrite(Filename1,sheetpointNO,1,'A3');% 写入点号
%data_max = round(data_max,jingdu  );
xlswrite(Filename1,round(data_max',jingdu),1,'B3');        % 写入最大值（正向或负向位移最大值）
xlswrite(Filename1,data_maxdate,1,'C3');% 写入发生时间
xlswrite(Filename1,round(data_dian(end,:)',jingdu  ),1,'D3') %写入累积值

%----------------------表2单日点位移分析----------------------
%目前应该写入的行号
current_col = 4+size(data_dian,2);  %4行号分别监测时间段，及表头还有空行；
% 表2名称
xlswrite(Filename1,{'选点时间段位移分析表'},1,['A',num2str(current_col-1)]);
%dateformat2 =  'yyyy/mm/dd';
%获取表2日期
sheethead2{1,1} = '测量日期';
for i = 1:length(date_change_column)-1

sheethead2{1,i+1}=datestr(data_date(date_change_column(i)),dateformat);
sheethead2{1,i+1}=sheethead2{1,i+1}(6:10);
sheethead2{1,i+1}=[strrep(sheethead2{1,i+1},'/','月'),'日'];
end
% ------------------------------表2名称------------------------------

%sheethead2{1,length(date_change_column)}={'时间区间选点位移分析表'};
%sheethead2 = {'测量日期' sheethead2 };
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % 写入点号

xlswrite(Filename1,round(data_daydef',jingdu),1,['B',num2str(current_col)]);    % 写入数据

current_col =current_col+size(data_dian,2)+1;
% ----------------------表3名称-----------------------------------
xlswrite(Filename1,{'选点时间段累积位移分析表'},1,['A',num2str(current_col-1)]);
[d_max ,ind_max]=max(max(round(data_daydef',jingdu)));
[d_min, ind_min]=min(min(round(data_daydef',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col)]);
xlswrite(Filename1,round(mean(data_daydef(:)),jingdu),1,['E',num2str(current_col)]);
%----------------------表3累积点位移分析----------------------

current_col =current_col+1;
%sheethead2{1,length(date_change_column)}={'选点累积位移分析表'};         
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                       % 写入点号
xlswrite(Filename1,round(data_daycum',jingdu),1,['B',num2str(current_col)]);         % 写入累积形变值
current_col =current_col+size(data_dian,2);
xlswrite(Filename1,{'平均值'},1,['A',num2str(current_col)]);                          % 写入平均值表头
xlswrite(Filename1,round(mean(data_daycum,2)',jingdu),1,['B',num2str(current_col)]);  % 写入平均值
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
waitbar(3/3,e);
close(e);
guidata(hObject,handles);%n =1;
helpdlg('处理完成','处理完成');


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
