display_num=get(Hc_display,'Value');
switch display_num
    case 1
       fprintf(g_Lockin,'ddef 1 {,0,0}');
       fprintf(g_Lockin,'ddef 2 {,0,0}');
    case 2
       fprintf(g_Lockin,'ddef 1 {,1,0}');
       fprintf(g_Lockin,'ddef 2 {,1,0}');
end