global tp
disp('ConnectSys');

tp = testPlatform('COM4');
tp.connect();
pause(0.5);
tp.makeZero();