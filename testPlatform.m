classdef testPlatform
    properties
        PortNum;
        Port;
    end

    methods
        function testPlatform(port)
            PortNum = port;
        end
    end

    methods
        function connect()
            Port = serial(PortNum);
            set(s,'BaudRate', 115200,'DataBits',8,'StopBits',1,'Parity','none','FlowControl','none');
            fopen(Port);
            pause(0.1);
            fprintf(Port,[char(6),char(1)],'async');
        end

        function makeZero()
            fprintf(Port,[char(3)],'async');
        end

        function changeToChannel(channel)
            fprintf(Port,[char(1),char(channel)],'async');
            pause(0.1)
            fprintf(Port,[char(4),char(channel)],'async');
            pause(2)
        end

        function setFilter(filterstatus)
            switch filterstatus
            case 0
                fprintf(Port,[char(2),char(0)],'async');
                break;
            case 1
                fprintf(Port,[char(2),char(1)],'async');
                break;
            case 2
                fprintf(Port,[char(2),char(2)],'async');
                break;
            case 3
                fprintf(Port,[char(2),char(4)],'async');
                break;
            case 4
                fprintf(Port,[char(2),char(5)],'async');
                break;
            case 5
                fprintf(Port,[char(2),char(6)],'async');
                break;
            case 6
                fprintf(Port,[char(2),char(7)],'async');
                break;
            end
            pause(1.5)
        end
    end

    
    
end