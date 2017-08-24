
tr_vd__80_T300_80K=zeros(41,24);
T=290:-10:80;
tr_data=xlsread(['TG_pmma_wl10_tr_-80_T',num2str(T(1)),'K','.xls']);
tr_vd__80_T300_80K(:,[1 3])=tr_data(1:41,1:2);
for ii=2:length(T)
tr_data=xlsread(['TG_pmma_wl10_tr_-80_T',num2str(T(ii)),'K','.xls']);
tr_vd__80_T300_80K(:,ii+2)=tr_data(1:41,2);
end
xlswrite('tr_vd__80_T300_80K.xls',tr_vd__80_T300_80K);