function output_txt = myfunction(obj,event_obj,h)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
%deformation = get(event_obj,'DataSource.CData(ind);
output_txt = {['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)],['Z: ',num2str(pos(3),4)],['Index:',num2str(h.CData(ind))]};% h.表示把图像的参数传递过来，然后使用里面的CData（颜色值）属性
%h = get(event_obj,'DataIndex');

%event_obj.DataSource.CData(ind)
% If there is a Z-coordinate in the position, display it as well

   % output_txt{end+1} = {['Deformation:',num2str(pos(3))]};

