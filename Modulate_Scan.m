%%%%%Wavelength scan%%%%%%
%≥ı ºªØ…Ë÷√
sum_x=0;
sum_y=0;
sum_r=0;
sum_d=0;
stop_light=1;
W_time=str2double(get(Hc_Wtime,'String'));
W_start=str2double(get(Hc_Wstart,'String'));
W_stop=str2double(get(Hc_Wstop,'String'));
W_step=str2double(get(Hc_Wstep,'String'));
W_return=str2double(get(Hc_Wreturn,'String'));
S_cycle=str2double(get(Hc_Scycle,'String'));
W_array=W_start:W_step:W_stop;
W_num=length(W_array);

Ix_mod_array=zeros(length(W_array),1);%moderence photocerrent density x
Iy_mod_array=zeros(length(W_array),1);%moderence photocerrent density y
Ir_mod_array=zeros(length(W_array),1);%moderence photocerrent density r
ph_mod_array=zeros(length(W_array),1);%reference phase

Delta_Ix_array=zeros(length(W_array),1);
Delta_Iy_array=zeros(length(W_array),1);

set(Ha_IW,'Color',[0.5 0.5 0.5]);
set(get(Ha_IW,'XLabel'),'String','Wavelength','FontSize',10,'FontWeight','bold');
set(get(Ha_IW,'YLabel'),'String','y','FontSize',10,'FontWeight','bold');

set(Ha_QW,'Color',[0.5 0.5 0.5]);
set(get(Ha_QW,'XLabel'),'String','Wavelength','FontSize',10,'FontWeight','bold');
set(get(Ha_QW,'YLabel'),'String','10^4\DeltaT/T','FontSize',10,'FontWeight','bold');
%scan the first wavelength
if stop_light==1
 filter_number=select_filter(W_array(1));% select filter
 set(Hc_filter_number,'String',filter_number);
 grating_select(num2str(W_array(1)));
 calllib('cs_USB','cs_Open',131);
 calllib('cs_USB','cs_Write',0,strcat(['GOWAVE ',num2str(W_array(1))],uint8(10))); 
 calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
 pause(0.2);
 calllib('cs_USB','cs_Open',514);
 calllib('cs_USB','cs_Write',1,strcat(['GOWAVE ',num2str(W_array(1))],uint8(10))); 
 calllib('cs_USB','cs_Write',1, strcat('WAVE?',uint8(10)));
 wavelength=calllib('cs_USB','cs_Read',0);
 set(Hc_val_wavelength,'String',wavelength);
 detector_select(W_array(1));
 pause(W_time);
 
 for cc=1:S_cycle
 pause(0.05);
 fprintf(g_Lockin,'outp? 1');%read lock-in value X axis
 sum_x=str2double(fscanf(g_Lockin))+sum_x;   
 pause(0.05);
 fprintf(g_Lockin,'outp? 2');%read lock-in value Y axis
 sum_y=str2double(fscanf(g_Lockin))+sum_y;
 pause(0.05);
 fprintf(g_Lockin,'outp? 3');%read lock-in value Y axis
 sum_r=str2double(fscanf(g_Lockin))+sum_r;
 pause(0.05);
 fprintf(g_Lockin,'outp? 4');
 sum_d=str2double(fscanf(g_Lockin))+sum_d;
 end
 Ix_mod_array(1)=sum_x/S_cycle;
 Iy_mod_array(1)=sum_y/S_cycle;
 Ir_mod_array(1)=sum_r/S_cycle;
 ph_mod_array(1)=sum_d/S_cycle;
 Delta_Ix_array(1)=10^4*Ix_mod_array(1)/Ix_ref_array(1)/3145.7;
 Delta_Iy_array(1)=10^4*Iy_mod_array(1)/Iy_ref_array(1)/3145.7;
end  

for ww=2:W_num
 sum_x=0;
 sum_y=0;
 sum_r=0;
 sum_d=0;
 if stop_light==1
set(Ha_IW,'Color',[0.5 0.5 0.5]);
set(get(Ha_IW,'XLabel'),'String','Wavelength','FontSize',10,'FontWeight','bold');
set(get(Ha_IW,'YLabel'),'String','y','FontSize',10,'FontWeight','bold');

