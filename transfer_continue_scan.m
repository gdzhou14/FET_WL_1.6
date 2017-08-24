%%%%%transfer sweep%%%%%%
%initial setting
Vgt_start=str2double(get(Hc_vgstart,'String'));
Vgt_stop=str2double(get(Hc_vgstop,'String'));
Vgt_step=str2double(get(Hc_vgstep,'String'));
T_delay=str2double(get(Hc_cdelay,'String'));


Vgt_forward=Vgt_start:Vgt_step:Vgt_stop;
Vgt_reverse=Vgt_stop-Vgt_step:-Vgt_step:Vgt_start;

Vdt_start=str2double(get(Hc_vdstart,'String'));
Vdt_stop=str2double(get(Hc_vdstop,'String'));
Vdt_step=str2double(get(Hc_vdstep,'String'));
Vdt=Vdt_start:Vdt_step:Vdt_stop;

%Current
Idt_forward=zeros(length(Vgt_forward),length(Vdt));
Idt_reverse=zeros(length(Vgt_reverse),length(Vdt));
Igt_forward=zeros(length(Vgt_forward),length(Vdt));
Igt_reverse=zeros(length(Vgt_reverse),length(Vdt));

transfer_forward=zeros(length(Vgt_forward),2*length(Vdt)+1);
transfer_forward(:,1)=Vgt_forward';
transfer_reverse=zeros(length(Vgt_reverse),2*length(Vdt)+1);
transfer_reverse(:,1)=Vgt_reverse';

V_cdelay=str2double(get(Hc_cdelay,'String'));%set delay time


%initial 2612
if get(Hc_ChAcheck,'Value')==1&& get(Hc_ChBcheck,'Value')==1
Initial_set;%initial
Axis_transfer_set;%set axis£»
 %start scan
 for kk=1:length(Vdt)
fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdt(kk))]);
fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgt_forward(1))]);
fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
fprintf(g_K2612A,'READING = smua.measure.i()');
fprintf(g_K2612A, 'print(READING)');
drain_current_string = fscanf(g_K2612A);
Idt_forward(1,kk)=str2double(drain_current_string);
fprintf(g_K2612A,'READING = smub.measure.i()');
fprintf(g_K2612A, 'print(READING)');
gate_current_string = fscanf(g_K2612A);
Igt_forward(1,kk)=str2double(gate_current_string);

pause(T_delay);
%repeat first point two times

fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdt(kk))]);
fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgt_forward(1))]);
fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
fprintf(g_K2612A,'READING = smua.measure.i()');
fprintf(g_K2612A, 'print(READING)');
drain_current_string = fscanf(g_K2612A);
Idt_forward(1,kk)=str2double(drain_current_string);
fprintf(g_K2612A,'READING = smub.measure.i()');
fprintf(g_K2612A,'READING = smub.measure.i()');
fprintf(g_K2612A, 'print(READING)');
gate_current_string = fscanf(g_K2612A);
Igt_forward(1,kk)=str2double(gate_current_string);

