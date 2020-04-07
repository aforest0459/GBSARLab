function   [pak,pA] = pcl2image(d_deleteUseless,p1,p2)
%outPara pak: 空间任意点在轨道上投影点坐标,任意三维空间点pa到轨道的垂足
%outPara pA: 空间点对应的二维坐标pA

%三维点云空间任意点a(小写)点的x,y,z坐标
xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % 轨道外a点

p0                = 0.5*[x1+x2 y1+y2 z1+z2];                              % 求轨道中心点坐标,作为相位中心
Na                = length(xa);                                           % 点云的点数
% 计算空间任意点在轨道上投影点坐标pak
xk                = zeros(Na,1);yk = zeros(Na,1); zk = zeros(Na,1);
dX                = zeros(Na,1);dY = zeros(Na,1);
for i = 1:length(xa)
    
    xk(i)         = (xa(i)*(x2-x1)^2+x1*(y2-y1)^2+x1*(z2-z1)^2-(x2-x1)*(y2-y1)*(y1-ya(i))...
                     -(x2-x1)*(z2-z1)*(z1-za(i)))/((x2-x1)^2+(y2-y1)^2+(z2-z1)^2);
    yk(i)         = (xk(i)-x1)*(y2-y1)/(x2-x1)+y1;
    zk(i)         = (xk(i)-x1)*(z2-z1)/(x2-x1)+z1;
    dX(i)         = sqrt((xk(i)-p0(1))^2+(yk(i)-p0(2))^2+(zk(i)-p0(3))^2);             % 计算投影点到轨道中心点距离
    dY(i)         = sqrt((xk(i)-xa(i))^2+(yk(i)-ya(i))^2+(zk(i)-za(i))^2);             % 计算投影点到空间点A的距离
    % 点乘判断点位于轨道中点的哪一侧
    panduan       = (p0(1)-xk(i))*(x2-x1)+(p0(2)-yk(i))*(y2-y1)+(p0(3)-zk(i))*(z2-z1);
        if panduan > 0
            dX(i) = -dX(i);
        end
end
pak               = [xk yk zk];                                                   % 任意三维空间点pa到轨道的垂足
pA                = [dX dY];                                                      % 空间点对应的二维坐标pA
end
