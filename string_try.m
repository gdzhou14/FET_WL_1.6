dat=zeros(1,10);
for ii=1:10
xlswrite(['transfer_stress_data',num2str(ii),'.xls'],dat(1,ii));
end