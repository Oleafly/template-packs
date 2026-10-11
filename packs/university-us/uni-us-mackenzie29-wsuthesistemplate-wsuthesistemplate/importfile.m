%import text file for input data
clear
clc
fid=fopen('textscanTEST.txt');
fileimportdata=textscan(fid,'%s%s',...
                            'commentStyle', '%')
fclose(fid)