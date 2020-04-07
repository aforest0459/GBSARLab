%% fun_DiffImageReader
%% LAST EDITED：20190723
%function：funDiffImageReader
%param[In]：diffImageFilePath
%param[out]：diffImageData, 
%param[out]：diffImageM, 
%param[out]：diffImageN, 
%param[out]：diffImageRAxis, 
%param[out]：diffImageAAxis

function [diffImageData, diffImageM, diffImageN, diffImageRAxis, diffImageAAxis]=funDiffImageReader(diffImageFilePath)

fid             = fopen(diffImageFilePath,'rb');
fid2            = fopen(diffImageFilePath,'rb');
fid3            = fopen(diffImageFilePath,'rb');

%% 读取形变图像行号与列号距离向坐标值方位向坐标值及形变数据
data_read3      = fread(fid3,(1:2),'int32');
data_read       = fread(fid,'double');
data_read_int   = fread(fid2,'single');  

diffImageM                 = data_read3(1);
diffImageN                 = data_read3(2);
data_read0        =   [diffImageM;diffImageN];
data_read1        =   data_read(2:data_read0(1)+data_read0(2)+1);
diffImageRAxis            =   data_read1(1:diffImageM);
diffImageAAxis            =   data_read1(1+diffImageM:diffImageN+diffImageM);
fclose(fid);fclose(fid2);fclose(fid3);
data_read_int     = data_read_int((diffImageM+diffImageN)*2+3:end,:);
%% 最终形变二维矩阵
diffImageData = reshape(data_read_int,diffImageM,diffImageN);
clearvars data_read data_read0 data_read1 data_read3 data_read_int filename fid fid2 fid3;
