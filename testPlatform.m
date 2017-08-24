classdef testPlatform
    properties
        PortNum;
        Port;
    end

    methods
        function obj = testPlatform(port)
            obj.PortNum = port;
        end
    end

    methods
        function connect(obj)
            obj.Port = serial(obj.PortNum);
            set(obj.Port,'BaudRate', 115200,'DataBits',8,'StopBits',1,'Parity','none','FlowControl','none');
            fopen(obj.Port);
            pause(0.1);
            fprintf(obj.Port,[char(6),char(1)],'async');
        end

        function makeZero(obj)
            fprintf(obj.Port,[char(3)],'async');
        end

        function changeToChannel(obj,channel)
            fprintf(obj.Port,[char(1),char(channel)],'async');
            pause(0.1)
            fprintf(obj.Port,[char(4),char(channel)],'async');
            pause(2)
        end

        function setFilter(obj,filterstatus)
            switch filterstatus
            case 0
                fprintf(obj.Port,[char(2),char(0)],'async');
                break;
            case 1
                fprintf(obj.Port,[char(2),char(1)],'async');
                break;
            case 2
                fprintf(obj.Port,[char(2),char(2)],'async');
                break;
            case 3
                fprintf(obj.Port,[char(2),char(4)],'async');
                break;
            case 4
                fprintf(obj.Port,[char(2),char(5)],'async');
                break;
            case 5
                fprintf(obj.Port,[char(2),char(6)],'async');
                break;
            case 6
                fprintf(obj.Port,[char(2),char(7)],'async');
                break;
            end
            pause(1.5)
        end
    end

    
    
end