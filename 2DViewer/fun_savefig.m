function []=fun_savecontourfig()
%判断文件夹内图像文件
for i =1:100
if exist(['myfig',num2str(i),'.tif'],'file')
continue;
elseif ~exist(['myfig',num2str(i),'.tif'],'file')
break;
end

    
end
%saveas(gcf,['myfig',num2str(i),'.tiff'])
print (['myfig',num2str(i)], '-r600', '-dtiff');
helpdlg('保存成功','保存成功');
%winopen(['myfig',num2str(i),'.tiff']);