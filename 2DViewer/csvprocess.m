function varargout = csvprocess(varargin)
% CSVPROCESS MATLAB code for csvprocess.fig
%      CSVPROCESS, by itself, creates a new CSVPROCESS or raises the existing
%      singleton*.
%
%      H = CSVPROCESS returns the handle to a new CSVPROCESS or the handle to
%      the existing singleton*.
%
%      CSVPROCESS('CALLBACK',hObject,eventData,handlescsvprocess,...) calls the local
%      function named CALLBACK in CSVPROCESS.M with the given input arguments.
%
%      CSVPROCESS('Property','Value',...) creates a new CSVPROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before csvprocess_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to csvprocess_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIhandlescsvprocess

% Edit the above text to modify the response to help csvprocess

% Last Modified by GUIDE v2.5 17-Aug-2018 08:48:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @csvprocess_OpeningFcn, ...
                   'gui_OutputFcn',  @csvprocess_OutputFcn, ...
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


% --- Executes just before csvprocess is made visible.
function csvprocess_OpeningFcn(hObject, eventdata, handlescsvprocess, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)
% varargin   command line arguments to csvprocess (see VARARGIN)

% Choose default command line output for csvprocess
handlescsvprocess.output = hObject;

% Update handlescsvprocess structure
guidata(hObject, handlescsvprocess);

% UIWAIT makes csvprocess wait for user response (see UIRESUME)
% uiwait(handlescsvprocess.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = csvprocess_OutputFcn(hObject, eventdata, handlescsvprocess) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)

% Get default command line output from handlescsvprocess structure
varargout{1} = handlescsvprocess.output;



function sectorNumber_Callback(hObject, eventdata, handlescsvprocess)
% hObject    handle to sectorNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sectorNumber as text
%        str2double(get(hObject,'String')) returns contents of sectorNumber as a double
input = str2num(get(hObject,'String'));
if(isempty(input))
    set(hObject,'String','3')
end
guidata(hObject,handlescsvprocess);

% --- Executes during object creation, after setting all properties.
function sectorNumber_CreateFcn(hObject, eventdata, handlescsvprocess)
% hObject    handle to sectorNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    empty - handlescsvprocess not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    empty - handlescsvprocess not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit3_Callback(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    empty - handlescsvprocess not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    empty - handlescsvprocess not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handlescsvprocess)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    empty - handlescsvprocess not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handlescsvprocess)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handlescsvprocess    structure with handlescsvprocess and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls';'*.*'},'������ͼ�ļ�ѡȡ');
sectornumber  = str2double(get(handlescsvprocess.sectorNumber,'String'));  %���򻮷�����
sector1       = str2double(get(handlescsvprocess.edit2,'String'));  %����1����
sector2       = str2double(get(handlescsvprocess.edit3,'String'));  %����2����
sector3       = str2double(get(handlescsvprocess.edit4,'String'));  %����3����
sector4       = str2double(get(handlescsvprocess.edit5,'String'));  %����4����
sector        = [sector1 sector2 sector3 sector4];
filename             = strcat(PathName,FileName);
handlescsvprocess.dian_file    = filename;

if sector4 == 0
%% ---------------------��һ���������α�.csv����-------------------------
data_dian = csvread(filename,1,1);                      %import�������ļ���data��
%data      = csvread(filename,1,0);
%% ��ȡʱ����
delimiter = ',';
startRow = 2;
table  = readtable(filename);
data_date  = table.DATE;
%��1: ����ʱ�� (%{yyyy-MM-dd HH:mm}D)
%formatSpec = '%{yyyy-MM-dd HH:mm}D%f%f%f%f%f%f%f%[^\n\r]';
formatSpec = '%f%f%f%f%f%f%f';
fileID = fopen(filename,'r');
%%���ݸ�ʽ��ȡ������
%title = textscan(fileID,repmat('%s',1,31),1,'delimiter',',');
%dataarray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
%%�ر��ı��ļ���
fclose(fileID);
%����������������б�������
%data_date = dataarray{:, 1};
% ����Ҫ����������(datenum)����������ʱ��Ĵ��룬��ȡ��ע�������У��Ա��� datenum ��ʽ���ص�������ڡ�
%data_date_num =datenum(data_date);
%�����ʱ����
clearvars filename delimiter table dataarray startRow formatSpec fileID ans;
%-----------------------------�����������½�csv�ļ�---------------------------
x = ' ';
%ʱ���б����Ԫ������
dateformat = 'yyyy/mm/dd HH:MM';
for i = 1:length(data_date)
data_date1{i,1} = datestr(data_date(i),dateformat);
end
p_add  = 0;
for i = 1:sectornumber
    if i == 1
    id       = ['����',num2str(i)];
    Filename1 = strcat(id,FileName);
    
    copyfile(handlescsvprocess.dian_file ,Filename1,'f');
    %csvwrite(Filename1,repmat(x,2000,10),2,2);
    
    
    csvwrite(Filename1,data_dian(:,1:sector(i)),1,1);
    xlswrite(Filename1,data_date1,1,'A2');
   headline = {'DATE'};
    for j = 1:sector(i)
    headline{1,j+1}  = ['P',num2str(j)];
   end
    xlswrite(Filename1,headline,1,'A1');
    else
    id       = ['����',num2str(i)];
    Filename1 = strcat(id,FileName);
   
    copyfile(handlescsvprocess.dian_file ,Filename1,'f');
   % csvwrite(Filename1,repmat(x,2000,10),2,2);
   
   headline={'DATE'};
   p_add            = p_add+sector(i-1);
    for j = 1:sector(i)
        
        headline{1,j+1}  = ['P',num2str(j+p_add)];
    end
    
    csvwrite(Filename1,data_dian(:,sector(i-1)+1:sector(i-1)+sector(i)),1,1);
    xlswrite(Filename1,data_date1,1,'A2');
    xlswrite(Filename1,headline,1,'A1');

    end
end
    helpdlg('�������','�������');
else
    helpdlg('������4');
end
save data_date.mat data_date;
guidata(hObject,handlescsvprocess);
