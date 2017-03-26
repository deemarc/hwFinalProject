%%value from microcontroller
clkHz= 50 *10^6;
deg0PW = 1.5*10^-3;
degN90PW = 1*10^-3;
degP90PW = 2*10^-3;

tick_0Deg   = deg0PW*clkHz;
tick_perDeg = ((degP90PW - degN90PW)*clkHz)/180;

r = 6.5;
ang=0:0.01:pi; 
xp=r*cos(ang);
yp=r*sin(ang)-3.5;
plot(xp,yp);

dist = 6.5;
motXDeg = rad2deg(atan(xp/dist));
motYDeg = -1*rad2deg(atan(yp/dist));

motXTick = int64(tick_0Deg + motXDeg*tick_perDeg);
motYTick = int64(tick_0Deg + motYDeg*tick_perDeg);
h1 = [0 0];
h2 = [0 1];
h3 = [1 0];
h4 = [1 1];

try
    MyPort = serial('COM5','baudrate',9600,'databits',8, ...
        'parity','none','stopbits',1);
    fopen(MyPort);
    disp(MyPort)
    for i=1:length(motXTick)
        curX = motXTick(i);
        curY = motYTick(i);
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
        %disp('Start')
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
        pause(0.02);

    end
        fclose(MyPort)
        delete(MyPort)
        clear MyPort

catch
    fclose(MyPort)
    delete(MyPort)
    clear MyPort
end