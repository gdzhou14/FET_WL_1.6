stop_light=1;
W_start=str2double(get(Hc_Wstart,'String'));
W_stop=str2double(get(Hc_Wstop,'String'));
W_step=str2double(get(Hc_Wstep,'String'));
W_time=str2double(get(Hc_Wtime,'String'));
W_array=W_start:W_step:W_stop;
W_num=length(W_array);
select_filter(W_array(1));
grating_select(num2str(W_array(1)));
calllib('cs_USB','cs_Open',131);
calllib('cs_USB','cs_Write',0,strcat(['GOWAVE ',num2str(W_array(1))],uint8(10))); 
calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
pause(0.5);
calllib('cs_USB','cs_Open',514);
calllib('cs_USB','cs_Write',1,strcat(['GOWAVE ',num2str(W_array(1))],uint8(10))); 
calllib('cs_USB','cs_Write',1, strcat('WAVE?',uint8(10)));
%pause(W_time);
%cla(Ha_Output);
%cla(Ha_Transfer);
%Output_scan;
%output_data_wl=output_data;
cla(Ha_Output);
cla(Ha_Transfer);
Transfer_scan;
transfer_data_wl=transfer_data;
xlswrite(['tr_wl_',num2str(W_array(1)),'.xls'],transfer_data_wl);
%xlswrite('ot_wl_',double2str(W_array(1)),'.xls',output_data_wl);

for ww=2:W_num
    if stop_light==1;
pause(W_time);
select_filter(W_array(ww));% select filter
grating_select(num2str(W_array(ww)));
calllib('cs_USB','cs_Open',131);
calllib('cs_USB','cs_Write',0,strcat(['GOWAVE ',num2str(W_array(ww))],uint8(10))); 
calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
pause(0.5);
calllib('cs_USB','cs_Open',514);
calllib('cs_USB','cs_Write',1,strcat(['GOWAVE ',num2str(W_array(ww))],uint8(10))); 
calllib('cs_USB','cs_Write',1, strcat('WAVE?',uint8(10)));
%Output_scan;
%output_data_wl=output_data;
cla(Ha_Output);
cla(Ha_Transfer);
Transfer_scan;
transfer_data_wl=transfer_data;
xlswrite(['tr_wl_',num2str(W_array(ww)),'.xls'],transfer_data_wl);
%xlswrite('ot_wl_',double2str(W_array(ww)),'.xls',output_data_wl);
    end
end
if stop_light==0
 grating_select(num2str(W_return));
 calllib('cs_USB','cs_Open',131);
 calllib('cs_USB','cs_Write',0,strcat(['GOWAVE ',num2str(W_return)],uint8(10))); 
 calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
 wavelength=calllib('cs_USB','cs_Read',0);
 pause(0.5);
 calllib('cs_USB','cs_Open',514);
 calllib('cs_USB','cs_Write',1,strcat(['GOWAVE ',num2str(W_return)],uint8(10))); 
 calllib('cs_USB','cs_Write',1, strcat('WAVE?',uint8(10)));

end
tr_wl_total=zeros(length(transfer_data(:,1)),W_num+1);
tr_data=xlsread(['tr_wl_',num2str(W_array(1)),'.xls']);
tr_wl_total(:,1:2)=tr_data(:,[1 3]);
for ii=2:W_num
tr_data=xlsread(['tr_wl_',num2str(W_array(ii)),'.xls']);
tr_wl_total(:,ii+1)=tr_data(:,3);
end
xlswrite('tr_wl_total.xls',tr_wl_total);