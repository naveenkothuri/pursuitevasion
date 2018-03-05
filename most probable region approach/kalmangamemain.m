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
tx=50;ty=40; %Target
xp=50;yp=-30;  %Pursuer
vp=4; 
T=100; %simulation steps T*delT will give total time
delT=0.3;
ipx=120;ipy=40;
xe=ipx;ye=ipy;
hh=0;
iv=2; % This is mean of output.,Initial best estimate
sx=5; sy =5; %
sv=0.5;
sk=sv/vp;
s.tx=tx;s.ty=ty;s.xe=ipx;s.ye=ipy;s.xp=xp;s.yp=yp;
%L=probabilitymap(tx,ty,xp,yp,ipx,ipy,iv/vp,sx,sy,sk,m); %Initial Intercept point based on the sensor data
L.I=[84.5431;47.6148];
L.sigma=[10.9236 3.5597];
xetru=ipx+3*sx;
yetru=ipy+3*sy;
ketru=(iv/vp)+3*sk; %this is always fixed for Evader
Igactual=mapkal(tx,ty,xetru,yetru,xp,yp,ketru); % This is what initially pursued by evader.

s.x=[L.I(1);L.I(2);iv/vp];  % these are the initial state estimate of the kalman system.
%s.u=0;
 %xpdeltainput=2*vp*delT*randn/3;ypdeltainput=2*vp*delT*randn/3;
     xpdeltainput=xp(end);ypdeltainput=yp(end);

 s.u=[xpdeltainput;ypdeltainput;xe(end);ye(end);xp(end);yp(end)];
%%

syms a1 a2 a3 a4 a5
yi=(((a2-a4*a5^2)/(1-a5^2))+sign(ty-((a2-a4*a5^2)/(1-a5^2)))*sqrt(((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))*((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2)))))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2)));
xi=(((a1-a3*a5^2)/(1-a5^2))+sign(tx-((a1-a3*a5^2)/(1-a5^2)))*sqrt((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2)));


C11=diff(xi,a3);
D11=diff(xi,a4);




C21=diff(yi,a3);
D21=diff(yi,a4);


syms xpdelta ypdelta xi yi

%xinext=xi+(C11*(xpdelta)+D11*(ypdelta));

xinext=xi+(C11*(xpdelta)+D11*(ypdelta))-(C11*(a3+delT*vp*cos(atan((a4-yi)/(a3-xi))))+D11*(a4+delT*vp*sin(atan((a4-yi)/(a3-xi)))));

dxindxi=diff(xinext,xi);
dxindyi=diff(xinext,yi);
 dxindxpd=diff(xinext,xpdelta);
 dxindypd=diff(xinext,ypdelta);
dxindxe=diff(xinext,a1);
 dxindye=diff(xinext,a2);
 dxindxp=diff(xinext,a3);
 dxindyp=diff(xinext,a4);

dxindke=diff(xinext,a5);


%yinext=yi+(C21*(xpdelta)+D21*(ypdelta));
yinext=yi+(C21*(xpdelta)+D21*(ypdelta))-(C21*(a3+delT*vp*cos(atan((a4-yi)/(a3-xi))))+D21*(a4+delT*vp*sin(atan((a4-yi)/(a3-xi)))));
dyindxi=diff(yinext,xi);
dyindyi=diff(yinext,yi);
 dyindxpd=diff(yinext,xpdelta);
 dyindypd=diff(yinext,ypdelta);
dyindxe=diff(yinext,a1);
 dyindye=diff(yinext,a2);
 dyindxp=diff(yinext,a3);
 dyindyp=diff(yinext,a4);

dyindke=diff(yinext,a5);


