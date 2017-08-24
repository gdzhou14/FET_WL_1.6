T_step=str2double(get(Hc_Tstep,'String'));
T_cycle=str2double(get(Hc_Tcycle,'String'));
Time_num=1:T_cycle;
cla(Ha_Output);
cla(Ha_Transfer);
Transfer_scan;
transfer_time_data=transfer_data;
xlswrite(['tr_time_',num2str(Time_num(1)),'.xls'],transfer_time_data);

for tt=2:T_cycle
    
pause(T_step*60);
%cla(Ha_Output);
%cla(Ha_Transfer);
Transfer_scan;
transfer_data_wl=transfer_data;
transfer_time_data=transfer_data;
xlswrite(['tr_time_',num2str(Time_num(tt)),'.xls'],transfer_time_data);    
  
end
tr_time_total=zeros(length(transfer_data(:,1)),T_cycle+1);
tr_data=xlsread(['tr_time_',num2str(Time_num(1)),'.xls']);
tr_time_total(:,1:2)=tr_data(:,1:2);
for ii=2:T_cycle
tr_data=xlsread(['tr_time_',num2str(Time_num(ii)),'.xls']);
tr_time_total(:,ii+1)=tr_data(:,2);
end
xlswrite('tr_time_total.xls',tr_time_total);