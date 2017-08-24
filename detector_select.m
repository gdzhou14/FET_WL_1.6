
function detector_select(wl)
  if (350<=wl)&&(wl<=1100)
  calllib('cs_USB','cs_Open',131);
  calllib('cs_USB','cs_Write',0,strcat('OUTPORT 2',uint8(10)));% 818-SL(400¨C1100)
%  set(Hc_detector,'String','Wl_400-1100');
  elseif (1100<wl)&&(wl<=1800)
  calllib('cs_USB','cs_Open',131);
  calllib('cs_USB','cs_Write',0,strcat('OUTPORT 1',uint8(10)));% 818-IR(800¨C1800)
% set(Hc_detector,'String','Wl_800-1800');
  end
end