disp('Transfer_scanA');
disp('continue mode');

global fileNtemp sheetN filePre


for ji=1:4
    for jk=0:6
        sheetN=num2str(10*ji+jk)
        fileNtemp=[get(filePre,'string'),sheetN]
        pause(0.5);
        
    end
end


