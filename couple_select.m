couple_num=get(Hc_couple,'Value');
switch couple_num
    case 1
        fprintf(g_Lockin,'icpl 0');
    case 2
        fprintf(g_Lockin,'icpl 1');
end 