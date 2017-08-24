[file,path,index]=uiputfile({'*.xls';'*.txt';'*.dat'},'Save File name');
if index==1
xlswrite([path,file],output_data);
else 
dlmwrite([path,file],output_data);
end