function []=fun_savecorrelation(xx,yy,zz,text1,text2)
%  handles按钮句柄
%  corrm相干序列的行号
%  corrn相干序列的列号

%a = {'相干图像素行号', '相干图像素列号';corrm,corrn};
h = waitbar(0,'计算中...');
aa = sort(zz(:),'descend');
select =  str2num(get(text2,'String')): str2num(get(text1,'String'));
aa = aa(select);
for i = 1:length(aa)
    
    a(i) = find(zz==aa(i));
    waitbar(i/length(aa),h);
end
zz(a) = zz(a)*10;
%a = [corrm corrn];
%len = length(corrn);
%sheet = ['A1:B',num2str(400000)];
%b = 'col', 'row'};
close(h);
b = {'index'};
x=' ';
xlswrite('correlationgreatpoints.xlsx',x,1,'A1');
delete('correlationgreatpoints.xlsx');
xlswrite('correlationgreatpoints.xlsx',b,1,'A1');
xlswrite('correlationgreatpoints.xlsx',a',1,'A2');
figure;imagesc(xx,yy,zz);axis xy;colorbar;xlabel('方位向（m）');ylabel('距离向（m）');set(gca,'color','w');title([num2str(select(1)),':',num2str(select(end)),'金色亮点为选择的像素']);
helpdlg('保存成功');
%winopen('correlationgreatpoints.xlsx');