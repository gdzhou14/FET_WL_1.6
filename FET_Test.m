close;clear;clc;
%定义控制界面
Hf=figure('Units','characters',...
          'MenuBar','none',...
          'Name','FET Test System',...
          'NumberTitle','off',...
          'Position',[10 5 180 45],...
          'HandleVisibility','callback');


%electric label 
Hme=uimenu(Hf,'Label','Instruments');
Hme1=uimenu(Hme,'Label','Connect');
Hme2=uimenu(Hme,'Label','DisConnect');


%open electric instruments 


uimenu(Hme1,'Label','IV_test(K2612A)',...  
    'Callback','open_K2612A');%open K2612A
uimenu(Hme1,'Label','Spectrograph & Monochromator',...
    'Callback','Open_spectrograph');

%close electric instruments 

uimenu(Hme2,'Label','IV_test(K2612A)',...
    'Callback','fclose(g_K2612A);delete(g_K2612A);clear g_K2612A;set(Hp_iv,''Foregroundcolor'',''k'');');%close K2612A

uimenu(Hme2,'Label','Spectrograph & Monochromator',...
    'Callback','Close_spectrograph');
%定义坐标:坐标标题,坐标标签
Ha_Output=axes(...
          'Parent',Hf,...
          'Units','normalized',...
          'Position',[0.6 0.57 0.37 0.38],...
          'Box','on' ); 
set(get(Ha_Output,'Title'),'String','Output Characteristics','FontSize',10,'FontWeight','bold');
set(get(Ha_Output,'XLabel'),'String','Vds [V]','FontSize',10,'FontWeight','bold','Position',[0.5 -0.08]);
set(get(Ha_Output,'YLabel'),'String','Ids [A]','FontSize',10,'FontWeight','bold');

Ha_Transfer=axes(...
          'Parent',Hf,...
          'Units','normalized',...
          'Position',[0.6 0.09 0.37 0.38],...
          'Box','on' );     
set(get(Ha_Transfer,'Title'),'String','Transfer Characteristics','FontSize',10,'FontWeight','bold');
set(get(Ha_Transfer,'XLabel'),'String','Vgs [V]','FontSize',10,'FontWeight','bold','Position',[0.5 -0.08]);
set(get(Ha_Transfer,'YLabel'),'String','log10(abs(Ids)) [A]','FontSize',10,'FontWeight','bold');

%定义版权面板
uicontrol(Hf,...
          'Units','normalized',...
          'BackgroundColor',get(Hf,'Color'),...
          'Position',[0.1 0.03 0.50 0.03],...
          'String','Copyright 2011, Electrinic Engineering, CUHK. Designed by Haihua Xu.',...
          'Style','text' ); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%Keithley 2612A%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Hp_iv=uipanel(Hf,...
          'Units','normalized',...
          'BackgroundColor',[0.85 0.85 0.85],...
          'Title','FET_Wavelength',...
          'TitlePosition','centertop',...
          'Clipping','on',...
          'FontWeight','bold',...
          'FontSize',11,...
          'ForegroundColor',[0 0 0],...
          'Position',[0.02 0.08  0.52 0.92]);
      
 

%通道选择
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Position',[0.22 0.915 0.3 0.08],...
          'HorizontalAlignment','left',...
          'String','Channel Select',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'FontWeight','bold',...
          'Style','text');
Hc_ChAcheck=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.46 0.95 0.3 0.06],...
          'String','Channel A',...
          'FontWeight','bold',...
          'FontSize',8,...
          'Value',1,...
          'Style','checkbox');
Hc_ChBcheck=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.63 0.95 0.2 0.06],...
          'String','Channel B',...
          'FontWeight','bold',...
          'FontSize',8,...
          'Value',1,...
          'Style','checkbox');

%扫描模式选择
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.865 0.3 0.08],...
          'String','Sweep Mode',...
          'ForegroundColor',[0 0 1],...
          'FontSize',10,...
          'FontWeight','bold',...
          'Style','text');
