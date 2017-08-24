if get(Hc_swp_select,'Value')==1
transfer_continue_scan;
set(Hc_Csweepstatus,'ForegroundColor','r');
elseif get(Hc_swp_select,'Value')==2
transfer_pulse_scan;
set(Hc_Psweepstatus,'ForegroundColor','r');
end 