fprintf(g_Lockin,'sens 22');%sensitivity
set(Hc_sensitivity,'Value',23);

fprintf(g_Lockin,'rmod 2');%reserve
set(Hc_reserve,'Value',1);

fprintf(g_Lockin,'isrc 2');%input 
set(Hc_input,'Value',3);

fprintf(g_Lockin,'ignd 0');%ground
set(Hc_ground,'Value',1);

fprintf(g_Lockin,'icpl 0');%couple 
set(Hc_couple,'Value',1);

fprintf(g_Lockin,'fmod 1');%reference 
set(Hc_ref_source,'Value',1);

fprintf(g_Lockin,'rslp 0');%trigger
set(Hc_ref_trigger,'Value',1);

fprintf(g_Lockin,'oflt 10');%time constant
set(Hc_time_constant,'Value',11);

fprintf(g_Lockin,'ddef 1 {,1,0}');%display
fprintf(g_Lockin,'ddef 2 {,1,0}');%display
set(Hc_display,'Value',2);

fprintf(g_Lockin,'sync 1');%synchronous filter set

fprintf(g_Lockin,'fmod 0');%synchronous filter set



if get(Hc_input,'Value')==3 || get(Hc_input,'Value')==4 
    set(Hc_unit,'String','nA')
end

set(Hc_initial_set,'Foregroundcolor','r');
stop_display=0;
while stop_display==0
fprintf(g_Lockin,'outp? 3');%read lock-in value
set(Hc_val_vlg,'String',fscanf(g_Lockin));
fprintf(g_Lockin,'outp? 4');%read lock-in value
set(Hc_val_deg,'String',fscanf(g_Lockin));
pause(0.5);
end