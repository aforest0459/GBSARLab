function [AfterFilter,deltaR] = fun_correlation(s1u,s2u,n,m)
%% ���ͼ
%------------------------------
%�������������ϵ��(��������)
%------------------------------
fig_u  = s1u.*conj(s2u);

[col,row]              = size(fig_u);
n_rho                  = round(str2double(n));                                 % ������������
m_rho                  = round(str2double(m));                                 % ��λ��������
n_rhomid               = (n_rho+1)/2;                       % ���������������ĵ�
m_rhomid               = (m_rho+1)/2;                       % ��λ�����������ĵ�
rho_ES                 = zeros(col,row);                    % ��ά��rho�ĵ�����Figͼ����ͬ
rho_ES(n_rhomid,m_rhomid) = mean(mean(s1u(1:n_rho,1:m_rho).*conj(s2u(1:n_rho,1:m_rho))))./...
    sqrt(mean(mean(abs(s1u(1:n_rho,1:m_rho)).^2)))./sqrt(mean(mean(abs(s2u(1:n_rho,1:m_rho)).^2)));
% rho(n_rhomid+1)        = mean(ES1(1+1:n_rho+1).*conj(ES2(1+1:n_rho+1)))./sqrt(mean(abs(ES1(1+1:n_rho+1)).^2))./sqrt(mean(abs(ES2(1+1:n_rho+1)).^2));
% rho(n_rhomid+1)        = mean(ES1(1+2:n_rho+2).*conj(ES2(1+2:n_rho+2)))./sqrt(mean(abs(ES1(1+2:n_rho+2)).^2))./sqrt(mean(abs(ES2(1+2:n_rho+2)).^2));
% 
h             = waitbar(0,'���ͼ������...');
for i      = 1:col-n_rho-1
    for j  = 1:row-m_rho-1
   rho_ES(n_rhomid+i-1,m_rhomid+j-1)   = abs(mean(mean(s1u(i:n_rho+i-1,j:m_rho+j-1).*conj(s2u(i:n_rho+i-1,j:m_rho+j-1))))./...
       sqrt(mean(mean(abs(s1u(i:n_rho+i-1,j:m_rho+j-1)).^2)))./sqrt(mean(mean(abs(s2u(i:n_rho+i-1,j:m_rho+j-1)).^2)))); 
    end
    waitbar(i/(col-n_rho-1),h);
end
close(h);
AfterFilter = rho_ES;

rho_threshold                = 0.9;                     %���ϵ����ֵ
%[rhocol,rhorow]              = find(rho_ES<rho_threshold);
% �����α�ֵ
deltaR                       = angle(fig_u)*3e8/17.25e9/4/pi;
end