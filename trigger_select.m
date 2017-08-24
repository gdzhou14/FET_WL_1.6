ref_trigger_num=get(Hc_ref_trigger,'Value');
switch ref_trigger_num
    case 1
    fprintf(g_Lockin,'rslp 0');
    case 2
    fprintf(g_Lockin,'rslp 1');
    case 3
    fprintf(g_Lockin,'rslp 2');
end 