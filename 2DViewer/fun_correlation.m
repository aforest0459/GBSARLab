function [AfterFilter,deltaR] = fun_correlation(s1u,s2u,n,m)
%% 相干图
%------------------------------
%滚动窗计算相干系数(均匀网格)
%------------------------------
fig_u  = s1u.*conj(s2u);

[col,row]              = size(fig_u);
n_rho                  = round(str2double(n));                                 % 距离向搜索窗
m_rho                  = round(str2double(m));                                 % 方位向搜索窗
n_rhomid               = (n_rho+1)/2;                       % 距离向搜索窗中心点
m_rhomid               = (m_rho+1)/2;                       % 方位向搜索窗中心点
rho_ES                 = zeros(col,row);                    % 二维像rho的点数与Fig图像相同
rho_ES(n_rhomid,m_rhomid) = mean(mean(s1u(1:n_rho,1:m_rho).*conj(s2u(1:n_rho,1:m_rho))))./...
    sqrt(mean(mean(abs(s1u(1:n_rho,1:m_rho)).^2)))./sqrt(mean(mean(abs(s2u(1:n_rho,1:m_rho)).^2)));
% rho(n_rhomid+1)        = mean(ES1(1+1:n_rho+1).*conj(ES2(1+1:n_rho+1)))./sqrt(mean(abs(ES1(1+1:n_rho+1)).^2))./sqrt(mean(abs(ES2(1+1:n_rho+1)).^2));
% rho(n_rhomid+1)        = mean(ES1(1+2:n_rho+2).*conj(ES2(1+2:n_rho+2)))./sqrt(mean(abs(ES1(1+2:n_rho+2)).^2))./sqrt(mean(abs(ES2(1+2:n_rho+2)).^2));
% 
h             = waitbar(0,'相干图计算中...');
for i      = 1:col-n_rho-1
    for j  = 1:row-m_rho-1
   rho_ES(n_rhomid+i-1,m_rhomid+j-1)   = abs(mean(mean(s1u(i:n_rho+i-1,j:m_rho+j-1).*conj(s2u(i:n_rho+i-1,j:m_rho+j-1))))./...
       sqrt(mean(mean(abs(s1u(i:n_rho+i-1,j:m_rho+j-1)).^2)))./sqrt(mean(mean(abs(s2u(i:n_rho+i-1,j:m_rho+j-1)).^2)))); 
    end
    waitbar(i/(col-n_rho-1),h);
end
close(h);
AfterFilter = rho_ES;

rho_threshold                = 0.9;                     %相干系数阈值
%[rhocol,rhorow]              = find(rho_ES<rho_threshold);
% 计算形变值
deltaR                       = angle(fig_u)*3e8/17.25e9/4/pi;
end