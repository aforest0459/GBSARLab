function []=savephotomatch(input_points,base_points)
save input_points.mat input_points;
save base_points.mat base_points;
helpdlg('保存成功','保存成功');
end