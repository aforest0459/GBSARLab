%均值滤波函数
%------------------------------
%滚动窗均值滤波
%------------------------------
function mean_ES = mean_zz(zz1,filterwindow)
zz = zz1;
[col,row]                  = size(zz);
n_mean                     = round(str2double(filterwindow));                                  % 距离向搜索窗
m_mean                     = round(str2double(filterwindow));                                  % 方位向搜索窗
n_meanmid                  = (n_mean+1)/2;                       % 距离向搜索窗中心点
m_meanmid                  = (m_mean+1)/2;                       % 方位向搜索窗中心点
mean_ES                    = ones(col,row);                      % 二维像rho的点数与Fig图像相同
%mean_ES(n_rhomid,m_rhomid) = 0;
%mean_ES(n_rhomid+1)        = mean(mean(zz(1:n_mean+1,1:m_mean+1))); 

e             = waitbar(0,'均值滤波计算中...');
for i      = 1:col-n_mean-1
    for j  = 1:row-m_mean-1
              mean_ES(n_meanmid+i-1,m_meanmid+j-1)   = mean(mean(zz(i:n_mean+i-1,j:m_mean+j-1)));
    end
    waitbar(i/(col-n_mean-1),e);
end
close(e);

%zz         = mean_ES;


%查看该组形变数据
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('方位向（m）');ylabel('距离向（m）');