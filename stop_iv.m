stop_yes=1;
fprintf(g_K2612A,'smua.source.levelv =0');%将电源电压值重设为0V
fprintf(g_K2612A,'smua.source.output = smua.OUTPUT_OFF');%关闭输出
fprintf(g_K2612A,'smub.source.levelv =0');%将电源电压值重设为0V
fprintf(g_K2612A,'smub.source.output = smub.OUTPUT_OFF');%关闭输出
fclose(g_K2612A);
set(Hp_iv,'Foregroundcolor','k');
clc;