set(Ha_QW,'Color',[0.5 0.5 0.5]);
set(get(Ha_QW,'XLabel'),'String','Wavelength','FontSize',10,'FontWeight','bold');
set(get(Ha_QW,'YLabel'),'String','10^4\DeltaT/T','FontSize',10,'FontWeight','bold');

  filter_number=select_filter(W_array(ww));% select filter
  set(Hc_filter_number,'String',filter_number);
  grating_select(num2str(W_array(ww)));
  calllib('cs_USB','cs_Open',131);
  calllib('cs_USB','cs_Write',0,strcat(['GOWAVE ',num2str(W_array(ww))],uint8(10))); 
  calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
  wavelength=calllib('cs_USB','cs_Read',0);
  pause(0.2);
  calllib('cs_USB','cs_Open',514);
  calllib('cs_USB','cs_Write',1,strcat(['GOWAVE ',num2str(W_array(ww))],uint8(10))); 
  calllib('cs_USB','cs_Write',1, strcat('WAVE?',uint8(10)));  set(Hc_val_wavelength,'String',wavelength);
  detector_select(W_array(ww));
  pause(W_time);
  for cc=1:S_cycle
   pause(0.05);
   fprintf(g_Lockin,'outp? 1');%read lock-in value X axis
   sum_x=str2double(fscanf(g_Lockin))+sum_x;   
   pause(0.05);
   fprintf(g_Lockin,'outp? 2');%read lock-in value Y axis
   sum_y=str2double(fscanf(g_Lockin))+sum_y;
   pause(0.05);
   fprintf(g_Lockin,'outp? 3');%read lock-in value Y axis
   sum_r=str2double(fscanf(g_Lockin))+sum_r;
   pause(0.05);
   fprintf(g_Lockin,'outp? 4');
   sum_d=str2double(fscanf(g_Lockin))+sum_d;
  end
 Ix_mod_array(ww)=sum_x/S_cycle;
 Iy_mod_array(ww)=sum_y/S_cycle;
 Ir_mod_array(ww)=sum_r/S_cycle;
 ph_mod_array(ww)=sum_d/S_cycle;
 Delta_Ix_array(ww)=10^4*Ix_mod_array(ww)/Ix_ref_array(ww)/3145.7;
 Delta_Iy_array(ww)=10^4*Iy_mod_array(ww)/Iy_ref_array(ww)/3145.7;

  %plot(Ha_QW,[W_array(ww-1) W_array(ww)],[Delta_Ix_array(ww-1) Delta_Ix_array(ww)],'-r*',[W_array(ww-1) W_array(ww)],[Delta_Iy_array(ww-1) Delta_Iy_array(ww)],'-bo');
  plot(Ha_IW,[W_array(ww-1) W_array(ww)],[Iy_mod_array(ww-1) Iy_mod_array(ww)],'-r*');
  plot(Ha_QW,[W_array(ww-1) W_array(ww)],[Delta_Ix_array(ww-1) Delta_Ix_array(ww)],'-r*',[W_array(ww-1) W_array(ww)],[Delta_Iy_array(ww-1) Delta_Iy_array(ww)],'-bo');
  hold(Ha_QW,'on');
  hold(Ha_IW,'on');
  end
end
if stop_light==0
 grating_select(num2str(W_return));
 calllib('cs_USB','cs_Open',131);
 calllib('cs_USB','cs_Write',0,strcat(['GOWAVE ',num2str(W_return)],uint8(10))); 
 calllib('cs_USB','cs_Write',0, strcat('WAVE?',uint8(10)));
 wavelength=calllib('cs_USB','cs_Read',0);
 pause(0.2);
 calllib('cs_USB','cs_Open',514);
 calllib('cs_USB','cs_Write',1,strcat(['GOWAVE ',num2str(W_return)],uint8(10))); 
 calllib('cs_USB','cs_Write',1, strcat('WAVE?',uint8(10)));
 set(Hc_val_wavelength,'String',wavelength);
end
mod_total=[W_array' Ix_mod_array Iy_mod_array Ir_mod_array ph_mod_array Delta_Ix_array Delta_Iy_array];
trans_total=[W_array' Ix_ref_array Iy_ref_array Ir_ref_array ph_ref_array Ix_mod_array Iy_mod_array Ir_mod_array ph_mod_array];
dlmwrite('mod_data.dat',mod_total);%save reference current
dlmwrite('trans_data.dat',trans_total);%save reference current
