[@toc]

# GBSARLab
GB-InSAR 2D/3D Geocoding, Visualization and Feature Extraction
# GBSARGeocoding
Written in matlab, use linear rail end points and DiffImage to create geomapping table txt file. 
该模块使用Matlab进行编写，利用轨道端点坐标以及形变图输出二维雷达图映射至三维空间的txt映射表。
# CSDNBlog
[aforest0459 BLOG](https://blog.csdn.net/weixin_41661099)

# updateLog
源码运行方式：
1、matlab控制台输入guide，然后选择Point_Cloud.fig;
2、在打开的gui界面编辑代码；

打开point_cloud.m，运行，使用gui界面操作

2020/02/23
ver0.59
1.修改“左右相反匹配”中的匹配映射DEM_Result的生成策略，避免出现左右相反匹配成功但生成结果为正常匹配结果的错误；

2020/01/17
ver0.58
1.修改“点云绘制”中的三维点云显示效率，现在的显示更加流畅；

2019/09/06
ver0.57
1.修改“100m内匹配结果生成”按钮，为左右相反配准结果；
2.修改“选择形变数据”按钮，现在可以选择单个diffImage也可以选择多个diffImage;
3.修改“左右相反配准结果”，雷达未扫描到的像素将其匹配至形变图（1,1）处，不在图像内的像素将其匹配至形变图（1,1）处

2019/08/15
ver0.56
1.添加“二维DEM匹配结果生成”界面，用于生成一代二维DEM;

2019/07/23
ver0.55
1.修改"形变图查看"按钮，回调函数，读取形变数据使用funDiffImageReader函数；

2019/05/20
ver0.54
1.添加"一代系统DEM"按钮，用于生成三维配准文件；
2.添加"打开DEM调整文件夹"按钮；

2019/04/22
ver0.53
1.添加"DEMRGB生成txt"按钮，点云数据带有颜色的txt生成最终匹配文件。
2.添加"XYZC生成txt"按钮，点云数据带有灰度的txt生成最终匹配文件。

2018/12/21
1.添加应急地形匹配模块，更换轨道坐标及点云数据，实现应急地形匹配;
2018/11/26
1.添加“点云预处理”模块，添加“84高程均值校正”按钮，目的是利用校正后的数据在二代预警软件中有起伏地显示地形，不影响真实54坐标的查找；
2.修改“计算点云相对雷达角度”模块，添加轨道中心点坐标以及点云图绘制中轴线；

2018/11/12
1.添加“形变生成txt”按钮，数据形式为x y z deformation;
2.添加“形变生成excel”按钮，数据形式为x y z deformation;

2018/10/27 
ver0.50
1.添加“选择点云数据”按钮，点云数据.txt或者.xyz格式数据；
