%{
Initial value of position = ip= 0;
Initial value of velocity = iv =150m/s;
variance of position error in output = Wp = (50m)^2
variance of position error in output = Wv = (15m/s)^2
Systems states are position and velocity with no process noise Why?
Because evader model is moving with constant velocity. It is sensor
that is not sure of its measurements. 
sensor senses position and velocity 

%System : 
         xe(t+1) = xe(t) + vx(t);
         v(t+1) = v(t); % where v = sqrt(vx^2+vy^2)
         ye(t+1)= ye(t) +vy(t)   % vx and vy as not part of states are
         considered as inputs
 %outputs 
 y(t) = [1 0 0;0 1 0;0 0 1]*(xe(t);v(t);ye(t))+[exe(t);ev(t);eye(t)]
%}
clear all
tx=50;ty=40; %Target
xp=50;yp=-30;  %Pursuer
vp=4;          % Velocity of pursuer
T=100; %simulation steps T*delT will give total time
delT=0.3;
s.u=0;
ipx=120;ipy=40;
s.K=eye(3);
iv=2; % This is mean of output.,Initial best estimate
Wpx= 5^2; Wpy =5^2;
Wv=0.125^2;
%s.Wpx=sqrt(Wpx);s.Wpy=sqrt(Wpy);s.Wv=sqrt(Wv);
Ig=mapkal(tx,ty,ipx,ipy,xp,yp,(iv/vp)); %Initial Intercept point based on the sensor data
pursuerInterceptpointx=Ig(1);
pursuerInterceptpointy=Ig(2);

s.Ig=Ig;
s.delT=delT;
s.x=[ipx;iv;ipy];
s.vp=vp;
s.P=[Wpx 0 0; 0 Wv 0;0 0 Wpy]; % This is jsut for initialization. Initially it is equal to output covariance matrix
covx=s(end).P(1,1);
covv=s(end).P(2,2);
covy=s(end).P(3,3);
%s.x1=s.x;
%Later, in each step it gets updated
s.R=[Wpx 0 0 ;0 Wv 0 ;0 0 Wpy]; % This is output noise covariance matrix which is assumed constant for the entire run.
%s.Q =[0.5*Wpx .7 .8 ;0 0.5*Wv 0 ;.8 .8 0.5*Wpy];
s.Q =[0.5*Wpx 0 0 ;0 0 0 ;0 0 0.5*Wpy];
%s.Q=zeros(3);
s.H= eye(3);
hh=0;
vtru=iv+sqrt(Wv)*3; %exact states;
%normrnd(0,sqrt(Wpx))
xtru= ipx+sqrt(Wpx)*3;
ytru=ipy+sqrt(Wpy)*3;
Igevader=mapkal(tx,ty,xtru,ytru,xp,yp,vtru/vp);
%{
vtru1=iv+sqrt(Wv)*randn; %exact states;
%normrnd(0,sqrt(Wpx))
xtru1= ipx+sqrt(Wpx)*randn;
ytru1=ipy+sqrt(Wpy)*randn;
Igevader1=mapkal(tx,ty,xtru1,ytru1,xp,yp,vtru1/vp);
tru1=[xtru1;vtru1;ytru1]; % evader initial states 
%}
Igxe=Igevader(1);
Igye=Igevader(2);
 tru=[xtru;vtru;ytru]; % true initial states
 
    %{
 ktru=(tru(3)-Igevader(2))/(tru(1)-Igevader(1));
    vxtru=sign(Igevader(1)-tru(1))*tru(2)/sqrt(1+ktru^2);
    vytru=ktru*vxtru;
     u=[vxtru;vytru];
 %}
     syms a1 a2 a3 a4 a5
xenext=a1+delT*a5*vp*cos(atan((a2-(((a2-a4*a5^2)/(1-a5^2))+sign(ty-((a2-a4*a5^2)/(1-a5^2)))*sqrt(((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))*((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2)))))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2))))/(a1-(((a1-a3*a5^2)/(1-a5^2))+sign(tx-((a1-a3*a5^2)/(1-a5^2)))*sqrt((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2))))));
yenext=a2+delT*a5*vp*sin(atan((a2-(((a2-a4*a5^2)/(1-a5^2))+sign(ty-((a2-a4*a5^2)/(1-a5^2)))*sqrt(((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))*((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2)))))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2))))/(a1-(((a1-a3*a5^2)/(1-a5^2))+sign(tx-((a1-a3*a5^2)/(1-a5^2)))*sqrt((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2))))));