sweep_mode_n=1;
Hc_swp_mode=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'Position',[0.23 0.855 0.15 0.1],...
          'HorizontalAlignment','center',...
          'String',{'Single','Double'},...
          'FontWeight','bold',...
          'Value',sweep_mode_n,...
          'Style','popupmenu');
      
      
 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.45 0.87 0.3 0.08],...
          'String','Sweep_Select',...
          'ForegroundColor',[0 0 1],...
          'FontSize',10,...
          'FontWeight','bold',...
          'Style','text');      
sweep_select_n=1;
Hc_swp_select=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'Position',[0.7 0.855 0.16 0.1],...
          'HorizontalAlignment','center',...
          'String',{'Continue','Pulse'},...
          'FontWeight','bold',...
          'Value',sweep_select_n,...
          'Style','popupmenu');
     
% 连续扫描
Hc_Csweepstatus=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.76 0.40 0.12],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Continue Sweep',...
          'Style','text' );
 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.37 0.75 0.25 0.16],...
          'FontWeight','bold',...
          'String','Delay (s)',...
          'Style','text' );
Hc_cdelay=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.36 0.84 0.1 0.04],...
          'String','0.1',...
          'Style','edit' );

 
%%%脉冲扫描
Hc_Psweepstatus=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.64 0.40 0.16],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Pulse Sweep',...
          'Style','text' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.22 0.67 0.25 0.16],...
          'FontWeight','bold',...
          'String','Bias (V)',...
          'Style','text' );
Hc_pbias=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.22 0.76 0.1 0.04],...
          'String','0',...
          'Style','edit' );

uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.34 0.67 0.25 0.16],...
          'FontWeight','bold',...
          'String','Delay (s)',...
          'Style','text' );
Hc_pdelay=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.34 0.76 0.1 0.04],...
          'String','2',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.45 0.67 0.25 0.16],...
          'FontWeight','bold',...
          'String','Period (s)',...
          'Style','text' );
Hc_v_pulse_period=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.46 0.76 0.1 0.04],...
          'String','1',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.58 0.67 0.25 0.16],...
          'FontWeight','bold',...
          'String','Width (s)',...
          'Style','text' );
Hc_v_pulse_width=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.58 0.76 0.1 0.04],...
          'String','0.1',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.71 0.67 0.16 0.16],...
          'FontWeight','bold',...
          'String','Cycles',...
          'Style','text' );
Hc_v_cycle=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.71 0.76 0.1 0.04],...
          'String','2',...
          'Style','edit' );
      
%%%%%%%output Characteristics%%%%%%
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.3 0.65 0.45 0.1],...
          'String','Output Characteristics',...
          'ForegroundColor',[1 0.2 0.2],...
          'FontSize',11,...
          'FontWeight','bold',...
          'Style','text');
% Vgate setup
Hc_Pstatus=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.52 0.40 0.16],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Gate Voltage',...
          'Style','text' );

uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.27 0.55 0.30 0.16],...
          'FontWeight','bold',...
          'String','Start (V)',...
          'Style','text' );
Hc_vgostart=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.26 0.64 0.12 0.04],...
          'String','0',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.45 0.55 0.30 0.16],...
          'FontWeight','bold',...
          'String','Stop (V)',...
          'Style','text' );
      
Hc_vgostop=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.44 0.64 0.12 0.04],...
          'String','0',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.63 0.55 0.30 0.16],...
          'FontWeight','bold',...
          'String','Step (V)',...
          'Style','text' );
Hc_vgostep=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.62 0.64 0.12 0.04],...
          'String','-1',...
          'Style','edit' );

%Vdrain setup
Hc_Pstatus=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.46 0.40 0.16],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Drain Voltage',...
          'Style','text' );
Hc_vdostart=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.26 0.58 0.12 0.04],...
          'String','5',...
          'Style','edit' );     
