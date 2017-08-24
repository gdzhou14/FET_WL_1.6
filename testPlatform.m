classdef testPlatform
    properties
        PortNum;
        Port;
    end

    methods
        function tp = testPlatform(port)
            tp.PortNum = port;
            tp.Port = serial(tp.PortNum);
            set(tp.Port,'BaudRate', 115200,'DataBits',8,'StopBits',1,'Parity','none','FlowControl','none');
            fopen(tp.Port);
            pause(0.1);
        end
    end

    methods
        function connect(obj)
            fprintf(obj.Port,[char(6),char(1)],'async');
            pause(0.1);
        end

        function makeZero(obj)
            fprintf(obj.Port,[char(3)],'async');
            pause(0.1);
        end

        function changeToChannel(obj,channel)
            fprintf(obj.Port,[char(1),char(channel)],'async');
            pause(0.1);
            fprintf(obj.Port,[char(4),char(channel)],'async');
            pause(2);
        end

        function setFilter(obj,filterstatus)
            switch filterstatus
            case 0
                fprintf(obj.Port,[char(2),char(0)],'async');
                pause(1.5);
                return;
            case 1
                fprintf(obj.Port,[char(2),char(1)],'async');
                pause(1.5);
                return;
            case 2
                fprintf(obj.Port,[char(2),char(2)],'async');
                pause(1.5);
                return;
            case 3
                fprintf(obj.Port,[char(2),char(4)],'async');
                pause(1.5);
                return;
            case 4
                fprintf(obj.Port,[char(2),char(5)],'async');
                pause(1.5);
                return;
            case 5
                fprintf(obj.Port,[char(2),char(6)],'async');
                pause(1.5);
                return;
            case 6
                fprintf(obj.Port,[char(2),char(7)],'async');
                pause(1.5);
                return;
            end
        end
    end

    
    
end