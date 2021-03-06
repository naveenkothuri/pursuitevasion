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
m=2;
tx=-7000;ty=15000; %Target
xp=-4000;yp=15000;  %Pursuer
vp=300;          % Velocity of pursuer
T=400; %simulation steps T*delT will give total time
delT=0.3;
ipx=-10000;ipy=1000;
iv=200; % This is mean of output.,Initial best estimate
sx= 80; sy =100; %
sv=40;
sk=40/(300);
L=probabilitymap(tx,ty,xp,yp,ipx,ipy,iv/vp,sx,sy,sk,2); %Initial Intercept point based on the sensor data

xetru=ipx+2*sx*randn;
yetru=ipy+2*sy*randn;
ketru=(iv/vp)+2*sk*randn; %this is always fixed for Evader
Igactual=mapkal(tx,ty,xetru,yetru,xp,yp,ketru); % This is what initially pursued by evader.
s.x=[L.I(1);L.I(2)];  % these are the initial state estimate of the kalman system.
s.A=[1 0 ;0 1];
s.B=[1 0;0 1]; 
s.P=[(L.sigma(1))^2 0;0 (L.sigma(2))^2]; % This is jsut for initialization. Initially it is equal to output covariance matrix
covIx=s(end).P(1,1);
covIy=s(end).P(2,2);
%Later, in each step it gets updated
s.R=[(L.sigma(1))^2 0;0 (L.sigma(2))^2]; % This is output noise covariance matrix which is assumed constant for the entire run.
s.Q =s.R; % We have in our system process noise, don't forget to update this.
s.H= eye(2); %Checking both the states.
%
%Our actual system is true interception point which is pursued by the
%evader. At t=0, both get initial readings, at t=1, I am modelling actual
%interception point change as the present interception point + change
%occured in pursuer's interception point 
Igxe=Igactual(1);
Igye=Igactual(2);
 tru=[Igxe;Igye]; % true initial states
 for t=1:T
  
     E=mapupdatedkal(tru(end-1),tru(end),xetru(end),yetru(end),ketru(end)*vp,delT);
     Pursuer=mapupdatedkal(s(end).x(1),s(end).x(2),xp(end),yp(end),vp,delT);
     xetru(end+1)=E(1);yetru(end+1)=E(2);
     xp(end+1)=Pursuer(1);yp(end+1)=Pursuer(2);
     if(t~=1)
    s(end).u=[L(end).I(1)-L(end-1).I(1);L(end).I(2)-L(end-1).I(2)];
     else
         s(end).u=[0;0];
     end
   % L(end+1)=probabilitymap(tx,ty,xp(end),yp(end),xetru(end)+2*sx*randn,yetru(end)+2*sy*randn,ketru+2*sk*randn,sx,sy,sk,m);%because ketru is always same for evader.
  % use this L if you think maximum probable point is not the interception
  % point corresponding to mean point.So I am using this to reduce
  % computation time.
 II= mapkal(tx,ty,xetru(end)+2*sx*randn,yetru(end)+2*sy*randn,xp(end),yp(end),ketru+2*sk*randn);
L(end+1).I=II;
L(end).sigma=L(end-1).sigma; % please study, these are the places you need to improve your algorithm
    tru(end+1:end+2,1) =mapkal(tx,ty,xetru(end),yetru(end),xp(end),yp(end),ketru(end));% These are actual states. We induce noise here to get actual output. 
   s(end).z = (s(end).H)*tru(end-3:end-2,1) + sqrt(s(end).R)*randn(2,1); % Here we are using tru(end-3:end-2) because present states are stored there
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
   
   covIx(end+1)=s(end).P(1,1);  %just to plot covariances
   covIy(end+1)=s(end).P(2,2);
   %}
     X4 = [xp(end),yp(end);tru(end-3),tru(end-2)];
        d4 = pdist(X4,'euclidean');
                X3 = [xetru(end),yetru(end);tru(end-3),tru(end-2)];
        d3 = pdist(X3,'euclidean');
     if(d4<100)
        disp('Pursuer won');
        t
        break;                        
    elseif(d3<100)
        disp('Evader won');
        t
        break;                        
    end
 
 end
 hold on
 grid on
 for i =1:t
 posmIx(:,i)= s(i).z(1);
 posmIy(:,i)= s(i).z(2);
 end
 for i=1:t-1
 posteriorposIx(:,i)= s(i+1).x(1);
 posteriorposIy(:,i)= s(i+1).x(2);

 end
 for i =1:t
     Igactualx(i)=tru(1+2*(i-1));
     Igactualy(i)=tru(2+2*(i-1));
 end
 %
 xc=(xetru(1)-((xp(1))*((ketru)^2)))/(1-(ketru)^2);
yc=(yetru(1)-((yp(1))*((ketru)^2)))/(1-(ketru)^2);
r=double(sqrt(xc^2+yc^2-((xetru(1)^2+yetru(1)^2)/(1-(ketru)^2))+((ketru)^2*(xp(1)^2+yp(1)^2))/(1-(ketru)^2)));
h=circle(xc,yc,r);
 hold on
  plot(xetru,yetru,'r.');
  plot(tx,ty,'r*');
  plot(xp,yp,'b.');
  plot(posmIx,posmIy,'ro');
 plot(posteriorposIx,posteriorposIy,'b*')
 figure
 plot(posmIx,posmIy,'ro');
 hold on
 plot(posteriorposIx,posteriorposIy,'b*')
  hold off
i=1:t+1;
  figure
  subplot(2,1,1)
  plot(i,covIx)
  subplot(2,1,2)
  plot(i,covIy)
  