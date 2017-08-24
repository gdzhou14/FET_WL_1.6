%%%%%Output sweep%%%%%%
%初始化设置
Vgo_start=str2double(get(Hc_vgostart,'String'));
Vgo_stop=str2double(get(Hc_vgostop,'String'));
Vgo_step=str2double(get(Hc_vgostep,'String'));
T_delay=str2double(get(Hc_cdelay,'String'));

Vdo_start=str2double(get(Hc_vdostart,'String'));
Vdo_stop=str2double(get(Hc_vdostop,'String'));
Vdo_step=str2double(get(Hc_vdostep,'String'));

Vdo=Vdo_start:Vdo_step:Vdo_stop;
Vdo_size=length(Vdo);
Vdo_reverse=Vdo_stop:-Vdo_step:Vdo_start;%反向扫描
Vdo_size_reverse=length(Vdo_reverse);

Vgo=Vgo_start:Vgo_step:Vgo_stop;
Vgo_Size=length(Vgo);

Ido=zeros(Vdo_size,1);
Ido_total=zeros(Vdo_size,Vgo_Size);
Ido_reverse=zeros(Vdo_size_reverse,1);
Ido_total_reverse=zeros(Vdo_size_reverse,Vgo_Size);

Igo=zeros(Vdo_size,1);
Igo_total=zeros(Vdo_size,Vgo_Size);
Igo_reverse=zeros(Vdo_size_reverse,1);
Igo_total_reverse=zeros(Vdo_size_reverse,Vgo_Size);

%脉冲扫描参数设置
V_pbias=str2double(get(Hc_pbias,'String'));%设置偏置电压
V_pdelay=str2double(get(Hc_pdelay,'String'));%脉冲延时时间
V_pperiod=str2double(get(Hc_v_pulse_period,'String'));%设置脉冲周期
V_pwidth=str2double(get(Hc_v_pulse_width,'String'));%设置脉冲宽度
V_pcycle=str2double(get(Hc_v_cycle,'String'));%设置脉冲循环次数
Ido_cycle=zeros(Vdo_size,V_pcycle);
Igo_cycle=zeros(Vdo_size,V_pcycle);
V_pbias_time=V_pperiod-V_pwidth;%设置偏置电压持续时间


%初始化仪器
if get(Hc_ChAcheck,'Value')==1&& get(Hc_ChBcheck,'Value')==1
 
 Initial_set;%调用初始化函数；
 
 Axis_output_set;%调用坐标设置函数；
 
 %起始电压扫描
 fprintf(g_K2612A,['smua.source.levelv =',num2str(V_pbias)]);
 fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
 
for kkk=1:length(Vgo)
 for jj=1:V_pcycle
   fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgo(kkk))]);
   fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo(1))]);
   fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
   fprintf(g_K2612A,'READING = smua.measure.i()');
   fprintf(g_K2612A, 'print(READING)');
   current_string_do = fscanf(g_K2612A);
   Ido_cycle(1,jj)=str2double(current_string_do);
   fprintf(g_K2612A,'READING = smub.measure.i()');
   fprintf(g_K2612A, 'print(READING)');
   current_string_go = fscanf(g_K2612A);
   Igo_cycle(1,jj)=str2double(current_string_go);
   
   pause(T_delay);
   
   fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgo(kkk))]);
   fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo(1))]);
   fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
   fprintf(g_K2612A,'READING = smua.measure.i()');
   fprintf(g_K2612A, 'print(READING)');
   current_string_do = fscanf(g_K2612A);
   Ido_cycle(1,jj)=str2double(current_string_do);
   fprintf(g_K2612A,'READING = smub.measure.i()');
   fprintf(g_K2612A, 'print(READING)');
   current_string_go = fscanf(g_K2612A);
   Igo_cycle(1,jj)=str2double(current_string_go);
   
   fprintf(g_K2612A,['smua.source.levelv =',num2str(V_pbias)]);
   fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
 end
 Ido(1)=sum(Ido_cycle(1,V_pcycle))/V_pcycle;
 Igo(1)=sum(Igo_cycle(1,V_pcycle))/V_pcycle;
  for iii=2:length(Vdo)
    pause(0.01);
    fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgo(kkk))]);
    fprintf(g_K2612A,['smua.source.levelv =',num2str(V_pbias)]);
    fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
      for jj=1:V_pcycle
       fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo(iii))]);
       fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
       pause(0.01);
       fprintf(g_K2612A,'READING = smua.measure.i()');
       fprintf(g_K2612A, 'print(READING)');
       current_string = fscanf(g_K2612A);
       Ido_cycle(iii,jj)=str2double(current_string);
       fprintf(g_K2612A,'READING = smub.measure.i()');
       fprintf(g_K2612A, 'print(READING)');
       current_string_go = fscanf(g_K2612A);
       Igo_cycle(iii,jj)=str2double(current_string_go);
       fprintf(g_K2612A,['smua.source.levelv =',num2str(V_pbias)]);
       fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
      end
    Ido(iii)=sum(Ido_cycle(iii,V_pcycle))/V_pcycle;
    Igo(iii)=sum(Igo_cycle(iii,V_pcycle))/V_pcycle;
 
    Axis_output_set;%调用坐标设置函数；
   
    plot(Ha_Output,[Vdo(iii-1) Vdo(iii)],[Ido(iii-1,1) Ido(iii,1)],'-r*');
    hold(Ha_Output,'on');
    
    plot(Ha_Transfer,[Vdo(iii-1) Vdo(iii)],[Igo(iii-1,1) Igo(iii,1)],'-r*');
    hold(Ha_Transfer,'on');
  end
 Ido_total(:,kkk)=Ido;
 Igo_total(:,kkk)=Igo;