Hc_vdostop=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.44 0.58 0.12 0.04],...
          'String','-5',...
          'Style','edit' );
Hc_vdostep=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.62 0.58 0.12 0.04],...
          'String','-1',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','cla(Ha_Output);cla(Ha_Transfer);Output_scan',...
          'Position',[0.83 0.61 0.15 0.06],...
          'String','Start',...
          'FontWeight','bold',...
           'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'Style','pushbutton' );

%保存文件      



 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','save_output',...
          'Position',[0.3 0.52 0.23 0.05],...
          'Fontsize',10,...
          'String','Output_save',...
          'FontWeight','bold',...
          'Style','pushbutton' );
 %终止扫描
 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','stop_iv',...
          'Position',[0.82 0.52 0.12 0.05],...
          'String','Stop',...
          'FontWeight','bold',...
          'Value',1,...
          'ForegroundColor',[0 0 0],... 
          'Style','pushbutton');      
%%%%%%end output characteristic%%%%%%%%%%%

%%%%%%%transfer characteristics  %%%%%%%
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.3 0.41 0.45 0.1],...
          'String','Transfer Characteristics',...
          'ForegroundColor',[1 0.2 0.2],...
          'FontSize',11,...
          'FontWeight','bold',...
          'Style','text');
% Vgate setup
Hc_Pstatus=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.28 0.40 0.16],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Gate Voltage',...
          'Style','text' );

uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.27 0.31 0.30 0.16],...
          'FontWeight','bold',...
          'String','Start (V)',...
          'Style','text' );
Hc_vgstart=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.26 0.4 0.12 0.04],...
          'String','15',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.45 0.31 0.30 0.16],...
          'FontWeight','bold',...
          'String','Stop (V)',...
          'Style','text' );
      
Hc_vgstop=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.44 0.4 0.12 0.04],...
          'String','-25',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.63 0.31 0.30 0.16],...
          'FontWeight','bold',...
          'String','Step (V)',...
          'Style','text' );
Hc_vgstep=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.62 0.4 0.12 0.04],...
          'String','-1',...
          'Style','edit' );

%Vdrain setup
Hc_Pstatus=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.21 0.40 0.16],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Drain Voltage',...
          'Style','text' );
Hc_vdstart=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.26 0.34 0.12 0.04],...
          'String','-5',...
          'Style','edit' );     
Hc_vdstop=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.44 0.34 0.12 0.04],...
          'String','-5',...
          'Style','edit' );
Hc_vdstep=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.62 0.34 0.12 0.04],...
          'String','1',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','cla(Ha_Output),cla(Ha_Transfer);Transfer_scan',...
          'Position',[0.83 0.36 0.15 0.06],...
          'String','Start',...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'Style','pushbutton' );    

 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','save_transfer',...
          'Position',[0.3 0.27 0.23 0.05],...
          'Fontsize',10,...
          'String','Transfer_save',...
          'FontWeight','bold',...
          'Style','pushbutton' );

 %终止扫描
 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','stop_iv',...
          'Position',[0.82 0.27 0.12 0.05],...
          'String','Stop',...
          'FontWeight','bold',...
          'Value',1,...
          'ForegroundColor',[0 0 0],... 
          'Style','pushbutton');
      
%%%%%%%Stress measurement%%%%%%
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.3 0.17 0.45 0.1],...
          'String','Stress Measurement',...
          'ForegroundColor',[1 0.2 0.2],...
          'FontSize',11,...
          'FontWeight','bold',...
          'Style','text');
Hc_stress_gate_high=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.01 0.185 0.25 0.04],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Vg_Hi( V )',...
          'Style','text' );
Hc_stress_gate_high_level=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.145 0.19 0.08 0.04],...
          'String','-55',...
          'Style','edit' );  
           
Hc_stress_gate_low=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.23 0.185 0.27 0.04],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Vg_Lo( V )',...
          'Style','text' );
