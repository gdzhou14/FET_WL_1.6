[file,path,index]=uiputfile({'*.xls';'*.txt';'*.dat'},'Save File name');
if index==1
xlswrite([path,file],ref_total);
else 
dlmwrite([path,file],ref_total);
end