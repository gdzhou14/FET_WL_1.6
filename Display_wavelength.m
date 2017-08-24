while get(Hc_dsp_wavelength,'Value')
calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
wavelength=calllib('cs_USB','cs_Read',0);
set(Hc_val_wavelength,'String',wavelength);
pause(0.2);
end
