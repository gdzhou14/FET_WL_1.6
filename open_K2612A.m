g_K2612A=instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 26, 'Tag', '');
if isempty(g_K2612A)
    g_K2612A = gpib('CONTEC', 0, 26);
else
    fclose(g_K2612A);
    g_K2612A = g_K2612A(1);
end
fopen(g_K2612A);
set(Hp_iv,'Foregroundcolor','r');   