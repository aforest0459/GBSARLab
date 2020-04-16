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
%% �����򻮷�ģ��
csvprocess;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% ѡ�����ݷ���������excel�ĵ�,�����ֶ�ѡȡcsv�ĵ�
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'������ͼ�ļ�ѡȡ');
if length(PathName)==1
    errordlg('��ѡ���ļ�','����');
end
jingdu               = str2double(get(handles.edit1,'String'));
%jiaodu               = str2double(get(handles.edit20,'String'));
filename             = strcat(PathName,FileName);
handles.dian_file    = filename;
e = waitbar(0,'������...');
%% ---------------------��һ���������α�.csv����-------------------------
data_dian = csvread(filename,1,1);                      %import�������ļ���data��
%data_dian = data_dian;
[column,row] = size(data_dian);                         %����data�����ݵ�����
%% ��ȡʱ����,��table������ʽ����
delimiter = ',';
startRow = 2;

table  = readtable(filename);
data_date = table.DATE;
data_date = datetime(data_date);

%��1: ����ʱ�� (%{yyyy-MM-dd HH:mm}D)
%formatSpec = '%{yyyy-MM-dd HH:mm}D%f%f%f%f%f%f%f%[^\n\r]';
formatSpec = '%f%f%f%f%f%f%f';
fileID = fopen(filename,'r');
%%���ݸ�ʽ��ȡ������
title = textscan(fileID,repmat('%s',1,31),1,'delimiter',',');
%dataarray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
%%�ر��ı��ļ���
fclose(fileID);
%����������������б�������
%data_date = dataarray{:, 1};
% ����Ҫ����������(datenum)����������ʱ��Ĵ��룬��ȡ��ע�������У��Ա��� datenum ��ʽ���ص�������ڡ�
%data_date_num =datenum(data_date);
%�����ʱ����
clearvars filename delimiter table dataarray startRow formatSpec fileID ans;
%% ---------------------�ڶ�����ÿ����λ����ʱ����ڵļ���ֵ����Сֵ��ƽ��ֵ-----------------------------
%% �������
%��ȡÿһ�����ݵ����ֵ����Ӧ��ʱ��
[data_max_row,max_date] = max(data_dian);
%��ȡÿһ�����ݵ���Сֵ����Ӧ��ʱ��
[data_min_row,min_date] = min(data_dian);
% ��ȡ��ֵ������λ�����ֵ����λ�����ֵ
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
%��ȡÿһ�����ݵ�ƽ��ֵ
data_mean_row = mean(data_dian);


%disp(['��',datestr(data_date(1),dateformat),'��',datestr(data_date(column),dateformat),'ֹ��']);
timespan = {['��',datestr(data_date(1),dateformat),'��',datestr(data_date(column),dateformat),'ֹ��']};


