function []=fun_savecorrelation(xx,yy,zz,text1,text2)
%  handles��ť���
%  corrm������е��к�
%  corrn������е��к�

%a = {'���ͼ�����к�', '���ͼ�����к�';corrm,corrn};
h = waitbar(0,'������...');
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
figure;imagesc(xx,yy,zz);axis xy;colorbar;xlabel('��λ��m��');ylabel('������m��');set(gca,'color','w');title([num2str(select(1)),':',num2str(select(end)),'��ɫ����Ϊѡ�������']);
helpdlg('����ɹ�');
%winopen('correlationgreatpoints.xlsx');