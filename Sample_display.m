dt670_curve=xlsread('DT670_curve.xlsx');
size_curve=length(dt670_curve);
while get(Hp_display_status,'Value')==1
fprintf(g_Tcontroller,'SDAT?');
recent_voltage=fscanf(g_Tcontroller);
set(Hc_sample_voltage,'String',recent_voltage);
pause(0.1);
end
