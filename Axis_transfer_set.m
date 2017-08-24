 %设置坐标参数
 set(Ha_Output,'Color',[0.5 0.5 0.5]);
 set(get(Ha_Output,'Title'),'String','Transfer Characteristics','FontSize',10,'FontWeight','bold');
 set(get(Ha_Output,'XLabel'),'String','Vgs [V]','FontSize',10,'FontWeight','bold');
 set(get(Ha_Output,'YLabel'),'String','Ids [A]','FontSize',10,'FontWeight','bold');
 
 set(Ha_Transfer,'Color',[0.5 0.5 0.5]);
 set(get(Ha_Transfer,'Title'),'String','Gate Leakage current','FontSize',10,'FontWeight','bold');
 set(get(Ha_Transfer,'XLabel'),'String','Vgs [V]','FontSize',10,'FontWeight','bold');
 set(get(Ha_Transfer,'YLabel'),'String','Ig[A]','FontSize',10,'FontWeight','bold');