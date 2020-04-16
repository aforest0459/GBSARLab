function []=fun_savecorrelation1(xx,yy,zz,text3)
%  handles按钮句柄
%  corrm相干序列的行号
%  corrn相干序列的列号

%a = {'相干图像素行号', '相干图像素列号';corrm,corrn};
cmean = sort(zz(:),'descend');
cmean = cmean(1);
%cmean = mean(mean(zz));
yuzhi =  str2num(get(text3,'String'));
corrn = find(zz>cmean*yuzhi | zz ==cmean*yuzhi);
[m,n] = find(zz>cmean*yuzhi | zz ==cmean*yuzhi);
zz(corrn)= zz(corrn)*10;
b = {'index'};
x=' ';
xlswrite('correlationgreatpoints.xlsx',x,1,'A1');
delete('correlationgreatpoints.xlsx');
xlswrite('correlationgreatpoints.xlsx',b,1,'A1');
xlswrite('correlationgreatpoints.xlsx',corrn,1,'A2');
xlswrite('correlationgreatpoints.xlsx',m,1,'B2');
xlswrite('correlationgreatpoints.xlsx',n,1,'C2');
figure;imagesc(xx,yy,zz);axis xy;colorbar;xlabel('方位向（m）');ylabel('距离向（m）');set(gca,'color','w');title(['相干阈值大于',num2str(yuzhi),'金色亮点为选择的像素']);
helpdlg('保存成功');
%winopen('correlationgreatpoints.xlsx');