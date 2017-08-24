function [returnval]=Simple();
calllib('cs_USB','cs_Open',0);
calllib('cs_USB','cs_Write',0,strcat('OUTPORT 2',uint8(10)));
calllib('cs_USB','cs_Write',0, strcat('OUTPORT?',uint8(10)));
returnval=calllib('cs_USB','cs_Read',0);
calllib('cs_USB','cs_Close',0);

