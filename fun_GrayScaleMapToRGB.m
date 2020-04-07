function rgbUInt8 = funGrayScaleMapToRGB(pclGrayScale)
%Convert from GrayScaleMap To Parula RGB Map
%input: pclGrayScale grayscale in column vector
%output: rgbUInt8 rgb range [0 255] N-by-3 matrix
%upDate:2019-10-08 by Dr.Zheng
%aforest0459@foxmail.com
%
% 灰度转伪彩色
pclColor = (mapminmax(pclGrayScale',0,1))';
% pclColor = pclColor';
% rgb = ind2rgb(gray2ind(pclColor,255),parula);
pclColorMax = max(pclColor);
pclColorMin = min(pclColor);
pclColorLength = 255;
pclColorMap = linspace(pclColorMin,pclColorMax,pclColorLength+1);
pclColorTargetMap = parula(pclColorLength);
pclnum = length(pclGrayScale);

% 判断颜色区间
pclColorMapIndex = zeros(pclnum,1);
for i = 1:pclnum
    for index = 2:length(pclColorMap)
        if pclColor(i)<= pclColorMap(index) && pclColor(i)>= pclColorMap(index-1)
            pclColorMapIndex(i) = index-1;
        else
            continue;
        end
    end
end

% 获取目标颜色矩阵中的颜色值
rgb = pclColorTargetMap(pclColorMapIndex,1:3);
rgb = (mapminmax(rgb',0,255))';

% rgb = ind2rgb(gray2ind(pclColor,255),parula(255));
rgbUInt8 = uint8([rgb(:,1) rgb(:,2) rgb(:,3)]);


end
