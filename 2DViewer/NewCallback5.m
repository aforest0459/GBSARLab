function output_txt = myfunction(obj,event_obj,xuhao1)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
ind = get(event_obj,'DataIndex');
xuhao2 = xuhao1;
output_txt = {['X: ',strrep(xuhao2(ind,:),'\_','_')],...
    ['Y: ',num2str(pos(2),4)]};

% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
end
