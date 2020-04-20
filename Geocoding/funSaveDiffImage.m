function ifIsOk = funSaveDiffImage(dataPathDis,diffImageData,tAxis,rAxis)
    fid = fopen(dataPathDis, 'wb');
    fwrite(fid, length(rAxis), 'int');
    fwrite(fid, length(tAxis), 'int');
    fwrite(fid, rAxis, 'double');
    fwrite(fid, tAxis, 'double');
    fwrite(fid, diffImageData, 'float32');
    fclose(fid);
%     fwrite(fid,M,'int32');
%     fwrite(fid,N,'int32',4);
%     fwrite(fid,rAxis','double',8);
%     fwrite(fid,tAxis','double',4*M+8);
%     fwrite(fid,diffImageData(:),'single',4*M+4*N+8);
%     fclose(fid);    
    ifIsOk = 1;
end