end
output_forward_scan=[Vdo' Ido_total Igo_total]; 

value_mode=get(Hc_swp_mode,'Value');
if value_mode==1
 output_data=output_forward_scan;   
set(Ha_Output,'XGrid','on');
set(Ha_Output,'YGrid','on');
set(Ha_Transfer,'XGrid','on');
set(Ha_Transfer,'YGrid','on');
elseif value_mode==2
 fprintf(g_K2612A,['smua.source.levelv =',num2str(V_pbias)]);
 fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
 
 for kkk=1:length(Vgo)
  for jj=1:V_pcycle
   fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgo(kkk))]);
   fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo_reverse(1))]);
   fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
   fprintf(g_K2612A,'READING = smua.measure.i()');
   pause(T_delay);
   fprintf(g_K2612A,'READING = smua.measure.i()');
   fprintf(g_K2612A, 'print(READING)');
   current_string_do = fscanf(g_K2612A);
   Ido_cycle(1,jj)=str2double(current_string_do);

   fprintf(g_K2612A,'READING = smub.measure.i()');
   pause(T_delay);
   fprintf(g_K2612A,'READING = smub.measure.i()');
   fprintf(g_K2612A, 'print(READING)');
   current_string_go = fscanf(g_K2612A);
   Igo_cycle(1,jj)=str2double(current_string_go);
  end
 Ido_revease(1)=sum(Ido_cycle(1,V_pcycle))/V_pcycle;
 Igo_reverse(1)=sum(Igo_cycle(1,V_pcycle))/V_pcycle;
  for iii=2:length(Vdo_reverse)
    pause(0.01);
    fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgo(kkk))]);
    fprintf(g_K2612A,['smua.source.levelv =',num2str(V_pbias)]);
    fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
      for jj=1:V_pcycle
       
       fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo_reverse(iii))]);
       fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
       pause(0.01);
       fprintf(g_K2612A,'READING = smua.measure.i()');
       fprintf(g_K2612A,'READING = smua.measure.i()');
       fprintf(g_K2612A, 'print(READING)');
       current_string = fscanf(g_K2612A);
       Ido_cycle(iii,jj)=str2double(current_string);
       fprintf(g_K2612A,'READING = smub.measure.i()');
       pause(T_delay);
       fprintf(g_K2612A,'READING = smub.measure.i()');
       fprintf(g_K2612A, 'print(READING)');
       current_string_go = fscanf(g_K2612A);
       Igo_cycle(iii,jj)=str2double(current_string_go);
       fprintf(g_K2612A,['smua.source.levelv =',num2str(V_pbias)]);
       fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
      end
    Ido_reverse(iii)=sum(Ido_cycle(iii,V_pcycle))/V_pcycle;
    Igo_reverse(iii)=sum(Igo_cycle(iii,V_pcycle))/V_pcycle;
    
    Axis_output_set;%调用坐标设置函数;
   
    plot(Ha_Output,[Vdo_reverse(iii-1) Vdo_reverse(iii)],[Ido_reverse(iii-1,1) Ido_reverse(iii,1)],'-g*');
    hold(Ha_Output,'on');
    
    plot(Ha_Transfer,[Vdo_reverse(iii-1) Vdo_reverse(iii)],[Igo_reverse(iii-1,1) Igo_reverse(iii,1)],'-g*');
    hold(Ha_Transfer,'on');
  end
 Ido_total_reverse(:,kkk)=Ido_reverse;
 Igo_total_reverse(:,kkk)=Igo_reverse;
 end
output_reverse_scan=[Vdo_reverse' Ido_total_reverse Igo_total_reverse]; 
output_data=cat(1,output_forward_scan,output_reverse_scan);
end
fprintf(g_K2612A,'smua.source.levelv =0');%将电源电压值重设为0V
fprintf(g_K2612A,'smub.source.levelv =0');%将电源电压值重设为0V
fprintf(g_K2612A,'smua.source.output = smua.OUTPUT_OFF');%关闭输出                                   
fprintf(g_K2612A,'smub.source.output = smub.OUTPUT_OFF');%关闭输出

output_data_cell=num2cell(output_data);

Vg_start=get(Hc_vgostart,'String');
Vg_stop=get(Hc_vgostop,'String');
Vg_step=get(Hc_vgostep,'String');
curve_dis=['Output scan',' Vg_start:',Vg_start,' V',' Vg_stop:',Vg_stop,' V',' Vg_step:',Vg_step,' V'];
curve_dis_cell={curve_dis,'',''};

time=clock;
time_str=[num2str(time(1,1)),'-',num2str(time(1,2)),'-',num2str(time(1,3)),' ',num2str(time(1,4)),':',num2str(time(1,5)),':',num2str(fix(time(1,6)))];
time_cell={time_str,'',''};

data_dis={'Vd (V)','Id(A)','Ig (A)'};

xls_r1=cat(1,time_cell,curve_dis_cell);
xls_r2=cat(1,xls_r1,data_dis);
output_data_all=cat(1,xls_r2,output_data_cell);



end
 
