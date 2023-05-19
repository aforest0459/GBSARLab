function [delta,totalRMS,sevenParams]=fun_MATLAB_7p(fileName,nPoints)
%clc;clear all
format long g
m = nPoints;%input('点数个数为：');
%[name ,x,y,z,X,Y,Z p]=textread('data.txt','%s %f %f %f %f %f %f %f',m,'headerlines',1);
%[name ,x,y,z,X,Y,Z p]=textread('data_original.txt','%s %f %f %f %f %f %f %f',m,'headerlines',1);
%[name ,x,y,z,X,Y,Z p]=textread('dataSimTest4.txt','%s %f %f %f %f %f %f %f',m,'headerlines',1);
%[name ,x,y,z,X,Y,Z p]=textread('dataShuichang.txt','%s %f %f %f %f %f %f %f',m,'headerlines',1);
%[name ,x,y,z,X,Y,Z p]=textread('dataGCPsWithNoise1.txt','%s %f %f %f %f %f %f %f',m,'headerlines',1);
%[name ,x,y,z,X,Y,Z p]=textread('dataControlH10.txt','%s %f %f %f %f %f %f %f',m,'headerlines',1);
[name ,x,y,z,X,Y,Z p]=textread(fileName,'%s %f %f %f %f %f %f %f',m,'headerlines',1);
siz=size(x);
if m>=3
    %%%%%%  计算误差方程中的常数项bn   %%%%%%
    for i=1:m
        b.datax(i)=X(i);
        b.datay(i)=Y(i);
        b.dataz(i)=Z(i);
    end
    for k=1:m
        bn((k-1)*3+1)=b.datax(k);
        bn((k-1)*3+2)=b.datay(k);
        bn((k-1)*3+3)=b.dataz(k);
    end
    %%%%%%  计算误差方程中的常数项bn   %%%%%%
    
    
    n=3*m;
    A=zeros(n,7);
    g=1;wx=0;wy=0;wz=0;Xt=0;Yt=0;Zt=0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%  迭代开始  %%%%%%%%%%%%%%%%%%%%%%%%%%%
    for mk=1:100000
        for k=1:m
            M= M_mat(wx,wy,wz,x(k),y(k),z(k));
            MM=M*g;
            R = R_Mat( wx,wy,wz );
            RR=R*[x(k) y(k) z(k)]';
            %求系数矩阵A
            A(1+(k-1)*3)=1;A(n+1+(k-1)*3)=0;A(2*n+1+(k-1)*3)=0;A(3*n+1+(k-1)*3)=MM(1);
            A(4*n+1+(k-1)*3)=MM(4);A(5*n+1+(k-1)*3)=MM(7);A(6*n+1+(k-1)*3)=RR(1);
            A(2+(k-1)*3)=0;A(n+2+(k-1)*3)=1;A(2*n+2+(k-1)*3)=0;A(3*n+2+(k-1)*3)=MM(2);
            A(4*n+2+(k-1)*3)=MM(5);A(5*n+2+(k-1)*3)=MM(8);A(6*n+2+(k-1)*3)=RR(2);
            A(3+(k-1)*3)=0;A(n+3+(k-1)*3)=0;A(2*n+3+(k-1)*3)=1;A(3*n+3+(k-1)*3)=MM(3);
            A(4*n+3+(k-1)*3)=MM(6);A(5*n+3+(k-1)*3)=MM(9);A(6*n+3+(k-1)*3)=RR(3);
            ll(1+3*(k-1):k*3)=-[Xt;Yt;Zt]-g*RR;
        end
        l=ll'+bn';
        v=(A'*A)^-1*(A'*l);
        %%下面为迭代条件
        if max(abs(v(1:3)))<0.0001&&max(abs(v(4:6)))<0.00000001&&min(abs(v(7)))<0.00001
            v(1)=v(1)+Xt;v(2)=v(2)+Yt;v(3)=v(3)+Zt;v(4)=v(4)+wz;v(5)=v(5)+wy;v(6)=v(6)+wx;v(7)=v(7)+g;
            s(1:3)=v(1:3);s(4:6)=v(4:6)*206265/3600;s(7)=v(7);
            break
        else
            Xt=v(1)+Xt;Yt=v(2)+Yt;Zt=v(3)+Zt;wz=v(4)+wz;wy=v(5)+wy;wx=v(6)+wx;g=v(7)+g;
        end
        mk=mk+1;
        if mk>10000
            break
        end
    end
    %%%%  对计算出的7参数结果利用原始数据进行验算
    for k=1:m
        XYZ(1+3*(k-1):3+3*(k-1))=[v(1); v(2); v(3)] ...
            +(v(7))*R_Mat(v(6),v(5),v(4))*[x(k);y(k);z(k)];% 这时求的v是按照Tx Ty Tz wx wy wz lambda排列的
    end
    XYZ'
    targetUntransformed = [x y z];
    save targetUntransformed.txt targetUntransformed -ascii;
    targetTransformed = reshape(XYZ,[3,m])';
    save targetTransformed.txt targetTransformed -ascii;
    targetOriginal = [X Y Z];
    save targetOriginal.txt targetOriginal -ascii;
    tError = targetTransformed-targetOriginal;
    tErrorRMS= sqrt(tError(:,1).^2+tError(:,2).^2+tError(:,3).^2);
    tErrorRMSCorrected = tError(:,1).^2+tError(:,2).^2+tError(:,3).^2;
   % figure;plot(tErrorRMS,'--ro');
    %%%%  对计算出的7参数结果利用原始数据进行验算
    an(6)=rem(s(4),360);an(5)=rem(s(5),360);an(4)=rem(s(6),360);an(1:3)=s(1:3);an(7)=s(7)-1;
    an'%%%最后结果 排列方式Tx Ty Tz wx wy wz lambda
    msgbox('恭喜你，迭代完了！')
