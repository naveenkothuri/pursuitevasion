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
tx=-7000;ty=15000; %Target
xp=-4000;yp=15000;  %Pursuer
vp=300;          % Velocity of pursuer
T=400; %simulation steps T*delT will give total time
delT=0.3;
ipx=-10000;ipy=10000;
iv=400; % This is mean of output.,Initial best estimate
Wpx= 80^2; Wpy =100^2;
Wv=50^2;
Ig=mapkal(tx,ty,ipx,ipy,xp,yp,(iv/vp)); %Initial Intercept point based on the sensor data
pursuerInterceptpointx=Ig(1);
pursuerInterceptpointy=Ig(2);
s.x=[ipx;iv;ipy];
s.A=[1 0 0;0 1 0; 0 0 1 ];
s.B=delT*[1 0;0 0;0 1]; %So delT is included in B matrix
s.P=[Wpx 0 0 ;0 Wv 0 ;0 0 Wpy]; % This is jsut for initialization. Initially it is equal to output covariance matrix
covx=s(end).P(1,1);
covv=s(end).P(2,2);
covy=s(end).P(3,3);
%Later, in each step it gets updated
s.R=[Wpx 0 0 ;0 Wv 0 ;0 0 Wpy]; % This is output noise covariance matrix which is assumed constant for the entire run.
s.Q =zeros(3); % No process noise
s.H= eye(3);
%
vtru=iv+sqrt(Wv)*randn; %exact states;
xtru= ipx+sqrt(Wpx)*randn;
ytru=ipy+sqrt(Wpy)*randn;
Igactual=mapkal(tx,ty,xtru,ytru,xp,yp,vtru/vp);
Igxe=Igactual(1);
Igye=Igactual(2);
 tru=[xtru;vtru;ytru]; % true initial states
     ktru=(tru(3)-Igactual(2))/(tru(1)-Igactual(1));
    vxtru=sign(Igactual(1)-tru(1))*tru(2)/sqrt(1+ktru^2);
    vytru=ktru*vxtru;
     u=[vxtru;vytru];
 for t=1:T
  
    k=(s(end).x(3)-Ig(2))/(s(end).x(1)-Ig(1));
     vx= sign(Ig(1)-s(end).x(1))*s(end).x(2)/sqrt(1+k^2); % Every time we are updating our estimate of evader position and velocity
     vy= k*vx;
     s(end).u=[vx;vy];
    tru(end+1:end+3,1) =s(1).A*tru(end-2:end)+s(1).B*u;% These are actual states. We induce noise here to get actual output. 
   s(end).z = (s(end).H)*tru(end-5:end-3,1) + sqrt(s(end).R)*randn(3,1); % Here we are using tru(end-5:end-3) because present states are stored there
   %create a measurement. ( This is actual measurement)
   %Note that when t=0, s.x is still the initial value. This along with
   %actual output is given to kalman filter.
   s(end+1)=kalmanf(s(end)); % perform a Kalman filter iteration
   %Now in the second structure, s.x  is updated with the best prediction
  % i.e., x(1) given one measurement
   %given one measurement. This is again used in the next iteration to
   %generate x(2) given one measurement from model. That is used along
   %with second measurement to generate x(2) given two measurements and
  % the outupt of kalman filter is x(2) given two measurements.
   
   covx(end+1)=s(end).P(1,1);  %just to plot covariances
   covv(end+1)=s(end).P(2,2);
   covy(end+1)=s(end).P(3,3);
    pursuer=mapupdatedkal(Ig(1),Ig(2),xp(end),yp(end),vp,delT); % end-1 because initially we stored initial value of pursuer, and we used map function once
   %so the next instant of pursuer is updated accordingly
   xp(end+1)=pursuer(1);
   yp(end+1)=pursuer(2);
   %updated.
   Ig=mapkal(tx,ty,s(end).x(1),s(end).x(3),xp(end),yp(end),(s(end).x(2))/vp); %
    pursuerInterceptpointy(end+1)=Ig(2);
    
  % Use this code if evader also monitors pursuer's coordinates at every
   %step and calculates corresponding interception point.
   Igevader=mapkal(tx,ty,tru(end-2),tru(end),xp(end),yp(end),(tru(end-1))/vp); % end-1 because our current values,which are needed for calculating interception point are in s(end-1) structure
     Igxe(end+1)=Igevader(1);
     Igye(end+1)=Igevader(2);
     ktru=(tru(end)-Igevader(2))/(tru(end-2)-Igevader(1));
    vxtru=sign(Igevader(1)-tru(end-2))*tru(end-1)/sqrt(1+ktru^2);
    vytru=ktru*vxtru;
    u=[vxtru;vytru];
    
   %}
     X4 = [xp(end),yp(end);Igactual(1),Igactual(2)];
        d4 = pdist(X4,'euclidean');
                X3 = [tru(end-5),tru(end-3);Igactual(1),Igactual(2)];
        d3 = pdist(X3,'euclidean');
     if(d4<100)
        disp('Pursuer won');
        break;                        
    elseif(d3<100)
        disp('Evader won');
        break;                        
    end
 
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
 %
 xc=(xtru(1)-((xp(1))*((vtru(1)/vp)^2)))/(1-(vtru(1)/vp)^2);
yc=(ytru(1)-((yp(1))*((vtru(1)/vp)^2)))/(1-(vtru(1)/vp)^2);
r=double(sqrt(xc^2+yc^2-((xtru(1)^2+ytru(1)^2)/(1-(vtru(1)/vp)^2))+((vtru(1)/vp)^2*(xp(1)^2+yp(1)^2))/(1-(vtru(1)/vp)^2)));
h=circle(xc,yc,r);
 hold on
  plot(posmx,posmy,'r.')
  plot(pursuerInterceptpointx,pursuerInterceptpointy)
  plot(tx,ty,'r*');
  plot(xp,yp,'b.');
  plot(Igactual(1),Igactual(2),'ro');
 plot(posteriorposx,posteriorposy,'b-')
 plot(xtru,ytru,'g-')
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
  
  