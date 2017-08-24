[file,path,index]=uiputfile({'*.xls';'*.txt';'*.dat'},'Save File name');
if index==1
xlswrite([path,file],mod_total);
else 
dlmwrite([path,file],mod_total);
end