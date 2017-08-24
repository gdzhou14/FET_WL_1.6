slope_num=get(Hc_slope,'Value');
switch slope_num
    case 1
        fprintf(g_Lockin,'ofsl 0');
    case 2
        fprintf(g_Lockin,'ofsl 1');
    case 3
        fprintf(g_Lockin,'ofsl 2');
    case 4
        fprintf(g_Lockin,'ofsl 3');
end 