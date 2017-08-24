classdef testPlatform
    properties
        PortNum;
        Port;
    end

    methods
<<<<<<< HEAD
        function obj = testPlatform(port)
=======
<<<<<<< HEAD
        function tp = testPlatform(port)
            tp.PortNum = port;
            tp.Port = serial(tp.PortNum)
            set(tp.Port,'BaudRate', 115200,'DataBits',8,'StopBits',1,'Parity','none','FlowControl','none')
            
            fopen(tp.Port);
            pause(0.1);
=======
        function testPlatform(obj,port)
>>>>>>> cad3d986a5645c4c1120630c0e88f2a6262f93d1
            obj.PortNum = port;
>>>>>>> 102ac411a8250c02c8dca5fb53a502da169a1f77
        end
    end

    methods
        function connect(obj)
<<<<<<< HEAD
            
            
=======
            obj.Port = serial(obj.PortNum);
            set(obj.Port,'BaudRate', 115200,'DataBits',8,'StopBits',1,'Parity','none','FlowControl','none');
            fopen(obj.Port);
            pause(0.1);
>>>>>>> 102ac411a8250c02c8dca5fb53a502da169a1f77
            fprintf(obj.Port,[char(6),char(1)],'async');
        end

        function makeZero(obj)
<<<<<<< HEAD
            obj
            fprintf(obj.Port,char(3),'async');
=======
            fprintf(obj.Port,[char(3)],'async');
>>>>>>> 102ac411a8250c02c8dca5fb53a502da169a1f77
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
<<<<<<< HEAD
                return;
=======
<<<<<<< HEAD
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
            
=======
                break;
>>>>>>> cad3d986a5645c4c1120630c0e88f2a6262f93d1
            case 1
                fprintf(obj.Port,[char(2),char(1)],'async');
                return;
            case 2
                fprintf(obj.Port,[char(2),char(2)],'async');
                return;
            case 3
                fprintf(obj.Port,[char(2),char(4)],'async');
                return;
            case 4
                fprintf(obj.Port,[char(2),char(5)],'async');
                return;
            case 5
                fprintf(obj.Port,[char(2),char(6)],'async');
                return;
            case 6
                fprintf(obj.Port,[char(2),char(7)],'async');
                return;
            end
            pause(1.5)
>>>>>>> 102ac411a8250c02c8dca5fb53a502da169a1f77
        end
    end

    
    
end