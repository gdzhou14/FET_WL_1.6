tr_wl_total=zeros(length(transfer_data(:,1)),W_num+1);
tr_data=xlsread(['tr_wl_',num2str(W_array(1)),'.xls']);
tr_wl_total(:,1:2)=tr_data(:,1:2);
for ii=2:W_num
tr_data=xlsread(['tr_wl_',num2str(W_array(ii)),'.xls']);
tr_wl_total(:,ii+1)=tr_data(:,2);
end
xlswrite('tr_wl_total.xls',tr_wl_total);