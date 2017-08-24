function filter_no=select_filter(wl)
 if (325<=wl)&&(wl<=650)
calllib('cs_USB','cs_Open',131);
calllib('cs_USB','cs_Write',0,strcat('FILTER 1',uint8(10)));
pause(0.5);
calllib('cs_USB','cs_Open',514);
calllib('cs_USB','cs_Write',1,strcat('FILTER 1',uint8(10)));
%filter_no='No.1';
pause(0.5);
 elseif (650<wl)&&(wl<=1800)
calllib('cs_USB','cs_Open',131);
calllib('cs_USB','cs_Write',0,strcat('FILTER 2',uint8(10)));
pause(0.5);
calllib('cs_USB','cs_Open',514);
calllib('cs_USB','cs_Write',1,strcat('FILTER 2',uint8(10)));
%filter_no='No.2';
pause(0.5);
 end
