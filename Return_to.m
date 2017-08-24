   W_return=str2double(get(Hc_Wreturn,'String')); 
   %%grating select
   if W_return<=1200
   calllib('cs_USB','cs_Open',131);
   calllib('cs_USB','cs_Write',0,strcat('GRAT 1',uint8(10)));% 818-SL(400每1100)
   calllib('cs_USB','cs_Open',514);
   calllib('cs_USB','cs_Write',1,strcat('GRAT 1',uint8(10)));% 818-SL(400每1100)
   elseif W_return>1200
   calllib('cs_USB','cs_Open',131);
   calllib('cs_USB','cs_Write',0,strcat('GRAT 2',uint8(10)));% 818-SL(400每1100)
   calllib('cs_USB','cs_Open',514);
   calllib('cs_USB','cs_Write',1,strcat('GRAT 2',uint8(10)));% 818-SL(400每1100)
   end
   
   %%%left 
   calllib('cs_USB','cs_Open',131);
   calllib('cs_USB','cs_Write',0,strcat(['GOWAVE ',num2str(W_return)],uint8(10))); 
   calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
   wavelength=calllib('cs_USB','cs_Read',0);
   pause(0.5);
   if (325<=W_return)&&(W_return<=650)
     calllib('cs_USB','cs_Open',131);
     calllib('cs_USB','cs_Write',0,strcat('FILTER 1',uint8(10)));
     elseif (650<W_return)&&(W_return<=1800)
     calllib('cs_USB','cs_Open',131);
     calllib('cs_USB','cs_Write',0,strcat('FILTER 2',uint8(10)));
   end
   %%right
   pause(0.5);
   calllib('cs_USB','cs_Open',514);
   calllib('cs_USB','cs_Write',1,strcat(['GOWAVE ',num2str(W_return)],uint8(10)));
   if (325<=W_return)&&(W_return<=650)     
    calllib('cs_USB','cs_Open',514);
    calllib('cs_USB','cs_Write',1,strcat('FILTER 1',uint8(10)));
    filter_no='No.1';
    elseif (650<W_return)&&(W_return<=1800)
    calllib('cs_USB','cs_Open',514);
    calllib('cs_USB','cs_Write',1,strcat('FILTER 2',uint8(10)));
    filter_no='No.2';
   end
  