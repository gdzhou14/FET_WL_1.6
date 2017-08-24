 fprintf(g_K2612A,'reset()');%重置2612A
 %channel b
 fprintf(g_K2612A,'smua.source.func = smua.OUTPUT_DCVOLTS');%设置电压源
 fprintf(g_K2612A,'smua.source.levelv =0');%初始化电源电压值
 fprintf(g_K2612A,'smua.source.autorangei = smua.AUTORANGE_ON');%设置电流限制
 fprintf(g_K2612A,'smua.measure.autorangei = smua.AUTORANGE_ON');%%%%%%%设置测试电流范围%%%%%
 fprintf(g_K2612A,'smua.source.output = smua.OUTPUT_ON');%测试前打开输出
 
 fprintf(g_K2612A,'smub.source.func = smub.OUTPUT_DCVOLTS');%设置电压源
 fprintf(g_K2612A,'smub.source.levelv =0');%初始化电源电压值
 fprintf(g_K2612A,'smub.source.autorangei = smub.AUTORANGE_ON');%设置电流限制
 fprintf(g_K2612A,'smub.measure.autorangei = smub.AUTORANGE_ON');
 fprintf(g_K2612A,'smub.source.output = smub.OUTPUT_ON');%测试前打开输出