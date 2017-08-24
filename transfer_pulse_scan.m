%%%%%transfer sweep%%%%%%
%初始化设置
Vg_start=str2double(get(Hc_vgstart,'String'));
Vg_stop=str2double(get(Hc_vgstop,'String'));
Vg_step=str2double(get(Hc_vgstep,'String'));
T_delay=str2double(get(Hc_cdelay,'String'));

Vd_start=str2double(get(Hc_vdstart,'String'));
Vd_stop=str2double(get(Hc_vdstop,'String'));
Vd_step=str2double(get(Hc_vdstep,'String'));

Vd=Vd_start:Vd_step:Vd_stop;
Vd_size=length(Vd);
Vg=Vg_start:Vg_step:Vg_stop;
Vg_size=length(Vg);
Vg_reverse=Vg_stop:-Vg_step:Vg_start;
Vg_size_reverse=length(Vg_reverse);
%电流
Id=zeros(Vg_size,1);
Id_total=zeros(Vg_size,Vd_size);
Id_reverse=zeros(Vg_size_reverse,1);
Id_total_reverse=zeros(Vg_size_reverse,Vd_size);
Ig=zeros(Vg_size,1);
Ig_total=zeros(Vg_size,Vd_size);
Ig_reverse=zeros(Vg_size_reverse,1);
Ig_total_reverse=zeros(Vg_size_reverse,Vd_size);

%脉冲扫描参数设置
V_pbias=str2double(get(Hc_pbias,'String'));%设置偏置电压
V_pdelay=str2double(get(Hc_pdelay,'String'));%脉冲延时时间
V_pperiod=str2double(get(Hc_v_pulse_period,'String'));%设置脉冲周期
V_pwidth=str2double(get(Hc_v_pulse_width,'String'));%设置脉冲宽度
V_pcycle=str2double(get(Hc_v_cycle,'String'));%设置脉冲循环次数
Id_cycle=zeros(Vg_size,V_pcycle);
Ig_cycle=zeros(Vg_size,V_pcycle);
V_pbias_time=V_pperiod-V_pwidth;%设置偏置电压持续时间


%初始化仪器
if get(Hc_ChAcheck,'Value')==1&& get(Hc_ChBcheck,'Value')==1
 
 Initial_set;%调用初始化函数；
 
 Axis_transfer_set;%调用坐标设置函数
 
 %起始电压扫描
 fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
 fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
 for kk=1:length(Vd)
   for jj=1:V_pcycle
     fprintf(g_K2612A,['smua.source.levelv =',num2str(Vd(kk))]);
     fprintf(g_K2612A,['smub.source.levelv =',num2str(Vg(1))]);
     fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
     fprintf(g_K2612A,'READING = smua.measure.i()');
     fprintf(g_K2612A, 'print(READING)');
     current_string_d = fscanf(g_K2612A);
     Id_cycle(1,jj)=str2double(current_string_d);
     fprintf(g_K2612A,'READING = smub.measure.i()');
     fprintf(g_K2612A, 'print(READING)');
     current_string_g = fscanf(g_K2612A);
     Ig_cycle(1,jj)=str2double(current_string_g);
     pause(T_delay);
     
     fprintf(g_K2612A,['smua.source.levelv =',num2str(Vd(kk))]);
     fprintf(g_K2612A,['smub.source.levelv =',num2str(Vg(1))]);
     fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
     fprintf(g_K2612A,'READING = smua.measure.i()');
     fprintf(g_K2612A, 'print(READING)');
     current_string_d = fscanf(g_K2612A);
     Id_cycle(1,jj)=str2double(current_string_d);
     fprintf(g_K2612A,'READING = smub.measure.i()');
     fprintf(g_K2612A, 'print(READING)');
     current_string_g = fscanf(g_K2612A);
     Ig_cycle(1,jj)=str2double(current_string_g);
     
     fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
     fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ;
   end
   Id(1)=sum(Id_cycle(1,V_pcycle))/V_pcycle;
   Ig(1)=sum(Ig_cycle(1,V_pcycle))/V_pcycle;
   for ii=2:length(Vg)
      pause(0.01);
      fprintf(g_K2612A,['smua.source.levelv =',num2str(Vd(kk))]);
      fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
      fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
      for jj=1:V_pcycle
          fprintf(g_K2612A,['smub.source.levelv =',num2str(Vg(ii))]);
          fprintf(g_K2612A,['delay( ',num2str(T_delay),' )']) ;
          pause(0.01);
          fprintf(g_K2612A,'READING = smua.measure.i()');
          fprintf(g_K2612A, 'print(READING)');
          current_string = fscanf(g_K2612A);
          Id_cycle(ii,jj)=str2double(current_string);
          fprintf(g_K2612A,'READING = smub.measure.i()');
          fprintf(g_K2612A, 'print(READING)');
          current_string_go = fscanf(g_K2612A);
          Ig_cycle(ii,jj)=str2double(current_string_go);
          fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
          fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ;
      end
     Id(ii)=sum(Id_cycle(ii,V_pcycle))/V_pcycle;
     Ig(ii)=sum(Ig_cycle(ii,V_pcycle))/V_pcycle;
     
     Axis_transfer_set;%调用坐标设置函数；
   
     plot(Ha_Output,[Vg(ii-1) Vg(ii)],[Id(ii-1,1) Id(ii,1)],'-r*');
     hold(Ha_Output,'on');
    
     plot(Ha_Transfer,[Vg(ii-1) Vg(ii)],[Ig(ii-1,1) Ig(ii,1)],'-r*');
     hold(Ha_Transfer,'on');
   end
   Id_total(:,kk)=Id;
   Ig_total(:,kk)=Ig;
