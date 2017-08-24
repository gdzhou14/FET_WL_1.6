% uigetdir('C:\Users\ee\Dropbox\Dropbox\Jell_SHB220a\NIN\responsivity test');
[file,path,index]=uiputfile({'*.xls';'*.txt';'*.dat'},'Save File name');

if index==1
xlswrite([path,file],transfer_data_all);
else 
dlmwrite([path,file],transfer_data_all);
end

% movefile(path,[path,'\data'],file);