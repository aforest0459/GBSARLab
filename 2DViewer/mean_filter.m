%��ֵ�˲�����
%------------------------------
%��������ֵ�˲�
%------------------------------
function mean_ES = mean_zz(zz1,filterwindow)
zz = zz1;
[col,row]                  = size(zz);
n_mean                     = round(str2double(filterwindow));                                  % ������������
m_mean                     = round(str2double(filterwindow));                                  % ��λ��������
n_meanmid                  = (n_mean+1)/2;                       % ���������������ĵ�
m_meanmid                  = (m_mean+1)/2;                       % ��λ�����������ĵ�
mean_ES                    = ones(col,row);                      % ��ά��rho�ĵ�����Figͼ����ͬ
%mean_ES(n_rhomid,m_rhomid) = 0;
%mean_ES(n_rhomid+1)        = mean(mean(zz(1:n_mean+1,1:m_mean+1))); 

e             = waitbar(0,'��ֵ�˲�������...');
for i      = 1:col-n_mean-1
    for j  = 1:row-m_mean-1
              mean_ES(n_meanmid+i-1,m_meanmid+j-1)   = mean(mean(zz(i:n_mean+i-1,j:m_mean+j-1)));
    end
    waitbar(i/(col-n_mean-1),e);
end
close(e);

%zz         = mean_ES;


%�鿴�����α�����
%figure;imagesc(-xx,yy,zz);colorbar;axis xy;title(strrep(data,'_','\_'));xlabel('��λ��m��');ylabel('������m��');