function [] = fun_exceptuicontrol(xx,yy,zz,xuhao)
figure;imagesc(xx,yy,zz);colorbar;axis xy;xlabel('��λ��m��');ylabel('������m��');set(gca,'color','w');
colormap hot;
set(gcf,'Position',[ 670   433   711   545]);
title([strrep(xuhao(1,:),'_','\_'),'��',strrep(xuhao(end,:),'_','\_')]);
cmean = sort(zz(:,round(length(xx)/2)),'descend');
cmean = cmean(1);
%cmean = mean(mean(zz));
caxis([cmean*0.8,cmean]); 