end

transfer_forward_scan=[Vg' Id_total Ig_total];    

value_mode=get(Hc_swp_mode,'Value');
if value_mode==1
  transfer_data=transfer_forward_scan;  
  set(Ha_Output,'XGrid','on');
  set(Ha_Output,'YGrid','on');
  set(Ha_Transfer,'XGrid','on');
  set(Ha_Transfer,'YGrid','on');
 elseif value_mode==2
  fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
  fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
for kk=1:length(Vd)
   for jj=1:V_pcycle
     fprintf(g_K2612A,['smua.source.levelv =',num2str(Vd(kk))]);
     fprintf(g_K2612A,['smub.source.levelv =',num2str(Vg_reverse(1))]);
     fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
     pause(0.5);
     fprintf(g_K2612A,'READING = smua.measure.i()');
     pause(T_delay);
     fprintf(g_K2612A,'READING = smua.measure.i()');
     fprintf(g_K2612A, 'print(READING)');
     current_string_d = fscanf(g_K2612A);
     Id_cycle(1,jj)=str2double(current_string_d);

     fprintf(g_K2612A,'READING = smub.measure.i()');
     pause(T_delay);
     fprintf(g_K2612A,'READING = smub.measure.i()');
     fprintf(g_K2612A, 'print(READING)');
     current_string_g = fscanf(g_K2612A);
     Ig_cycle(1,jj)=str2double(current_string_g);
     fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
     fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
   end
   Id_reverse(1)=sum(Id_cycle(1,V_pcycle))/V_pcycle;
   Ig_reverse(1)=sum(Ig_cycle(1,V_pcycle))/V_pcycle;
   for ii=2:length(Vg_reverse)
      pause(0.01);
      fprintf(g_K2612A,['smua.source.levelv =',num2str(Vd(kk))]);
      fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
      fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
      for jj=1:V_pcycle
          fprintf(g_K2612A,['smub.source.levelv =',num2str(Vg_reverse(ii))]);
          fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
          pause(0.01);
          fprintf(g_K2612A,'READING = smua.measure.i()');
          pause(T_delay);
          fprintf(g_K2612A,'READING = smua.measure.i()');
          fprintf(g_K2612A, 'print(READING)');
          current_string = fscanf(g_K2612A);
          Id_cycle(ii,jj)=str2double(current_string);
          fprintf(g_K2612A,'READING = smub.measure.i()');
          pause(T_delay);
          fprintf(g_K2612A,'READING = smub.measure.i()');
          fprintf(g_K2612A, 'print(READING)');
          current_string_go = fscanf(g_K2612A);
          Ig_cycle(ii,jj)=str2double(current_string_go);
          fprintf(g_K2612A,['smub.source.levelv =',num2str(V_pbias)]);
          fprintf(g_K2612A,['delay( ',num2str(V_pdelay),' )']) ; 
      end
     Id_reverse(ii)=sum(Id_cycle(ii,V_pcycle))/V_pcycle;
     Ig_reverse(ii)=sum(Ig_cycle(ii,V_pcycle))/V_pcycle;
     
     Axis_transfer_set;%调用坐标设置函数；
   
     plot(Ha_Output,[Vg_reverse(ii-1) Vg_reverse(ii)],[Id_reverse(ii-1,1) Id_reverse(ii,1)],'-g*');
     hold(Ha_Output,'on');
    
     plot(Ha_Transfer,[Vg_reverse(ii-1) Vg_reverse(ii)],[Ig_reverse(ii-1,1) Ig_reverse(ii,1)],'-g*');
     hold(Ha_Transfer,'on');
   end
   Id_total_reverse(:,kk)=Id_reverse;
   Ig_total_reverse(:,kk)=Ig_reverse;
end
transfer_reverse_scan=[Vg_reverse' Id_total_reverse Ig_total_reverse];  
transfer_data=cat(1,transfer_forward_scan,transfer_reverse_scan);
end
transfer_data_cell=num2cell(transfer_data);

Vd_start=get(Hc_vdstart,'String');
Vd_stop=get(Hc_vdstop,'String');
Vd_step=get(Hc_vdstep,'String');
curve_dis=['Transfer scan',' Vd_start:',Vd_start,' V',' Vd_stop:',Vd_stop,' V',' Vd_step:',Vd_step,' V'];
curve_dis_cell={curve_dis,'',''};

time=clock;
time_str=[num2str(time(1,1)),'-',num2str(time(1,2)),'-',num2str(time(1,3)),' ',num2str(time(1,4)),':',num2str(time(1,5)),':',num2str(fix(time(1,6)))];
time_cell={time_str,'',''};

data_dis={'Gate Voltage (V)','Drain current(A)','Leakage current (A)'};

xls_r1=cat(1,time_cell,curve_dis_cell);
xls_r2=cat(1,xls_r1,data_dis);
transfer_data_all=cat(1,xls_r2,transfer_data_cell);


%xlswrite('transfer_data.xls',transfer_data);


fprintf(g_K2612A,'smua.source.levelv =0');%将电源电压值重设为0V
fprintf(g_K2612A,'smua.source.output = smub.OUTPUT_OFF');%关闭输出
fprintf(g_K2612A,'smub.source.levelv =0');%将电源电压值重设为0V
fprintf(g_K2612A,'smub.source.output = smub.OUTPUT_OFF');%关闭输出
end
 