% chart_total = cell(1,7);
% for i = 1:row
%     chart_total{1,1}(i,1) = 'P';
%     chart_total{1,2}(i,1) = i;
% end
% for i = 1:row
%     chart_total(i,1) = i;%����������һ��Ϊ���   
% end
waitbar(1/3,e);
%% ---------------------��������ÿ����λ�����������ֵ����Сֵ��ƽ��ֵ-----------------------------
%% ÿ��������ֵ�Լ���Сֵ
%���������ĵ������ݷֱ�������һ��
t = datevec(data_date);%��datetime��ʽת������������
%��ȡ�������date_duration
date_duration = datevec(datetime(data_date(column)) - datetime(data_date(1)));
date_duration = date_duration(1,3)+1;
%�����ȡ�����зֽ�����date_change_column��
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
%% ���ۻ�λ��ת����ÿ��λ��
%ÿ����ۻ��α�Ϊ�����Էֽ������ݼ�ȥǰһ�����һ�����ۻ�λ������
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
%% ��ȡÿһ���е����ֵ�Լ���Сֵ�����Ӧʱ��
data_daymax = zeros(date_duration,row);data_daymin = zeros(date_duration,row);
max_daytime = zeros(date_duration,row);min_daytime = zeros(date_duration,row);
data_daymean = zeros(date_duration,row);data_daymeanmax = zeros(date_duration,1);
for i = 1:length(date_change_column)-1
    disp(['��',datestr(data_date(date_change_column(1,i)),dateformat),'��',datestr(data_date(date_change_column(1,i+1)-1),dateformat),'ֹ��']);
    disp(['����ɨ��',num2str(date_change_column(1,i+1)-date_change_column(1,i)),'������']);
    disp(['�ۻ�ɨ��',num2str(date_change_column(1,i+1)-1),'������']);
    %------------------��ȡÿһ�����ݵ����ֵ����Ӧ��ʱ��----------------
    [data_daymax(i,:),max_daytime(i,:)] = max(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡÿ��ʱ��仯�����ڵ����ֵ�Լ���Ӧ���к�
    [data_daymin(i,:),min_daytime(i,:)] = min(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡÿ��ʱ��仯�����ڵ���Сֵ�Լ���Ӧ���к� 
    data_daymean(i,:) = mean(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡ��ƽ��ֵ
    %��ȡÿһ��ÿ�����λ��,ÿ�����һ����λ�Ƽ�ȥǰһ����λ��
    data_daydef(i,:)  = data_dian_day(date_change_column(1,i+1)-1,:)-data_dian_day(date_change_column(1,i),:);
    %��ȡÿһ��ÿ������ۻ�λ��,ÿ�����һ�����ۻ�λ��
    data_daycum(i,:)  = data_dian(date_change_column(1,i+1)-1,:);
   %��ȡÿһ����ȡ�����ֵ�ĵ�
  %  data_daymeanmax(i,1) = max(data_daymean(i,1:4));%��ȡ����1��ǰ4�����е�ÿһ��ƽ��ֵ���ֵ
    
end
waitbar(2/3,e);
%% �Զ�����xlsx����
% ��ʱ���ȡ�д��xlsx�ļ�
% ------------------ �������--------------------
x = ' ';
Filename1 = strrep(FileName,'.csv','.xlsx'); 

[status,message]=xlswrite(Filename1,x,1,'A1');
if ~isempty(message.message)
msgbox(message.message,'��ʾ��Ϣ');
end
delete(Filename1);
%------------------ ʱ���ȡ����д���ͷ--------------------
%sheethead1 = {{'���'} {'���ֵ'} {'����ʱ��'} {'�ۻ�ֵ'}};
sheethead1 = {('���') ('���ֵ') ('����ʱ��') ('�ۻ�ֵ') ('����λ�Ʒ�����')};
for i = 1:size(data_dian,2)
sheetpointNO{i,1} = ['P',num2str(i)];
end
xlswrite(Filename1,timespan,1,'A1');
xlswrite(Filename1,sheethead1,1,'A2:E2');                    % ��1��ͷд����
% for i = 1:length(sheethead1)
% xlswrite(Filename1,sheethead1(i),1,[char(i+96),num2str(2)]);% i+96��ʾ������ת��ĸ
% end
xlswrite(Filename1,sheetpointNO,1,'A3');% д����
%data_max = round(data_max,jingdu  );
xlswrite(Filename1,round(data_max',jingdu),1,'B3');        % д�����ֵ���������λ�����ֵ��
xlswrite(Filename1,data_maxdate,1,'C3');% д�뷢��ʱ��
xlswrite(Filename1,round(data_dian(end,:)',jingdu  ),1,'D3') %д���ۻ�ֵ

%----------------------��2���յ�λ�Ʒ���----------------------
%ĿǰӦ��д����к�
current_col = 4+size(data_dian,2);  %4�кŷֱ���ʱ��Σ�����ͷ���п��У�
% ��2����
xlswrite(Filename1,{'ѡ��ʱ���λ�Ʒ�����'},1,['A',num2str(current_col-1)]);
%dateformat2 =  'yyyy/mm/dd';
%��ȡ��2����
sheethead2{1,1} = '��������';
for i = 1:length(date_change_column)-1

sheethead2{1,i+1}=datestr(data_date(date_change_column(i)),dateformat);
sheethead2{1,i+1}=sheethead2{1,i+1}(6:10);
sheethead2{1,i+1}=[strrep(sheethead2{1,i+1},'/','��'),'��'];
end
% ------------------------------��2����------------------------------

%sheethead2{1,length(date_change_column)}={'ʱ������ѡ��λ�Ʒ�����'};
%sheethead2 = {'��������' sheethead2 };
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % д����

xlswrite(Filename1,round(data_daydef',jingdu),1,['B',num2str(current_col)]);    % д������

current_col =current_col+size(data_dian,2)+1;
% ----------------------��3����-----------------------------------
xlswrite(Filename1,{'ѡ��ʱ����ۻ�λ�Ʒ�����'},1,['A',num2str(current_col-1)]);
[d_max ,ind_max]=max(max(round(data_daydef',jingdu)));
[d_min, ind_min]=min(min(round(data_daydef',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col)]);
xlswrite(Filename1,round(mean(data_daydef(:)),jingdu),1,['E',num2str(current_col)]);
%----------------------��3�ۻ���λ�Ʒ���----------------------

current_col =current_col+1;
%sheethead2{1,length(date_change_column)}={'ѡ���ۻ�λ�Ʒ�����'};         
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                       % д����
xlswrite(Filename1,round(data_daycum',jingdu),1,['B',num2str(current_col)]);         % д���ۻ��α�ֵ
current_col =current_col+size(data_dian,2);
xlswrite(Filename1,{'ƽ��ֵ'},1,['A',num2str(current_col)]);                          % д��ƽ��ֵ��ͷ
xlswrite(Filename1,round(mean(data_daycum,2)',jingdu),1,['B',num2str(current_col)]);  % д��ƽ��ֵ
[d_max ,ind_max]=max(max(round(data_daycum',jingdu)));
[d_min, ind_min]=min(min(round(data_daycum',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col+1)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col+1)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col+1)]);
xlswrite(Filename1,round(mean(data_daycum(:)),jingdu),1,['E',num2str(current_col+1)]);
current_col =current_col+1;
xlswrite(Filename1,{['�ۻ�����',num2str(date_change_column(end)-1),'֡�α�ͼ��']},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,{['�������',num2str(round((date_change_column(end)-1)*0.25)),'Сʱ']},1,['A',num2str(current_col+2)]);  
%----------------------handles ����---------------------------------
handles.dian_processed = Filename1;
handles.allpoints      = data_dian;

handles.alldatetime    = data_date;
handles.currentcol     = current_col;
handles.sheetNO = sheetpointNO;
waitbar(3/3,e);
close(e);
guidata(hObject,handles);%n =1;
helpdlg('�������','�������');


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
errordlg('������ѡ��������');
end
%n  = 1;

%if 
winopen(handles.dian_processed);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% �鿴ʱ���ۻ��α�
if ~isfield(handles,'allpoints')
errordlg('������ѡ����������ͶӰ�������');
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
set(btn,'Callback', @(x,y)fun_savefig()); % ʹ�þ�����ûص�����
%�����������
text1 = uicontrol('Style','edit','String','0.25','Position',[170 5 20 20]);   % �����յ�
btn2 = uicontrol('Style', 'pushbutton', 'String', 'Xaxis',...
        'Position', [125 5 40 20],'Backgroundcolor','w');
set(btn2,'Callback', @(x,y)fun_adjustfig(t,text1,1)); % ʹ�þ�����ûص�����
%�����������
text2 = uicontrol('Style','edit','String','1.2','Position',[235 5 20 20]);   % �����յ�
btn3 = uicontrol('Style', 'pushbutton', 'String', 'Yaxis',...
        'Position', [190 5 40 20],'Backgroundcolor','w');
set(btn3,'Callback', @(x,y)fun_adjustfig(data,text2,2)); % ʹ�þ�����ûص�����
% ����
btn4 = uicontrol('Style', 'pushbutton', 'String', 'grid',...
        'Position', [260 5 20 20],'Backgroundcolor','w');
set(btn4,'Callback', @(x,y)fun_adjustfig(data,text2,3)); % ʹ�þ�����ûص�����


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'allpoints')
errordlg('������ѡ����������ͶӰ�������');
end
data_vel  = gradient(handles.allpoints);
t = handles.alldatetime;
xx = 1:length(data_vel);
%��Ϸ���polyfitΪxֵ��yֵ�ͽ������õ���pΪ����ʽ�ĸ���ϵ����polyval�õ���Ӧ��yֵ
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
set(btn,'Callback', @(x,y)fun_savefig()); % ʹ�þ�����ûص�����
% �����������
text1 = uicontrol('Style','edit','String','0.25','Position',[170 5 20 20]);   % �����յ�
btn2 = uicontrol('Style', 'pushbutton', 'String', 'axis',...
        'Position', [125 5 40 20],'Backgroundcolor','w');
set(btn2,'Callback', @(x,y)fun_adjustfig(t,text1,1)); % ʹ�þ�����ûص�����
% �����������
text2 = uicontrol('Style','edit','String','1.2','Position',[235 5 20 20]);   % �����յ�
btn3 = uicontrol('Style', 'pushbutton', 'String', 'Yaxis',...
        'Position', [190 5 40 20],'Backgroundcolor','w');
set(btn3,'Callback', @(x,y)fun_adjustfig(data_vel,text2,2)); % ʹ�þ�����ûص�����
% ����
btn4 = uicontrol('Style', 'pushbutton', 'String', 'grid',...
        'Position', [260 5 20 20],'Backgroundcolor','w');
set(btn4,'Callback', @(x,y)fun_adjustfig(data_vel,text2,3)); % ʹ�þ�����ûص�����

% ���������
text = {y1,handles.sheetNO} ;
btn5 = uicontrol('Style', 'pushbutton', 'String', 'fit',...
        'Position', [285 5 20 20],'Backgroundcolor','w');
set(btn5,'Callback', @(x,y)fun_adjustfig(t,text,13)); % ʹ�þ�����ûص�����

% 5��ƽ������
text3 = uicontrol('Style','edit','String','5','Position',[335 5 20 20]);   % �����յ�
%text = {y1,handles.sheetNO} ;
t1 = {t,data_vel,handles.sheetNO};
btn6 = uicontrol('Style', 'pushbutton', 'String', 'avg',...
        'Position', [310 5 20 20],'Backgroundcolor','w');
set(btn6,'Callback', @(x,y)fun_adjustfig(t1,text3,14)); % ʹ�þ�����ûص�����
% ����ʾԭʼ����

%text = {y1,handles.sheetNO} ;
t2 = {t,data_vel};ll = handles.sheetNO;
btn7= uicontrol('Style', 'pushbutton', 'String', 'orin',...
        'Position', [360 5 20 20],'Backgroundcolor','w');
set(btn7,'Callback', @(x,y)fun_adjustfig(t2,ll,15)); % ʹ�þ�����ûص�����

%t3 = {t,data_vel};ll = handles.sheetNO;
btn8= uicontrol('Style', 'pushbutton', 'String', 'mlt',...
        'Position', [385 5 20 20],'Backgroundcolor','w');
set(btn8,'Callback', @(x,y)fun_adjustfig(t2,ll,16)); % ʹ�þ�����ûص�����


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% ѡ�����ݷ���������excel�ĵ�,�����ֶ�ѡȡcsv�ĵ�
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'������ͼ�ļ�ѡȡ');
if length(PathName)==1
    errordlg('��ѡ���ļ�','����');
end
jingdu               = str2double(get(handles.edit1,'String'));
jiaodu               = str2double(get(handles.edit2,'String'));
filename             = strcat(PathName,FileName);
handles.dian_file    = filename;
e = waitbar(0,'������...');
%% ---------------------��һ���������α�.csv����-------------------------
data_dian = csvread(filename,1,1);                      %import�������ļ���data��
data_dian = data_dian.*sind(jiaodu);
[column,row] = size(data_dian);                         %����data�����ݵ�����
%% ��ȡʱ����,��table������ʽ����
delimiter = ',';
startRow = 2;

table  = readtable(filename);
data_date = table.DATE;
data_date = datetime(data_date);

%��1: ����ʱ�� (%{yyyy-MM-dd HH:mm}D)
%formatSpec = '%{yyyy-MM-dd HH:mm}D%f%f%f%f%f%f%f%[^\n\r]';
formatSpec = '%f%f%f%f%f%f%f';
fileID = fopen(filename,'r');
%%���ݸ�ʽ��ȡ������
title = textscan(fileID,repmat('%s',1,31),1,'delimiter',',');
%dataarray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
%%�ر��ı��ļ���
fclose(fileID);
%����������������б�������
%data_date = dataarray{:, 1};
% ����Ҫ����������(datenum)����������ʱ��Ĵ��룬��ȡ��ע�������У��Ա��� datenum ��ʽ���ص�������ڡ�
%data_date_num =datenum(data_date);
%�����ʱ����
clearvars filename delimiter table dataarray startRow formatSpec fileID ans;
%% ---------------------�ڶ�����ÿ����λ����ʱ����ڵļ���ֵ����Сֵ��ƽ��ֵ-----------------------------
%% �������
%��ȡÿһ�����ݵ����ֵ����Ӧ��ʱ��
[data_max_row,max_date] = max(data_dian);
%��ȡÿһ�����ݵ���Сֵ����Ӧ��ʱ��
[data_min_row,min_date] = min(data_dian);
% ��ȡ��ֵ������λ�����ֵ����λ�����ֵ
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
%��ȡÿһ�����ݵ�ƽ��ֵ
data_mean_row = mean(data_dian);


%disp(['��',datestr(data_date(1),dateformat),'��',datestr(data_date(column),dateformat),'ֹ��']);
timespan = {['��',datestr(data_date(1),dateformat),'��',datestr(data_date(column),dateformat),'ֹ��']};


% chart_total = cell(1,7);
% for i = 1:row
%     chart_total{1,1}(i,1) = 'P';
%     chart_total{1,2}(i,1) = i;
% end
% for i = 1:row
%     chart_total(i,1) = i;%����������һ��Ϊ���   
% end
waitbar(1/3,e);
%% ---------------------��������ÿ����λ�����������ֵ����Сֵ��ƽ��ֵ-----------------------------
%% ÿ��������ֵ�Լ���Сֵ
%���������ĵ������ݷֱ�������һ��
t = datevec(data_date);%��datetime��ʽת������������
%��ȡ�������date_duration
date_duration = datevec(datetime(data_date(column)) - datetime(data_date(1)));
date_duration = date_duration(1,3)+1;
%�����ȡ�����зֽ�����date_change_column��
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
%% ���ۻ�λ��ת����ÿ��λ��
%ÿ����ۻ��α�Ϊ�����Էֽ������ݼ�ȥǰһ�����һ�����ۻ�λ������
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
%% ��ȡÿһ���е����ֵ�Լ���Сֵ�����Ӧʱ��
data_daymax = zeros(date_duration,row);data_daymin = zeros(date_duration,row);
max_daytime = zeros(date_duration,row);min_daytime = zeros(date_duration,row);
data_daymean = zeros(date_duration,row);data_daymeanmax = zeros(date_duration,1);
for i = 1:length(date_change_column)-1
    disp(['��',datestr(data_date(date_change_column(1,i)),dateformat),'��',datestr(data_date(date_change_column(1,i+1)-1),dateformat),'ֹ��']);
    disp(['����ɨ��',num2str(date_change_column(1,i+1)-date_change_column(1,i)),'������']);
    disp(['�ۻ�ɨ��',num2str(date_change_column(1,i+1)-1),'������']);
    %------------------��ȡÿһ�����ݵ����ֵ����Ӧ��ʱ��----------------
    [data_daymax(i,:),max_daytime(i,:)] = max(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡÿ��ʱ��仯�����ڵ����ֵ�Լ���Ӧ���к�
    [data_daymin(i,:),min_daytime(i,:)] = min(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡÿ��ʱ��仯�����ڵ���Сֵ�Լ���Ӧ���к� 
    data_daymean(i,:) = mean(data_dian_day(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡ��ƽ��ֵ
    %��ȡÿһ��ÿ�����λ��,ÿ�����һ����λ�Ƽ�ȥǰһ����λ��
    data_daydef(i,:)  = data_dian_day(date_change_column(1,i+1)-1,:)-data_dian_day(date_change_column(1,i),:);
    %��ȡÿһ��ÿ������ۻ�λ��,ÿ�����һ�����ۻ�λ��
    data_daycum(i,:)  = data_dian(date_change_column(1,i+1)-1,:);
   %��ȡÿһ����ȡ�����ֵ�ĵ�
  %  data_daymeanmax(i,1) = max(data_daymean(i,1:4));%��ȡ����1��ǰ4�����е�ÿһ��ƽ��ֵ���ֵ
    
end
waitbar(2/3,e);
%% �Զ�����xlsx����
% ��ʱ���ȡ�д��xlsx�ļ�
% ------------------ �������--------------------
x = ' ';
Filename1 = strrep(FileName,'.csv','.xlsx'); 

[status,message]=xlswrite(Filename1,x,1,'A1');
if ~isempty(message.message)
msgbox(message.message,'��ʾ��Ϣ');
end
delete(Filename1);
%------------------ ʱ���ȡ����д���ͷ--------------------
%sheethead1 = {{'���'} {'���ֵ'} {'����ʱ��'} {'�ۻ�ֵ'}};
sheethead1 = {('���') ('���ֵ') ('����ʱ��') ('�ۻ�ֵ') ('����λ�Ʒ�����')};
for i = 1:size(data_dian,2)
sheetpointNO{i,1} = ['P',num2str(i)];
end
xlswrite(Filename1,timespan,1,'A1');
xlswrite(Filename1,sheethead1,1,'A2:E2');                    % ��1��ͷд����
% for i = 1:length(sheethead1)
% xlswrite(Filename1,sheethead1(i),1,[char(i+96),num2str(2)]);% i+96��ʾ������ת��ĸ
% end
xlswrite(Filename1,sheetpointNO,1,'A3');% д����
%data_max = round(data_max,jingdu  );
xlswrite(Filename1,round(data_max',jingdu),1,'B3');        % д�����ֵ���������λ�����ֵ��
xlswrite(Filename1,data_maxdate,1,'C3');% д�뷢��ʱ��
xlswrite(Filename1,round(data_dian(end,:)',jingdu  ),1,'D3') %д���ۻ�ֵ

%----------------------��2���յ�λ�Ʒ���----------------------
%ĿǰӦ��д����к�
current_col = 4+size(data_dian,2);  %4�кŷֱ���ʱ��Σ�����ͷ���п��У�
% ��2����
xlswrite(Filename1,{'ѡ��ʱ���λ�Ʒ�����'},1,['A',num2str(current_col-1)]);
%dateformat2 =  'yyyy/mm/dd';
%��ȡ��2����
sheethead2{1,1} = '��������';
for i = 1:length(date_change_column)-1

sheethead2{1,i+1}=datestr(data_date(date_change_column(i)),dateformat);
sheethead2{1,i+1}=sheethead2{1,i+1}(6:10);
sheethead2{1,i+1}=[strrep(sheethead2{1,i+1},'/','��'),'��'];
end
% ------------------------------��2����------------------------------

%sheethead2{1,length(date_change_column)}={'ʱ������ѡ��λ�Ʒ�����'};
%sheethead2 = {'��������' sheethead2 };
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                  % д����

xlswrite(Filename1,round(data_daydef',jingdu),1,['B',num2str(current_col)]);    % д������

current_col =current_col+size(data_dian,2)+1;
% ----------------------��3����-----------------------------------
xlswrite(Filename1,{'ѡ��ʱ����ۻ�λ�Ʒ�����'},1,['A',num2str(current_col-1)]);
[d_max ,ind_max]=max(max(round(data_daydef',jingdu)));
[d_min, ind_min]=min(min(round(data_daydef',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col)]);
xlswrite(Filename1,round(mean(data_daydef(:)),jingdu),1,['E',num2str(current_col)]);
%----------------------��3�ۻ���λ�Ʒ���----------------------

current_col =current_col+1;
%sheethead2{1,length(date_change_column)}={'ѡ���ۻ�λ�Ʒ�����'};         
xlswrite(Filename1,sheethead2,1,['A',num2str(current_col)]);
current_col =current_col+1;
xlswrite(Filename1,sheetpointNO,1,['A',num2str(current_col)]);                       % д����
xlswrite(Filename1,round(data_daycum',jingdu),1,['B',num2str(current_col)]);         % д���ۻ��α�ֵ
current_col =current_col+size(data_dian,2);
xlswrite(Filename1,{'ƽ��ֵ'},1,['A',num2str(current_col)]);                          % д��ƽ��ֵ��ͷ
xlswrite(Filename1,round(mean(data_daycum,2)',jingdu),1,['B',num2str(current_col)]);  % д��ƽ��ֵ
[d_max ,ind_max]=max(max(round(data_daycum',jingdu)));
[d_min, ind_min]=min(min(round(data_daycum',jingdu)));
xlswrite(Filename1,{sheethead2{ind_max+1}},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,d_max,1,['B',num2str(current_col+1)]);
xlswrite(Filename1,{sheethead2{ind_min+1}},1,['C',num2str(current_col+1)]);
xlswrite(Filename1,d_min,1,['D',num2str(current_col+1)]);
xlswrite(Filename1,round(mean(data_daycum(:)),jingdu),1,['E',num2str(current_col+1)]);
current_col =current_col+1;
xlswrite(Filename1,{['�ۻ�����',num2str(date_change_column(end)-1),'֡�α�ͼ��']},1,['A',num2str(current_col+1)]);
xlswrite(Filename1,{['�������',num2str(round((date_change_column(end)-1)*0.25)),'Сʱ']},1,['A',num2str(current_col+2)]);  
%----------------------handles ����---------------------------------
handles.dian_processed = Filename1;
handles.allpoints      = data_dian;

handles.alldatetime    = data_date;
handles.currentcol     = current_col;
handles.sheetNO = sheetpointNO;
waitbar(3/3,e);
close(e);
guidata(hObject,handles);%n =1;
helpdlg('�������','�������');


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
