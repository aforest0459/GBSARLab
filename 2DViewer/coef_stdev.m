function DA = coef_stdev(list)
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
end
[col,row]  = size(list1);

% ѭ����ȡ��ɽ��
for i = 1:col

  file2           = [list1(i,1:row),'.AfterFilter'];
  fun_show(file2,2)
%��ȡ���ͼ���е�����
xianggan          = findobj(gcf,'type','image');  
zz_coef{i,1}      = get(xianggan,'cdata');
close(gcf);
end
[nr,nx]  = size(zz_coef{1,1});
% ����ÿ�����ص��ֵ����MA(i,j)
MA   = zeros(nr,nx);
for i = 1:col
    MA   =  MA + zz_coef{i,1};
end
MA    = MA/col;

% �����׼��
%----------------ѭ����֤---------------
SA     = cell(nr,nx);
SA_std = zeros(nr,nx);
% for i = 1:col 
%     
%         SA{1,1}   = [SA{1,1} zz_coef{i,1}(1,1)]; 
%         SA{1,2}   = [SA{1,2} zz_coef{i,1}(1,2)];
%         SA{2,1}   = [SA{2,1} zz_coef{i,1}(2,1)];
%         
% end
%-----------------��֤����---------------
h             = waitbar(0,'������...');
 for m  = 1:nx 
     for n  = 1:nr
         for i = 1:col
              SA{n,m}      = [SA{n,m} zz_coef{i,1}(n,m)];    
         end
         a            = SA{n,m};
         SA_std(n,m)  = std(a);
     end
waitbar(m/nx,h);
 end
close(h);
% ����������DA
DA  = SA_std./MA;

%figure;imagesc(DA);
end
