ref_source_num=get(Hc_ref_source,'Value');
switch ref_source_num
    case 1
    fprintf(g_Lockin,'fmod 1');
    case 2
    fprintf(g_Lockin,'fmod 0');
end 