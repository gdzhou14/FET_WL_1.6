reserve_num=get(Hc_reserve,'Value');
switch reserve_num
    case 1
        fprintf(g_Lockin,'rmod 2');
    case 2
        fprintf(g_Lockin,'rmod 1');
    case 3
        fprintf(g_Lockin,'rmod 0');
end