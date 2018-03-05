
%xt=[-191,-8,290,515];
%xt=[-72,244,473,612,908];
%zt=[-359,-455,-348,-203];
%zt=[-814,-559,-672,-453,-748];
xt=0;zt=0;
%xt=[1489;1471;1467;1442;1349;1253;1153;1062;976;877;780;681;581;489;453;491;466;560;494;395;295]
%xt = [283.5,444.5,546,675.5,840,899.5,1064,1141]
%xt = double(nodesx)
%xt = [1496;1503;1527;1541;1509;1482.85412992357;1409.79533429533;1312.85431235431;1257.77272727273;1168;1093.71386454879;993.547506728315;898.629465862352;847.090157980762;761.418585024030;662.369213975615;591.447401568844;506.366013071895;408;369.614944614901;270.442458733540;194.143967783433;99.3623804463337;0]
%zt=[355;366;347;250;214;244;250;209;158;145;120;106;105;143;236;329;426;453;528;545;537;625];
%zt = [675,646.5,615,580,558,546,520,516];
%zt = double(nodesy)
lastR1 = 0;
lastR2 = 0;
diff1=0;
P=0.0045;
D=0.00009;
mymotor1 = motor(myev3, 'B');
mymotor2 = motor(myev3, 'c');
%a=1
for i=length(xt):-1:1
     set_param('Motivedisplay','SimulationCommand','start');
     pause(1);
    [xp,zp,yawp]=get_present_state();
    Yp=yawp;
    
yawt(i)= -atan2d((zt(i)-zp),(xt(i)-xp));
    Yt=yawt;

 %yawt=70;

%mymotor1.Speed=11;
%mymotor2.Speed=12;
%flag1=1;
%flag2=1;
 err=yawt(i)-yawp
E=err;
    if err <0
    
    mymotor1.Speed=8;
    mymotor2.Speed=-8;
     start(mymotor1);
     start(mymotor2);
    
    else
       mymotor1.Speed=-8;
       mymotor2.Speed=8;
      start(mymotor2);
      start(mymotor1);
    
    end
while( true)
    
    
    %if err <0
    
    
     % start(mymotor1);
    
    %else
       
   %   start(mymotor2);
    
%end
    %pause(0.01);
    %yawerror = yawt - yawp
    disp('turning');
    err=(yawt(i) - yawp);
    if abs(yawt(i) - yawp) < 1
        stop(mymotor1);
        stop(mymotor2);
        yawerror(i) = yawt(i) - yawp;
        
        break
    end
    [xp,zp,yawp] = get_present_state();
    Yp(end+1)=yawp;
    E(end+1)=err;
    Yt(end+1)=yawt;
    pause(0.01);
end
pause(0.01);
[xp,zp,yawp] = get_present_state();
%zt=zp;
yawp;
resetRotation(mymotor1);                    % Reset motor rotation counter
resetRotation(mymotor2);
mymotor1.Speed=11;
mymotor2.Speed=11;

start(mymotor1);
start(mymotor2);
while(true)
    %save("location",'-v7.3','a')
    r1 = readRotation(mymotor1);            % Read rotation counter in degrees
    r2 = readRotation(mymotor2);            
    
    speed1 = (r1 - lastR1)/0.01;          % Calculate the real speed in d/s
    speed2 = (r2 - lastR2)/0.01;
    diff2 = speed1 - speed2; 
    
    mymotor1.Speed = mymotor1.Speed -int8(diff2 * P)-int8((diff2-diff1)*D/0.01);
    lastR1 = r1;
    lastR2 = r2;
    diff1=diff2;
    distance = sqrt(0.90*(xt(i)-xp)^2 + 0.1*(zt(i)-zp)^2);
    disp('going straight');
    if distance <25
        stop(mymotor1);
        stop(mymotor2);
        
        break
    
        
    end
    [xp,zp,yawp] = get_present_state();
    pause (0.01);
end
 set_param('Motivedisplay','SimulationCommand','stop');
 %a=0;
 %save("location",'-v7.3','a')
end