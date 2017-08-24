[file,path,index]=uiputfile({'*.xls';'*.txt';'*.dat'},'Save File name');
if index==1
xlswrite([path,file],data_voltage_scan);
else 
dlmwrite([path,file],data_voltage_scan);
end