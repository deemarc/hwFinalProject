% X7.X7
%1111 XXXX
%XXXX XXXX
%xxyy YYYY
%YYYY YYYY
%00XX XXXX 
%01XX XXXX
%10YY YYYY
%11YY YYYY
%1111 1111 --error Frame
h1 = [0 0];
h2 = [0 1];
h3 = [1 0];
h4 = [1 1];
curX = 87500;
curY = 82861;
curXZ = round(curX/50);
curYZ = round(curY/50);
x_u12 = bitget(curXZ,1:12);
y_u12 = bitget(curYZ,1:12);

m1 = [h1 x_u12(6:-1:1)];
m2 = [h2 x_u12(12:-1:1)];
m3 = [h3 y_u12(6:-1:1)];
m4 = [h4 y_u12(12:-1:1)];
m1 = m1(8:-1:1);
m2 = m2(8:-1:1);
m3 = m3(8:-1:1);
m4 = m4(8:-1:1);
%----------------------Initializing serial port----------------------------
try
    MyPort = serial('COM5','baudrate',9600,'databits',8, ...
        'parity','none','stopbits',1);
    fopen(MyPort);
    disp(MyPort)
    disp('Start')
    %fprintf(MyPort,'a');
    fwrite(MyPort,bi2de(m1));
    out = fread(MyPort, 1, 'uint8')
    fwrite(MyPort,bi2de(m2));
    out = fread(MyPort, 1, 'uint8')
    fwrite(MyPort,bi2de(m3));
    out = fread(MyPort, 1, 'uint8')
    fwrite(MyPort,bi2de(m4));
    out = fread(MyPort, 1, 'uint8')
    %a = char(out)
    %out = fread(MyPort, 1, 'uint8')
    fclose(MyPort)
    delete(MyPort)
    clear MyPort
catch
    fclose(MyPort)
    delete(MyPort)
    clear MyPort
end