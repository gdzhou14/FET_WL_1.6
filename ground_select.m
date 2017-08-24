ground_num=get(Hc_ground,'Value');
switch ground_num
    case 1
        fprintf(g_Lockin,'ignd 0');
    case 2
        fprintf(g_Lockin,'ignd 1');
end 