for ii=2:length(Vgt_forward)
    fprintf(g_K2612A,['smua.source.levelv =',num2str(Vdt(kk))]);
    fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgt_forward(ii))]);
    fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
    fprintf(g_K2612A,'READING = smua.measure.i()');
    pause(0.001);
    fprintf(g_K2612A,'READING = smua.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    drain_current_string = fscanf(g_K2612A);
    Idt_forward(ii,kk)=str2double(drain_current_string);
    
    fprintf(g_K2612A,'READING = smub.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    gate_current_string = fscanf(g_K2612A);
    Igt_forward(ii,kk)=str2double(gate_current_string);
    
    Axis_transfer_set;%set axis£»

    %plotyy(Ha_Output,[Vgt_forward(ii-1) Vgt_forward(ii)],[log10(abs(Idt_forward(ii-1,1))) log10(abs(Idt_forward(ii,1)))],[Vgt_forward(ii-1) Vgt_forward(ii)],[sqrt(abs(Idt_forward(ii-1,1))) sqrt(abs(Idt_forward(ii,1)))]);
    plot(Ha_Output,[Vgt_forward(ii-1) Vgt_forward(ii)],[log10(abs(Idt_forward(ii-1,1))) log10(abs(Idt_forward(ii,1)))],'r*-');
    % plot(Ha_Output,[Vgt_forward(ii-1) Vgt_forward(ii)],[sqrt(abs(Idt_forward(ii-1,1))) sqrt(abs(Idt_forward(ii,1)))]);
    hold(Ha_Output,'on');
    
    plot(Ha_Transfer,[Vgt_forward(ii-1) Vgt_forward(ii)],[Igt_forward(ii-1,1) Igt_forward(ii,1)],'g*-');
    hold(Ha_Transfer,'on');
end
transfer_forward(:,2*kk:2*kk+1)=[Idt_forward(:,kk) Igt_forward(:,kk)];
value_mode=get(Hc_swp_mode,'Value');
if value_mode==1
  set(Ha_Output,'XGrid','on');
  set(Ha_Output,'YGrid','on');
  set(Ha_Transfer,'XGrid','on');
  set(Ha_Transfer,'YGrid','on');
 elseif value_mode==2
    fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgt_reverse(1))]);
    fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
    pause(T_delay);


    fprintf(g_K2612A,'READING = smua.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    drain_current_string = fscanf(g_K2612A);
    Idt_reverse(1,kk)=str2double(drain_current_string);


    fprintf(g_K2612A,'READING = smub.measure.i()');
    fprintf(g_K2612A, 'print(READING)');
    gate_current_string = fscanf(g_K2612A);
    Igt_reverse(1,kk)=str2double(gate_current_string);
    for ii=2:length(Vgt_reverse)
      fprintf(g_K2612A,['smub.source.levelv =',num2str(Vgt_reverse(ii))]);
      fprintf(g_K2612A,['delay( ',num2str(V_cdelay),' )']) ;
      pause(0.001);
      fprintf(g_K2612A,'READING = smua.measure.i()');
      pause(T_delay);
      fprintf(g_K2612A,'READING = smua.measure.i()');
      fprintf(g_K2612A, 'print(READING)');
      drain_current_string = fscanf(g_K2612A);
      Idt_reverse(ii,kk)=str2double(drain_current_string);
    
      fprintf(g_K2612A,'READING = smub.measure.i()');
      fprintf(g_K2612A,'READING = smub.measure.i()');
      fprintf(g_K2612A, 'print(READING)');
      gate_current_string = fscanf(g_K2612A);
      Igt_reverse(ii,kk)=str2double(gate_current_string);
    
      Axis_transfer_set;

      plot(Ha_Output,[Vgt_reverse(ii-1) Vgt_reverse(ii)],[log10(abs(Idt_reverse(ii-1,kk))) log10(abs(Idt_reverse(ii,kk)))],'g*-');
      %hold(Ha_Output,'on');
    
      plot(Ha_Transfer,[Vgt_reverse(ii-1) Vgt_reverse(ii)],[log10(abs(Igt_reverse(ii-1,kk))) log10(abs(Igt_reverse(ii,kk)))],'g*-');
     % hold(Ha_Transfer,'on');
    end
transfer_reverse(:,2*kk:2*kk+1)=[Idt_reverse(:,kk) Igt_reverse(:,kk)];    
end

end
transfer_data=cat(1,transfer_forward,transfer_reverse);
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


fprintf(g_K2612A,'smua.source.levelv =0');%set V_CHA to be 0
fprintf(g_K2612A,'smua.source.output = smua.OUTPUT_OFF');%close output
fprintf(g_K2612A,'smub.source.levelv =0');%set V_CHB to be 0
fprintf(g_K2612A,'smub.source.output = smub.OUTPUT_OFF');%clost output