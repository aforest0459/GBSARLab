% ���������ڷ���Ԥ��ϵͳ��ѡȡ�����ݵ�������������������
%% ��ʼ��
clear all
%clc
%% ---------------------��һ���������α�.csv����-------------------------
filename = 'D:\001�״����\chenjiang\xingbian\dian327_2_403.csv';
data_dian = csvread(filename,1,1);                %import�������ļ���data��
[column,row] = size(data_dian);                  %����data�����ݵ�����
%% ��ȡʱ����
delimiter = ',';
startRow = 2;
%��1: ����ʱ�� (%{yyyy-MM-dd HH:mm}D)
formatSpec = '%{yyyy-MM-dd HH:mm}D%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
%%���ݸ�ʽ��ȡ������
dataarray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
%%�ر��ı��ļ���
fclose(fileID);
%����������������б�������
data_date = dataarray{:, 1};
% ����Ҫ����������(datenum)����������ʱ��Ĵ��룬��ȡ��ע�������У��Ա��� datenum ��ʽ���ص�������ڡ�
%data_date_num =datenum(data_date);
%�����ʱ����
clearvars filename delimiter dataarray startRow formatSpec fileID ans;

%% ---------------------�ڶ�����ÿ����λ����ʱ����ڵļ���ֵ����Сֵ��ƽ��ֵ-----------------------------
%% �������
%��ȡÿһ�����ݵ����ֵ����Ӧ��ʱ��
[data_max_row,max_date] = max(data_dian);
%��ȡÿһ�����ݵ���Сֵ����Ӧ��ʱ��
[data_min_row,min_date] = min(data_dian);
%��ȡÿһ�����ݵ�ƽ��ֵ
data_mean_row = mean(data_dian);

dateformat = 'yyyy/mm/dd HH:MM';
disp(['��',datestr(data_date(1),dateformat),'��',datestr(data_date(column),dateformat),'ֹ��']);
chart_total = cell(1,7);
for i = 1:row
    chart_total{1,1}(i,1) = 'P';
    chart_total{1,2}(i,1) = i;
end
for i = 1:row
%     disp(['P',num2str(i),'�����ֵΪ��',num2str(data_max_row(i)),'��Ӧʱ��Ϊ��',datestr(data_date(max_date(i)),dateformat)]);
%     disp(['P',num2str(i),'�㸺��λ�����ֵΪ��',num2str(data_min_row(i)),'��Ӧʱ��Ϊ��',datestr(data_date(min_date(i)),dateformat)]);
%     disp(['P',num2str(i),'��ƽ��λ��Ϊ��',num2str(data_mean_row(i))]);
    chart_total(i,1) = i;%����������һ��Ϊ���
%     chart_total(i,2) = data_max_row(i);%�ڶ���Ϊÿ�����������ݵ����ֵ
%     chart_total(i,3) = data_date(max_date(i));%����������Ϊ���ֵ��Ӧ��ʱ��
%     chart_total(i,4) = data_min_row(i);%����������Ϊ�������ݵ���Сֵ
%     chart_total(i,5) = data_date(min_date(i));%����������Ϊ��Сֵ��Ӧ��ʱ��
%     chart_total(i,6) = data_mean_row(i);%����������Ϊ�������ݵ�ƽ��ֵ
    
end


%% ---------------------��������ÿ����λ�����������ֵ����Сֵ��ƽ��ֵ-----------------------------
%% ÿ��������ֵ�Լ���Сֵ
%���������ĵ������ݷֱ�������һ��
t = datevec(data_date);%��datetime��ʽת������������
%��ȡ�������date_duration
date_duration = datevec(data_date(column) - data_date(1));
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
%��ȡÿһ���е����ֵ�Լ���Сֵ�����Ӧʱ��

data_daymax = zeros(date_duration,row);data_daymin = zeros(date_duration,row);
max_daytime = zeros(date_duration,row);min_daytime = zeros(date_duration,row);
data_daymean = zeros(date_duration,row);data_daymeanmax = zeros(date_duration,1);
for i = 1:date_duration
    disp(['��',datestr(data_date(date_change_column(1,i)),dateformat),'��',datestr(data_date(date_change_column(1,i+1)-1),dateformat),'ֹ��']);
    disp(['����ɨ��',num2str(date_change_column(1,i+1)-date_change_column(1,i)),'������']);
    disp(['�ۻ�ɨ��',num2str(date_change_column(1,i+1)-1),'������']);
    %��ȡÿһ�����ݵ����ֵ����Ӧ��ʱ��
    [data_daymax(i,:),max_daytime(i,:)] = max(data_dian(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡÿ��ʱ��仯�����ڵ����ֵ�Լ���Ӧ���к�
    [data_daymin(i,:),min_daytime(i,:)] = min(data_dian(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡÿ��ʱ��仯�����ڵ���Сֵ�Լ���Ӧ���к� 
    data_daymean(i,:) = mean(data_dian(date_change_column(1,i):date_change_column(1,i+1)-1,:));%��ȡ��ƽ��ֵ
%     for j = 1:row
%         disp(['P',num2str(j),'�����ֵΪ��',num2str(data_daymax(i,j)),'��Ӧʱ��Ϊ��',...
%             datestr(data_date(date_change_column(1,i)-1+max_daytime(i,j)),dateformat)]);
%         disp ([ '������ݶ�Ӧ��',num2str(date_change_column(1,i)-1+max_daytime(i,j)),'������']);
%         disp(['P',num2str(j),'����СֵΪ��',num2str(data_daymin(i,j)),'��Ӧʱ��Ϊ��',...
%             datestr(data_date(date_change_column(1,i)-1+min_daytime(i,j)),dateformat)]);
%         disp([ '��С���ݶ�Ӧ��',num2str(date_change_column(1,i)-1+min_daytime(i,j)),'������']);
%         disp([ '�õ㵱���α�ƽ��ֵΪ��',num2str(data_daymean(i,j))]);   
%     end
%     %��ȡÿһ����ȡ�����ֵ�ĵ�
    data_daymeanmax(i,1) = max(data_daymean(i,1:4));%��ȡ����1��ǰ4�����е�ÿһ��ƽ��ֵ���ֵ
    
end