Hc_stress_gate_low_level=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.38 0.19 0.08 0.04],...
          'String','-65',...
          'Style','edit' );  
Hc_stress_cycle_status=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.46 0.185 0.27 0.04],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','Cycle(s)',...
          'Style','text' );
Hc_stress_cycle_time=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.565 0.19 0.08 0.04],...
          'String','0.2',...
          'Style','edit' );       
      
Hc_stress_hour_status=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Foregroundcolor','k',...
          'HorizontalAlignment','left',...
          'Position',[0.65 0.185 0.1 0.04],...
          'FontWeight','bold',...
          'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'String','10_Min',...
          'Style','text' );
Hc_stress_hours=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.78 0.19 0.08 0.04],...
          'String','120',...
          'Style','edit' ); 

uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','Stress_scan',...
          'Position',[0.89 0.19 0.1 0.04],...
          'String','Start',...
          'FontWeight','bold',...
           'FontSize',10,...
          'ForegroundColor',[0 0 1],...
          'Style','pushbutton' );

 
%%%%wavelength      
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.115 0.12 0.04],...
          'FontWeight','bold',...
          'String','Start (nm)',...
          'Style','text' );
Hc_Wstart=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.14 0.12 0.12 0.04],...
          'String','400',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.26 0.115 0.12 0.04],...
          'FontWeight','bold',...
          'String','Stop (nm)',...
          'Style','text' );
      
Hc_Wstop=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.38 0.12 0.12 0.04],...
          'String','1100',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.5 0.115 0.12 0.04],...
          'FontWeight','bold',...
          'String','Step (nm)',...
          'Style','text' );
Hc_Wstep=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.62 0.12 0.12 0.04],...
          'String','10',... 
          'Style','edit' );
 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.75 0.115 0.12 0.04],...
          'FontWeight','bold',...
          'String','Wait(s)',...
          'Style','text' );  
Hc_Wtime=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.84 0.12 0.12 0.04],...
          'String','180',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.06 0.2 0.04],...
          'FontWeight','bold',...
          'String','Return to (nm)',...
          'Style','text' );  
Hc_Wreturn=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.22 0.07 0.12 0.04],...
          'String','500',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','Return_to',...
          'Position',[0.38 0.07 0.12 0.04],...
          'String','Return',...
          'FontSize',9,...
          'FontWeight','bold',...
          'Style','pushbutton' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','Stop_wavelength_scan',...
          'Position',[0.53 0.07 0.12 0.04],...
          'String','Stop',...
          'FontWeight','bold',...
          'FontSize',9,...
          'Style','pushbutton' );

 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','FET_wl_scan',...
          'Position',[0.68 0.07 0.15 0.04],...
          'String','WL_Scan',...
          'FontWeight','bold',...
          'FontSize',9,...
          'Style','pushbutton' );


uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.02 0.015 0.12 0.04],...
          'FontWeight','bold',...
          'String','Step(min)',...
          'Style','text' );
Hc_Tstep=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.15 0.02 0.1 0.04],...
          'String','2',...
          'Style','edit' );
uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'HorizontalAlignment','left',...
          'Position',[0.28 0.015 0.12 0.04],...
          'FontWeight','bold',...
          'String','Cycles',...
          'Style','text' );
Hc_Tcycle=uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',[1 1 1],...
          'HorizontalAlignment','center',...
          'Position',[0.38 0.02 0.1 0.04],...
          'String','10',...
          'Style','edit' );

 uicontrol(Hp_iv,...
          'Units','normalized',...
          'BackgroundColor',get(Hp_iv,'BackgroundColor'),...
          'Callback','Time_scan',...
          'Position',[0.58 0.02 0.15 0.04],...
          'String','Time_Scan',...
          'FontWeight','bold',...
          'FontSize',9,...
          'Style','pushbutton' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%End Keithley 2612A%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
      

