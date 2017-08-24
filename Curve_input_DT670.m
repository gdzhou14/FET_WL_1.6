% Find a GPIB object.
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 11, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 11);
else
    fclose(obj1);
    obj1 = obj1(1)
end
fopen(obj1);
fprintf(obj1, 'CURV?2');
data1 = fscanf(obj1);
fclose(obj1);