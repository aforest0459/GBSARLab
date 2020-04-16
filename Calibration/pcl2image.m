function   [pak,pA] = pcl2image(d_deleteUseless,p1,p2)
%��ά���ƿռ������a(Сд)���x,y,z����
xa                = d_deleteUseless(:,1);
ya                = d_deleteUseless(:,2);
za                = d_deleteUseless(:,3);
x1                = p1(1);y1 = p1(2);z1 = p1(3);
x2                = p2(1);y2 = p2(2);z2 = p2(3);
p1                = [x1 y1 z1];
p2                = [x2 y2 z2];
pa                = [xa ya za];                                           % �����a��


p0                = 0.5*[x1+x2 y1+y2 z1+z2];                              % �������ĵ�����,��Ϊ��λ����
Na                = length(xa);                                           % ���Ƶĵ���
% ����ռ�������ڹ����ͶӰ������pak
xk                = zeros(Na,1);yk = zeros(Na,1); zk = zeros(Na,1);
dX                = zeros(Na,1);dY = zeros(Na,1);
for i = 1:length(xa)
    
    xk(i)         = (xa(i)*(x2-x1)^2+x1*(y2-y1)^2+x1*(z2-z1)^2-(x2-x1)*(y2-y1)*(y1-ya(i))...
                     -(x2-x1)*(z2-z1)*(z1-za(i)))/((x2-x1)^2+(y2-y1)^2+(z2-z1)^2);
    yk(i)         = (xk(i)-x1)*(y2-y1)/(x2-x1)+y1;
    zk(i)         = (xk(i)-x1)*(z2-z1)/(x2-x1)+z1;
    dX(i)         = sqrt((xk(i)-p0(1))^2+(yk(i)-p0(2))^2+(zk(i)-p0(3))^2);        % ����ͶӰ�㵽������ĵ����
    dY(i)         = sqrt((xk(i)-xa(i))^2+(yk(i)-ya(i))^2+(zk(i)-za(i))^2);        % ����ͶӰ�㵽�ռ��A�ľ���
% ����жϵ�λ�ڹ���е����һ��
    panduan       = (p0(1)-xk(i))*(x2-x1)+(p0(2)-yk(i))*(y2-y1)+(p0(3)-zk(i))*(z2-z1);
        if panduan > 0
            dX(i) = -dX(i);
        end
end

pak               = [xk yk zk];                                                   % ������ά�ռ��pa������Ĵ���
pA                = [dX dY];                                                      % �ռ���Ӧ�Ķ�ά����pA
end