dfdxxe=diff(xenext,a1);
dfdxye=diff(xenext,a2);
dfdxke=diff(xenext,a5);
dfdyxe=diff(yenext,a1);
dfdyye=diff(yenext,a2);
dfdyke=diff(yenext,a5);
dfdzxxp=diff(xenext,a3);
dfdzxyp=diff(xenext,a4);
dfdzyxp=diff(yenext,a3);
dfdzyyp=diff(yenext,a4);
%s.A1=[1 0 0;0 1 0; 0 0 1 ];
%s.B1=[1 0;0 0;0 1]; %So delT is included in B matrix % This is just initialization because xp(end-1) is not available yet.
for t=1:T
A11=double(subs(dfdxxe,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
A12=double(subs(dfdxke,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));

A13=double(subs(dfdxye,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
A31=double(subs(dfdyxe,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
A32=double(subs(dfdyke,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));

A33=double(subs(dfdyye,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
s(end).A=[A11 A12 A13;0 1 0;A31 A32 A33];
%eig(s(end).A-(s(end).K)*(s(end).H))
%rank(ctrb(s(end).A,s(end).Q))
%s(end).A=s(1).A;
dfdzxxp=diff(xenext,a3);
dfdzxyp=diff(xenext,a4);
dfdzyxp=diff(yenext,a3);
dfdzyyp=diff(yenext,a4);
B11=double(subs(dfdzxxp,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
B12=double(subs(dfdzxyp,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
B31=double(subs(dfdzyxp,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
B32=double(subs(dfdzyyp,{a1,a2,a3,a4,a5},{s(end).x(1),s(end).x(3),xp(end),yp(end),s(end).x(2)}));
s(end).B=[B11 B12;0 0;B31 B32];
%s(end).B=s(1).B;
  %s(end).u=[xp(end)-xp(end-1);yp(end)-yp(end-1)];
  %s(end).e=[s(end-1).x(1);s(end-1).x(2);s(end-1).x(3)];
 %{ 
  k=(s(end).x(3)-Ig(2))/(s(end).x(1)-Ig(1));
     vx= sign(Ig(1)-s(end).x(1))*s(end).x(2)/sqrt(1+k^2); % Every time we are updating our estimate of evader position and velocity
     vy= k*vx;
     s(end).u=[vx;vy];
  %}
    evader= mapupdatedkal(Igevader(1),Igevader(2),tru(end-2),tru(end),tru(end-1),delT);%This is actual evader, 
    %evader1= mapupdatedkal(Igevader1(1),Igevader1(2),tru1(end-2),tru1(end),tru1(end-1),delT);% This is what evader thinks actual
    tru(end+1:end+3,1) = [evader(1);tru(end-1);evader(2)];
    %tru1(end+1:end+3,1) = [evader1(1);tru1(end-1);evader1(2)]+s(end).Q*[randn;randn;randn];
   s(end).z = (s(end).H)*(tru(end-5:end-3,1)) + sqrt(s(end).R)*randn(3,1); % Here we are using tru(end-5:end-3) because present states are stored there
   %create a measurement. ( This is actual measurement)
   %Note that when t=0, s.x is still the initial value. This along with
   %actual output is given to kalman filter.
   
   s(end+1)=kalmanfonlyforlinearizedevadersystem(s(end)); % perform a Kalman filter iteration
   %Now in the second structure, s.x  is updated with the best prediction
  % i.e., x(1) given one measurement
   %given one measurement. This is again used in the next iteration to
   %generate x(2) given one measurement from model. That is used along
   %with second measurement to generate x(2) given two measurements and
  % the outupt of kalman filter is x(2) given two measurements.
   
   covx(end+1)=s(end).P(1,1);  %just to plot covariances
   covv(end+1)=s(end).P(2,2);
   covy(end+1)=s(end).P(3,3);
    pursuer=mapupdatedkal(Ig(1),Ig(2),xp(end),yp(end),vp,delT); % end+1 because initially we stored initial value of pursuer, and we used map function once
   %so the next instant of pursuer is updated accordingly.
   xp(end+1)=pursuer(1);
   yp(end+1)=pursuer(2);
   %updated.
   Ig=mapkal(tx,ty,s(end).x(1),s(end).x(3),xp(end),yp(end),(s(end).x(2))/vp);
    pursuerInterceptpointx(end+1)=Ig(1);
    pursuerInterceptpointy(end+1)=Ig(2);
    s(end).Ig=Ig;
    
  % Use this code if evader also monitors pursuer's coordinates at every
   %step and calculates corresponding interception point.
   if(hh~=1)
   Igevader=mapkal(tx,ty,tru(end-2),tru(end),xp(end),yp(end),(tru(end-1))/vp); % end-1 because our current values,which are needed for calculating interception point are in s(end-1) structure
   %Igevader1=mapkal(tx,ty,tru1(end-2),tru1(end),xp(end),yp(end),(tru1(end-1))/vp); % end-1 because our current values,which are needed for calculating interception point are in s(end-1) structure

   end
   %{
   Igxe(end+1)=Igevader(1);
     Igye(end+1)=Igevader(2);
     ktru=(tru(end)-Igevader(2))/(tru(end-2)-Igevader(1));
    vxtru=sign(Igevader(1)-tru(end-2))*tru(end-1)/sqrt(1+ktru^2);
    vytru=ktru*vxtru;
    u=[vxtru;vytru];
    
   %}
     X4 = [xp(end),yp(end);tru(end-2),tru(end)];
        d4 = pdist(X4,'euclidean');
                X3 = [tru(end-2),tru(end);Igevader(1),Igevader(2)];
        d3 = pdist(X3,'euclidean');
         
        
        X2 = [tru(end-2),tru(end);tx,ty];
        d2 = pdist(X2,'euclidean');
       
     if(d4<3)
        disp('Pursuer won');
        t
        break;                        
    elseif(d3>d2)
        
        if(d2>1)
        Igevader=[tx;ty];
        hh=1;
        else
            disp('Evader won');
            t
            break;  
        end                       
     end
     %{
     X31 = [tru1(end-2),tru1(end);Igevader1(1),Igevader1(2)];
        d31 = pdist(X31,'euclidean');
         X21 = [tru1(end-2),tru1(end);tx,ty];
        d21 = pdist(X21,'euclidean');
    if(d31>d21)
        if(d21>1)
            Igevader1=[tx;ty];
        end
    end
     %}      
 
 end
 hold on
 grid on
     for i =1:t
 posmx(:,i)= s(i).z(1);
 vecm(:,i)= s(i).z(2);
 posmy(:,i)= s(i).z(3);
 end
 for i=1:t-1
 posteriorposx(:,i)= s(i+1).x(1);
 posteriorvec(:,i)= s(i+1).x(2);
 posteriorposy(:,i)= s(i+1).x(3);
 end
 
 for i =1:t
     xtru(i)=tru(1+3*(i-1));
     vtru(i)=tru(2+3*(i-1));
     ytru(i)=tru(3+3*(i-1));
 end
 %{
  for i =1:t
     xtru1(i)=tru1(1+3*(i-1));
     vtru1(i)=tru1(2+3*(i-1));
     ytru1(i)=tru1(3+3*(i-1));
 end
 %}
 xc=(xtru(1)-((xp(1))*((vtru(1)/vp)^2)))/(1-(vtru(1)/vp)^2);
yc=(ytru(1)-((yp(1))*((vtru(1)/vp)^2)))/(1-(vtru(1)/vp)^2);
r=double(sqrt(xc^2+yc^2-((xtru(1)^2+ytru(1)^2)/(1-(vtru(1)/vp)^2))+((vtru(1)/vp)^2*(xp(1)^2+yp(1)^2))/(1-(vtru(1)/vp)^2)));
h=circle(xc,yc,r);

 hold on
 %{
 xc1=(xtru1(1)-((xp(1))*((vtru1(1)/vp)^2)))/(1-(vtru1(1)/vp)^2);
yc1=(ytru1(1)-((yp(1))*((vtru1(1)/vp)^2)))/(1-(vtru1(1)/vp)^2);
r1=double(sqrt(xc1^2+yc1^2-((xtru1(1)^2+ytru1(1)^2)/(1-(vtru1(1)/vp)^2))+((vtru1(1)/vp)^2*(xp(1)^2+yp(1)^2))/(1-(vtru1(1)/vp)^2)));
h=circle(xc1,yc1,r1);
hold on
 %}
  plot(posmx,posmy,'r.')
  plot(pursuerInterceptpointx,pursuerInterceptpointy,'bo')
  plot(tx,ty,'r*');
  plot(xp,yp,'b.');
  plot(Igevader(1),Igevader(2),'ro');
  
 %plot(posteriorposx,posteriorposy,'b*')
 plot(xtru,ytru,'g.')
     figure
 plot(vecm,'r.')
 hold on
 plot(posteriorvec,'b-');
  plot(vtru,'g-')
  hold off
  figure
  subplot(3,1,1)
  plot(covx)
  subplot(3,1,2)
  plot(covv)
  subplot(3,1,3)
  plot(covy)
  
      figure
  plot(xtru(2:end)-posteriorposx)
    Distancmovedbyevader=sqrt((xtru(1)-xtru(end))^2+(ytru(1)-ytru(end))^2)
    vtru(end)
  Timetakenbyevader=Distancmovedbyevader/vtru(end)
  Distancmovedbypursuer=sqrt((xp(1)-xp(end))^2+(yp(1)-yp(end))^2)
  Timetakenbypuruser=Distancmovedbypursuer/vp
    Initialinterceptionpoint=[Igxe;Igye]
  Finalinterceptionpoint=[Igevader(1);Igevader(2)]