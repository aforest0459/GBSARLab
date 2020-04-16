function DA = coef_stdev(list)
for i = 1:length(list)
list1(i,:) = list{i,1}(:);
end
[col,row]  = size(list1);

% 循环获取相干结果
for i = 1:col

  file2           = [list1(i,1:row),'.AfterFilter'];
  fun_show(file2,2)
%读取相干图像中的数据
xianggan          = findobj(gcf,'type','image');  
zz_coef{i,1}      = get(xianggan,'cdata');
close(gcf);
end
[nr,nx]  = size(zz_coef{1,1});
% 计算每个像素点均值幅度MA(i,j)
MA   = zeros(nr,nx);
for i = 1:col
    MA   =  MA + zz_coef{i,1};
end
MA    = MA/col;

% 计算标准差
%----------------循环验证---------------
SA     = cell(nr,nx);
SA_std = zeros(nr,nx);
% for i = 1:col 
%     
%         SA{1,1}   = [SA{1,1} zz_coef{i,1}(1,1)]; 
%         SA{1,2}   = [SA{1,2} zz_coef{i,1}(1,2)];
%         SA{2,1}   = [SA{2,1} zz_coef{i,1}(2,1)];
%         
% end
%-----------------验证结束---------------
h             = waitbar(0,'计算中...');
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
% 计算幅度离差DA
DA  = SA_std./MA;

%figure;imagesc(DA);
end
