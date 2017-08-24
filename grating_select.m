function grating_select(wl)   
   if wl<=1500
   calllib('cs_USB','cs_Open',131);
   calllib('cs_USB','cs_Write',0,strcat('GRAT 1',uint8(10))); 
   calllib('cs_USB','cs_Open',514);
   calllib('cs_USB','cs_Write',1,strcat('GRAT 1',uint8(10)));
   elseif wl>1500
   calllib('cs_USB','cs_Open',131);
   calllib('cs_USB','cs_Write',0,strcat('GRAT 2',uint8(10)));
   calllib('cs_USB','cs_Open',514);
   calllib('cs_USB','cs_Write',1,strcat('GRAT 2',uint8(10)));
   end
end
