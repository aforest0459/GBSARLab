function []=fun_savecontourfig()
%�ж��ļ�����ͼ���ļ�
for i =1:100
if exist(['myfig',num2str(i),'.tif'],'file')
continue;
elseif ~exist(['myfig',num2str(i),'.tif'],'file')
break;
end

    
end
%saveas(gcf,['myfig',num2str(i),'.tiff'])
print (['myfig',num2str(i)], '-r600', '-dtiff');
helpdlg('����ɹ�','����ɹ�');
%winopen(['myfig',num2str(i),'.tiff']);