%{
A11=diff(xi,a1);
B11=diff(xi,a2);
C11=diff(xi,a3);
D11=diff(xi,a4);
E11=diff(xi,a5);


A21=diff(yi,a1);
B21=diff(yi,a2);
C21=diff(yi,a3);
D21=diff(yi,a4);
E21=diff(yi,a5);

A2=double(subs(A21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
B2=double(subs(B21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
C2=double(subs(C21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
D2=double(subs(D21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
E2=double(subs(E21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));

syms xenext yenext xpnext ypnext xi yi

xinext=xi+delT*(A11*(xenext-a1)+B11*(yenext-a2)+C11*(xpnext-a3)+D11*(ypnext-a4));
dxindxen=diff(xinext,xenext);
 dxindyen=diff(xinext,yenext);
 dxindxpn=diff(xinext,xpnext);
 dxindypn=diff(xinext,ypnext);
dxindxe=diff(xinext,a1);
 dxindye=diff(xinext,a2);
 dxindxp=diff(xinext,a3);
 dxindyp=diff(xinext,a4);

dxindke=diff(xinext,a5);


yinext=yi+delT*(A21*(xenext-a1)+B21*(yenext-a2)+C21*(xpnext-a3)+D21*(ypnext-a4));
dyindxen=diff(yinext,xenext);
 dyindyen=diff(yinext,yenext);
 dyindxpn=diff(yinext,xpnext);
 dyindypn=diff(yinext,ypnext);
dyindxe=diff(yinext,a1);
 dyindye=diff(yinext,a2);
 dyindxp=diff(yinext,a3);
 dyindyp=diff(yinext,a4);

dyindke=diff(yinext,a5);


B21=double(subs(dyindxen,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));
B22=double(subs(dyindyen,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));
B23=double(subs(dyindxpn,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));
B24=double(subs(dyindypn,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));
B25=double(subs(dyindxe,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));
B26=double(subs(dyindye,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));
B27=double(subs(dyindxp,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));
B28=double(subs(dyindyp,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));

A23=double(subs(dyindke,{a1,a2,a3,a4,a5,xenext,yenext,xpnext,ypnext},{xe(end-1),ye(end-1),xp(end-1),yp(end-1),s(end).x(3),xe(end),ye(end),xp(end),yp(end)}));

%%
s.A=[1 0 ;0 1];
s.B=[B11 B12 B13 B14 B15 B16 B17 B18;B21 B22 B23 B24 B25 B26 B27 B28]; 
%}
s.P=[(L.sigma(1))^2 0 0;0 (L.sigma(2))^2 0; 0 0 sk^2]; % This is jsut for initialization. Initially it is equal to output covariance matrix
covIx=s(end).P(1,1);
covIy=s(end).P(2,2);
covv=s(end).P(3,3);
%Later, in each step it gets updated
s.R=[(L.sigma(1))^2 0 0;0 (L.sigma(2))^2 0; 0 0 sk^2]; % This is output noise covariance matrix which is assumed constant for the entire run.
%s.Q =[(L.sigma(1))^2 0 0;0 (L.sigma(2))^2 0; 0 0 0]; % We have in our system process noise, don't forget to update this.
s.Q=zeros(3);
s.H= eye(3); %Checking both the states.
s.F=[
   (vp*delT/3)^2 0 0 0 0 0;
   0 (vp*delT/3)^2 0 0 0 0;
   0 0 (sx)^2 0 0 0;
   0 0 0 (sy)^2 0 0;
   0 0 0 0 0 0;
   0 0 0 0 0 0];
%
%Our actual system is true interception point which is pursued by the
%evader. At t=0, both get initial readings, at t=1, I am modelling actual
%interception point change as the present interception point + change
%occured in pursuer's interception point 
Igxe=Igactual(1);
Igye=Igactual(2);
 tru=[Igxe;Igye;ketru]; % true initial states
 for t=1:T
  if(hh~=1)
     E=mapupdatedkal(tru(end-2),tru(end-1),xetru(end),yetru(end),ketru(end)*vp,delT);
  else
      E=mapupdatedkal(tx,ty,xetru(end),yetru(end),ketru(end)*vp,delT);
  end
         % Ep=mapupdatedkal(s(end).x(1),s(end).x(2),s(end).xe,s(end).ye,s(end).x(3)*vp,delT);
          

     Pursuer=mapupdatedkal(s(end).x(1),s(end).x(2),xp(end),yp(end),vp,delT); % for next step pursuer
     %Ep=inverseevader(tx,ty,s(end).x(1),s(end).x(2),Pursuer(1),Pursuer(2),s(end).x(3)); %Using the next step pursuer and present interceptionpoint, we are finding next step evader.
  
     %{
     A1=double(subs(A11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
B1=double(subs(B11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
C1=double(subs(C11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
D1=double(subs(D11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
E1=double(subs(E11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));


A2=double(subs(A21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
B2=double(subs(B21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
C2=double(subs(C21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
D2=double(subs(D21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
E2=double(subs(E21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));

s.A=[1 0 ;0 1];
s.B=delT*[A1 B1 C1 D1;A2 B2 C2 D2]; 
     %}

B11=double(subs(dxindxpd,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B12=double(subs(dxindypd,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B13=double(subs(dxindxe,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B14=double(subs(dxindye,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B15=double(subs(dxindxp,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B16=double(subs(dxindyp,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));

A11=double(subs(dxindxi,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));

A12=double(subs(dxindyi,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));

A13=double(subs(dxindke,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));

B21=double(subs(dyindxpd,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B22=double(subs(dyindypd,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B23=double(subs(dyindxe,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B24=double(subs(dyindye,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B25=double(subs(dyindxp,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
B26=double(subs(dyindyp,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
A23=double(subs(dyindke,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
A21=double(subs(dyindxi,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
A22=double(subs(dyindyi,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));



s(end).A=[A11 A12 A13;A21 A22 A23;0 0 1];
s(end).B=[B11 B12 B13 B14 B15 B16;B21 B22 B23 B24 B25 B26;0 0 0 0 0 0]; 
%{
if(mod(t,10)==0)
L(end+1)=probabilitymap(tx,ty,xp(end),yp(end),xe(end),yp(end),s(end).x(3),sx,sy,sk,m); %Initial Intercept point based on the sensor data
end
%}
    s(end).R=[(L(end).sigma(1))^2 0 0;0 (L(end).sigma(2))^2 0; 0 0 sk^2]; % This is output noise covariance matrix which is assumed constant for the entire run.
%s(end).Q =[(L(end).sigma(1))^2 0 0;0 (L(end).sigma(2))^2 0; 0 0 0];
    s(end).z = (s(end).H)*tru(end-2:end,1) + sqrt(s(end).R)*randn(3,1); % Here we are using tru(end-3:end-2) because present states are stored there
   %create a measurement. ( This is actual measurement)
   %Note that when t=0, s.x is still the initial value. This along with
   %actual output is given to kalman filter.
   %{
   xetru(end+1)=E(1);yetru(end+1)=E(2);
     xp(end+1)=Pursuer(1);yp(end+1)=Pursuer(2);
     xe(end+1)=Ep(1);ye(end+1)=Ep(2);
   s(end).xp=xp(end);
      s(end).yp=yp(end);
      s(end).xe=xp(end);
   s(end).xe=xp(end);
   %}
   s(end).xin=double(subs(xinext,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
   s(end).yin=double(subs(yinext,{a1,a2,a3,a4,a5,xpdelta,ypdelta,xi,yi},{xe(end),ye(end),xp(end),yp(end),s(end).x(3),xpdeltainput,ypdeltainput,s(end).x(1),s(end).x(2)}));
   s(end).kin=s(end).x(3);
   s(end+1)=kalmanf(s(end)); % perform a Kalman filter iteration
Ep=inverseevader(tx,ty,s(end).x(1),s(end).x(2),Pursuer(1),Pursuer(2),s(end).x(3)); %Using the next step pursuer and present interceptionpoint, we are finding next step evader.

   
   xetru(end+1)=E(1);yetru(end+1)=E(2);
     xp(end+1)=Pursuer(1);yp(end+1)=Pursuer(2);
     xe(end+1)=Ep(1);ye(end+1)=Ep(2);
      %xpdeltainput=2*vp*delT*randn/3;ypdeltainput=2*vp*delT*randn/3;
     xpdeltainput=2*xp(end)-xp(end-1);ypdeltainput=2*yp(end)-yp(end-1);
     tru(end+1:end+2,1) =mapkal(tx,ty,xetru(end),yetru(end),xp(end),yp(end),ketru(end));% These are actual states. We induce noise here to get actual output. 
    tru(end+1,1)=tru(end-2);
   s(end).u=[xpdeltainput;ypdeltainput;xe(end);ye(end);xp(end);yp(end)];
   
   %Now in the second structure, s.x  is updated with the best prediction
  % i.e., x(1) given one measurement
   %given one measurement. This is again used in the next iteration to
   %generate x(2) given one measurement from model. That is used along
   %with second measurement to generate x(2) given two measurements and
  % the outupt of kalman filter is x(2) given two measurements.
   
   covIx(end+1)=s(end).P(1,1);  %just to plot covariances
   covIy(end+1)=s(end).P(2,2);
   covv(end+1)=s(end).P(3,3);
   %}
     X4 = [xp(end),yp(end);xetru(end),yetru(end)];
        d4 = pdist(X4,'euclidean');
                X3 = [xetru(end),yetru(end);tru(end-5),tru(end-4)];
        d3 = pdist(X3,'euclidean');
        X2 = [tru(end-2),tru(end-1);tx,ty];
        d2 = pdist(X2,'euclidean');
     if(d4<3)
        disp('Pursuer won');
        t
        break;                        
    elseif(d3<1)
        hh=1;
        if(d2<1)
        disp('Evader won');
        t
        break;  
        end
    end
 
 end
 hold on
 grid on
 for i =1:t
 posmIx(:,i)= s(i).z(1);
 posmIy(:,i)= s(i).z(2);
 posmv(:,i)=s(i).z(3);
 end
 for i=1:t-1
 posteriorposIx(:,i)= s(i+1).x(1);
 posteriorposIy(:,i)= s(i+1).x(2);
 posteriorvec(:,i)=s(i+1).x(3)*vp;

 end
 for i =1:t
     Igactualx(i)=tru(1+3*(i-1));
     Igactualy(i)=tru(2+3*(i-1));
     vtru(i)=tru(3+3*(i-1))*vp;
     T(i)=i;
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
  plot(xe,ye,'g.')
  plot(tru(end-2),tru(end-1),'ro');
 %plot(posteriorposIx,posteriorposIy,'b*')
 %{
 figure
 plot(posmIx,posmIy,'ro');
 hold on
 plot(posteriorposIx,posteriorposIy,'b*')
  hold off
  %}
  figure
  plot(T,vtru)
  hold on
  plot(T(2:end),posteriorvec)
i=1:t+1;
  figure
  subplot(3,1,1)
  plot(i,covIx)
  subplot(3,1,2)
  plot(i,covIy)
  subplot(3,1,3)
  plot(i,covv)
  figure
    plot(Igactualx(2:end)-posteriorposIx)
      figure
    plot(Igactualy(2:end)-posteriorposIy)
      figure
    plot(vtru(2:end)-posteriorvec)
  Distancmovedbyevader=sqrt((xetru(1)-xetru(end))^2+(yetru(1)-yetru(end))^2)
  vtru(end)
  Timetakenbyevader=Distancmovedbyevader/vtru(end)
  Distancmovedbypursuer=sqrt((xp(1)-xp(end))^2+(yp(1)-yp(end))^2)
  vp
  Timetakenbypuruser=Distancmovedbypursuer/vp;
  Initialinterceptionpoint=[Igxe;Igye]
  Finalinterceptionpoint=[tru(end-2);tru(end-1)]

