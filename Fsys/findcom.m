% % serialInfo = instrhwinfo('serial')
% 
% key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\';
% % Find all installed USB devices entries and clean up the output
% [~, vals] = dos(['REG QUERY ' key ' /s /f "STMicroelectronics Virtual COM Port " /t "REG_SZ"']);
% vals = textscan(vals,'%s','delimiter','\t');
% vals = cat(1,vals{:});
% out = 0;
% % Find all friendly name property entries
% for i = 1:numel(vals)
%   if strcmp(vals{i}(1:min(12,end)),'STMicroelectronics Virtual COM Port ')
%       if ~iscell(out)
%           out = vals(i);
%       else
%           out{end+1} = vals{i};
%       end
%   end
% end

fcmdList={'\x05\x01' '\x05\x02' '\x06\x01' '\x06\x02' '\x01\x05\x04\x05' '\x04\x05' '\x01\x01\x04\x01' '\x01\x02\x04\x02' '\x01\x03\x04\x03' '\x01\x04\x04\x04' '\x03' '\x02'};
fcmdListN={'-0.1mm offset' '+0.1mm offset' 'Power on' 'Power off'  'Load' 'OnOff CH' 'CH1' 'CH2' 'CH3' 'CH4' 'make zero' 'filter-half'};

dev_name = 'STMicroelectronics Virtual COM Port';
[~,res]=system('wmic path Win32_SerialPort');
ind = strfind(res,dev_name);
if (~isempty(ind))
    port_name = res(ind(1)+length(dev_name)+2:ind(1)+length(dev_name)+5);
    fprintf('COM-port is %s\n',port_name);
%     try
%         port_obj = serial(port_name);
%         fopen(port_obj);
%         fprintf('%s is opened\n',port_name);
%     catch err
%         fprintf('%s\n%s\n',err.identifier,err.message);
%     end
else
    fprintf('COM-port is not find\n');
end
str1=[char(1),char(5),char(4),char(5)];

s1 = serial(port_name, 'BaudRate', 1200);
 fopen(s1);
 fprintf(s1, str1);
 fclose(s1);
 
 