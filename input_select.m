input_num=get(Hc_input,'Value');
switch input_num
    case 1
        fprintf(g_Lockin,'isrc 0');
    case 2
        fprintf(g_Lockin,'isrc 1');
    case 3
        fprintf(g_Lockin,'isrc 2');
    case 4
        fprintf(g_Lockin,'isrc 3');
end 