%获取参数值
Vg_hi=str2double(get(Hc_stress_gate_high_level,'String'));
Vg_lo=str2double(get(Hc_stress_gate_low_level,'String'));
Stress_cycle=str2double(get(Hc_stress_cycle_time,'String'));
Stress_hours=str2double(get(Hc_stress_hours,'String'));
Stress_total_second=Stress_hours*600;
Stress_times_per_hour=600/Stress_cycle;
cycle_times=Stress_total_second/Stress_cycle;
Stress_hours_array=1:1:Stress_hours;
Stress_hours_num=length(Stress_hours_array);
%初始化仪器
if get(Hc_ChAcheck,'Value')==1&& get(Hc_ChBcheck,'Value')==1
  fprintf(g_K2612A,'reset()');%重置2612A
  fprintf(g_K2612A,'smua.source.func = smua.OUTPUT_DCVOLTS');%设置电压源
  fprintf(g_K2612A,'smua.source.rangev =40');
  fprintf(g_K2612A,'smua.source.limiti=1'); 
  fprintf(g_K2612A,'smua.measure.nplc =1'); 
  fprintf(g_K2612A,'smua.measure.autozero = smua.AUTOZERO_AUTO'); 
 % fprintf(g_K2612A,'smua.source.output = smua.OUTPUT_ON');%测试前打开输出
 
  fprintf(g_K2612A,'smub.source.func = smub.OUTPUT_DCVOLTS');%设置电压源
  fprintf(g_K2612A,'smub.source.autorangev = smub.AUTORANGE_ON ');
  fprintf(g_K2612A,'smub.measure.rangei = 10e-4');
  fprintf(g_K2612A,'smub.source.output = smub.OUTPUT_ON');%测试前打开输出
end 
 % fprintf(g_K2612A,['smua.source.levelv =',num2str(Vst_d)]);

 for hh=1:Stress_hours_num
  fprintf(g_K2612A,'smub.source.output = smub.OUTPUT_ON');
  for jjj=1:Stress_times_per_hour
   fprintf(g_K2612A,['smub.source.levelv =',num2str(Vg_hi)]);
   pause(Stress_cycle/2);
   fprintf(g_K2612A,['smub.source.levelv =',num2str(Vg_lo)]);
   pause(Stress_cycle/2);
  end
  Transfer_scan;
  transfer_stress_data=transfer_data;
  xlswrite(['transfer_stress_data_',num2str(Stress_hours_array(hh)),'.xls'],transfer_stress_data);
 end
 
tr_stress_total=zeros(length(transfer_data(:,1)),Stress_hours_num+1);
tr_data=xlsread(['transfer_stress_data_',num2str(Stress_hours_array(1)),'.xls']);
tr_stress_total(:,1:2)=tr_data(:,1:2);
for hhh=2:Stress_hours_num
tr_data=xlsread(['transfer_stress_data_',num2str(Stress_hours_array(hhh)),'.xls']);
tr_stress_total(:,hhh+1)=tr_data(:,2);
end
xlswrite('tr_stress_total.xls',tr_stress_total);
