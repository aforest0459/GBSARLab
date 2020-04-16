function output_txt = myfunction(obj,event_obj,h,zz,zzcell,xuhao,DEM_Result)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
%deformation = get(event_obj,'DataSource.CData(ind);
%output_txt = {['X: ',num2str(pos(1),4)],...
    %['Y: ',num2str(pos(2),4)],['Z: ',num2str(pos(3),4)]};
%-------------统计cursor数--------------
handle = allchild(gca);
num = length(handle);
%--------------------------------------
output_txt = {[num2str(num-1),'点',num2str(pos(3))],['Index:',num2str(h.CData(ind))]};
ii =  find(DEM_Result(:,1) == pos(1) & DEM_Result(:,2) == pos(2) & DEM_Result(:,3) == pos(3)); 
m = DEM_Result(ii,4);
n = DEM_Result(ii,5);
 for i = 1:length(zzcell)
    a(i)  = zzcell{i,1}(m(1),n(1));

 end
for i = 1:length(xuhao)
    xuhao1(i,:) = strrep(xuhao(i,:),'_','\_');
end
xuhao1 = xuhao1(:,7:end-4); 
figure; set (gcf, 'color','w')

plot(a,'--*');grid minor;
nxuhao = get(gca,'Xticklabel');
for i = 1:length(nxuhao)
    nxuhao1(i)=str2num(nxuhao{i});
 end
 nxuhao1(1,length(nxuhao)) = length(xuhao1)-1;
 set(gca,'Xticklabel',xuhao1(nxuhao1+1,:));
 set(gca,'XTickLabelRotation',-45);
  title(['第',num2str(num-1),'点','相干性随时间变化']);
  hd = datacursormode;
hd.UpdateFcn = @(obj,event_obj) NewCallback5(obj,event_obj,xuhao1);
% b = zz_coef; 
% [m,n] = find(zz_coef >h.CData(ind)-0.0001 & zz_coef<h.CData(ind)+0.0001);                         % h.表示把图像的参数传递过来，然后使用里面的CData（颜色值）属性
%  for i = 1:length(zz_coefcell)
%     a(i)  = zz_coefcell{i,1}(m,n);
%  end
% figure; set(gcf,'color','w');plot(a,'--*');grid minor;


%h = get(event_obj,'DataIndex');

%event_obj.DataSource.CData(ind)
% If there is a Z-coordinate in the position, display it as well

   % output_txt{end+1} = {['Deformation:',num2str(pos(3))]};

