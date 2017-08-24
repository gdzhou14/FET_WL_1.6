[file,path,index]=uiputfile({'*.xls';'*.txt';'*.dat'},'Save File name');
if index==1
xlswrite([path,file],transfer_data_all);
else 
dlmwrite([path,file],transfer_data_all);
end