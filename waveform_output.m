function_num=get(Hc_function,'Value');
switch function_num
    case 1
        fprintf(g_Wgenerator,'FUNC SIN');
    case 2
        fprintf(g_Wgenerator,'FUNC SQU');
    case 3
        fprintf(g_Wgenerator,'FUNC PULS');
    end 
frequency_set=get(Hc_frequency,'String');
fprintf(g_Wgenerator,['FREQ ',frequency_set,'E+3']);
amplitude_set=get(Hc_amplitude,'String');
fprintf(g_Wgenerator,['VOLT ',amplitude_set]);
fprintf(g_Wgenerator,'OUTP ON');
set(Hp_output_on,'Foregroundcolor','b');
set(Hp_output_off,'Foregroundcolor','black');