else
    msgbox('最少3个点以上')
end
sevenParams = an;
tErrorOutput = [tError tErrorRMS];
tErrorMean = mean(tErrorOutput,1);
tErrorOutput = [tErrorOutput; tErrorMean];
fid=fopen(strrep(fileName, '.txt','tError.txt'),'w');
fprintf(fid,'%.6f %.6f %.6f %.6f\n',tErrorOutput');
fclose(fid);
%% 单位权中误差
delta = sqrt(v'*v/(3*m-7));
disp('delta = ')
delta
%% 总体均方误差
totalRMS = sqrt(sum(tErrorRMS)/m);
totalRMSCorrected = sqrt(sum(tErrorRMSCorrected)/m);
totalRMS
totalRMSCorrected
%%%%%%%%%%%%%%%%%%%%%%%以上使用泰勒一次展开计算%%%%%%%%%%%%%%%%%%%%%%%%%
%**                           end                                  **%
%%%%%%%%%%%%%%%%%%%%%%%%另一种方法计算比例因子%%%%%%%%%%%%%%%%%%%%%%%%%%
c=0;ss=0;
for k=1:m
    for i=1:m
        if i>=k
            break
        end
        ss=sqrt(((X(k)-X(i))^2+(Y(k)-Y(i))^2+(Z(k)-Z(i))^2)/((x(k)-x(i))^2+(y(k)-y(i))^2+(z(k)-z(i))^2))+ss;
    end
end
sss=ss/((m^2-m)/2);

vDeg = rad2deg([v(4) v(5) v(6)]);

%%%%%%%%%%%%%%%%%%%%%%%%另一种方法计算比例因子%%%%%%%%%%%%%%%%%%%%%%%%%%


%     for k=1:length(dataAOri)
%         XYZd(1+3*(k-1):3+3*(k-1))=[v(1); v(2); v(3)] ...
%             +(v(7))*R_Mat(v(6),v(5),v(4))*[dataAOri(k,1);dataAOri(k,2);dataAOri(k,3)];
%     end
%     dataTransformed = reshape(XYZd,[3,length(dataAOri)])';
%     dataError = dataTransformed-dataA(:,5:7);
%     dataErrorRMS = sqrt(dataError(:,1).^2+dataError(:,2).^2+dataError(:,1).^2);
% figure;plot(dataErrorRMS,'--ro');