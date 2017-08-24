 if get(Hc_swp_select,'Value')==1
 output_continue_scan;
 set(Hc_Csweepstatus,'ForegroundColor','r');
 elseif get(Hc_swp_select,'Value')==2
 output_pulse_scan;
 set(Hc_Psweepstatus,'ForegroundColor','r');
 end 
