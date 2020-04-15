function geotiffData = funGeoTiffReadData(filename)
% Function: read geotiff data (image or elevation) and get saved data
% any bugs email : aforest0459@foxmail.com
% Date 2019/09/25 by Dr.Zheng Xiangtian

%% 读取geotiff图像并可视化
% example
%filename = 'D:\3_dsm_ortho\2_mosaic\fangshan_transparent_mosaic_group1.tif';
%filename = 'newGeoTiff.tif';

%% 读入geotiff图像
[A,~] = geotiffread(filename);
%A = double(A);                                         % 转换为matlab函数可读的形式;
info  = geotiffinfo(filename);                      % 读取geotiff中携带的信息；
R = info.SpatialRef;

[m,n,numOfColorLayer]=size(A);

%% 获得图像坐标矩阵
xAxisIndex = 1:n;
yAxisIndex = 1:m;
[xMesh,yMesh] = meshgrid(xAxisIndex,yAxisIndex);
%[x,y] = pix2map(R,row,col)
[LonMesh,LatMesh] = pix2map(R,yMesh,xMesh);

geotiffData.Data = A;
geotiffData.info = info;
geotiffData.R = R;
geotiffData.LonMesh =LonMesh;
geotiffData.LatMesh = LatMesh;
%% 可视化
% if(numOfColorLayer >=3)
%     figure,imshow(A(:,:,1:3));title('不带地理坐标的tif影像');
%     figure,mapshow(A(:,:,1:3),R);title('带地理坐标的tif影像');
% else
%     
%     figure,imshow(A(:,:,1));title('不带地理坐标的tif影像');  
% end
end
