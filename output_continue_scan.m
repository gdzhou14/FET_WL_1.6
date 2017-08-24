%%%%%Output sweep%%%%%%
%初始化设置
Vgo_start=str2double(get(Hc_vgostart,'String'));
Vgo_stop=str2double(get(Hc_vgostop,'String'));
Vgo_step=str2double(get(Hc_vgostep,'String'));
T_delay=str2double(get(Hc_cdelay,'String'));
Vgo=Vgo_start:Vgo_step:Vgo_stop;

Vdo_start=str2double(get(Hc_vdostart,'String'));
Vdo_stop=str2double(get(Hc_vdostop,'String'));
Vdo_step=str2double(get(Hc_vdostep,'String'));
Vdo_forward=Vdo_start:Vdo_step:Vdo_stop;
Vdo_reverse=Vdo_stop-Vdo_step:-Vdo_step:Vdo_start;%反向扫描

Ido_forward=zeros(length(Vdo_forward),length(Vgo));
Ido_reverse=zeros(length(Vdo_reverse),length(Vgo));
Igo_forward=zeros(length(Vdo_forward),length(Vgo));
Igo_reverse=zeros(length(Vdo_reverse),length(Vgo));
output_forward=zeros(length(Vdo_forward),2*length(Vgo)+1);
output_forward(:,1)=Vdo_forward';
output_reverse=zeros(length(Vdo_reverse),2*length(Vgo)+1);
output_reverse(:,1)=Vdo_reverse';

V_cdelay=str2double(get(Hc_cdelay,'String'));%设置连续延时时间


%初始化仪器
if get(Hc_ChAcheck,'Value')==1&& get(Hc_ChBcheck,'Value')==1
    Initial_set;%调用初始化函数；
    Axis_output_set;%调用坐标设置函数；
%开始扫描
for kkk=1:length(Vgo)
 fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo_forward(1))]);
 fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgo(kkk))]);
 fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
 fprintf(g_K2612A,'READING = smua.measure.i()');
 fprintf(g_K2612A, 'print(READING)');
 current_string_do = fscanf(g_K2612A);
 Ido_forward(1,kkk)=str2double(current_string_do);
 fprintf(g_K2612A,'READING = smub.measure.i()');
 fprintf(g_K2612A, 'print(READING)');
 current_string_go = fscanf(g_K2612A);
 Igo_forward(1,kkk)=str2double(current_string_go);
 
 pause(T_delay);
  
 fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo_forward(1))]);
 fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgo(kkk))]);
 fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
 fprintf(g_K2612A,'READING = smua.measure.i()');
 fprintf(g_K2612A, 'print(READING)');
 current_string_do = fscanf(g_K2612A);
 Ido_forward(1,kkk)=str2double(current_string_do);
 fprintf(g_K2612A,'READING = smub.measure.i()');
 fprintf(g_K2612A, 'print(READING)');
 current_string_go = fscanf(g_K2612A);
 Igo_forward(1,kkk)=str2double(current_string_go);

 for iii=2:length(Vdo_forward)
    fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo_forward(iii))]);
    fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
    pause(0.01);
    fprintf(g_K2612A,'READING = smua.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    current_string = fscanf(g_K2612A);
    Ido_forward(iii,kkk)=str2double(current_string);
    
    fprintf(g_K2612A,'READING = smub.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    current_string_go = fscanf(g_K2612A);
    Igo_forward(iii,kkk)=str2double(current_string_go);
    Axis_output_set;%调用坐标设置函数；
    plot(Ha_Output,[Vdo_forward(iii-1) Vdo_forward(iii)],[Ido_forward(iii-1,kkk) Ido_forward(iii,kkk)],'r*-');
    hold(Ha_Output,'on');
    plot(Ha_Transfer,[Vdo_forward(iii-1) Vdo_forward(iii)],[Igo_forward(iii-1,kkk) Igo_forward(iii,kkk)],'r*-');
    hold(Ha_Transfer,'on');
  end
  output_forward(:,2*kkk:2*kkk+1)=[Ido_forward(:,kkk) Igo_forward(:,kkk)];
  value_mode=get(Hc_swp_mode,'Value');
  if value_mode==1
       set(Ha_Output,'XGrid','on');
       set(Ha_Output,'YGrid','on');
       set(Ha_Transfer,'XGrid','on');
       set(Ha_Transfer,'YGrid','on');
  elseif value_mode==2
  fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo_reverse(1))]);
  fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
  pause(V_cdelay);
  fprintf(g_K2612A,'READING = smua.measure.i()');
  pause(T_delay);
  fprintf(g_K2612A,'READING = smua.measure.i()');
  fprintf(g_K2612A, 'print(READING)');
  current_string_do = fscanf(g_K2612A);
  Ido_reverse(1,kkk)=str2double(current_string_do);
  fprintf(g_K2612A,'READING = smub.measure.i()');
  pause(T_delay);
  fprintf(g_K2612A,'READING = smub.measure.i()');
  fprintf(g_K2612A, 'print(READING)');
  current_string_go = fscanf(g_K2612A);
  Igo_reverse(1,kkk)=str2double(current_string_go);
  for iii=2:length(Vdo_reverse)
    fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdo_reverse(iii))]);
    fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
    pause(0.01);
    fprintf(g_K2612A,'READING = smua.measure.i()');
    pause(T_delay);
    fprintf(g_K2612A,'READING = smua.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    current_string = fscanf(g_K2612A);
    Ido_reverse(iii,kkk)=str2double(current_string);
    fprintf(g_K2612A,'READING = smub.measure.i()');
    pause(T_delay);
    fprintf(g_K2612A,'READING = smub.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    current_string_go = fscanf(g_K2612A);
    Igo_reverse(iii,kkk)=str2double(current_string_go);
    
    Axis_output_set;%调用坐标设置函数；
   
    plot(Ha_Output,[Vdo_reverse(iii-1) Vdo_reverse(iii)],[Ido_reverse(iii-1,kkk) Ido_reverse(iii,kkk)],'g*-');
    hold(Ha_Output,'on');
    plot(Ha_Transfer,[Vdo_reverse(iii-1) Vdo_reverse(iii)],[Igo_reverse(iii-1,kkk) Igo_reverse(iii,kkk)],'g*-');
    hold(Ha_Transfer,'on');
  end
  output_reverse(:,2*kkk:2*kkk+1)=[Ido_reverse(:,kkk) Igo_reverse(:,kkk)];
  end
end
output_data=cat(1,output_forward,output_reverse);
end

fprintf(g_K2612A,'smua.source.levelv =0');%将电源电压值重设为0V
fprintf(g_K2612A,'smua.source.output = smua.OUTPUT_OFF');%关闭输出
fprintf(g_K2612A,'smub.source.levelv =0');%将电源电压值重设为0V
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




