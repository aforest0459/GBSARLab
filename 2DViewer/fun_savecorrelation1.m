function []=fun_savecorrelation1(xx,yy,zz,text3)
%  handles��ť���
%  corrm������е��к�
%  corrn������е��к�

%a = {'���ͼ�����к�', '���ͼ�����к�';corrm,corrn};
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
figure;imagesc(xx,yy,zz);axis xy;colorbar;xlabel('��λ��m��');ylabel('������m��');set(gca,'color','w');title(['�����ֵ����',num2str(yuzhi),'��ɫ����Ϊѡ�������']);
helpdlg('����ɹ�');
%winopen('correlationgreatpoints.xlsx');