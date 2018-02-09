
function s= map1(tx,ty,xe,ye,xp,yp,k)
figure
vp=2;
ve=k*vp;
Ex=xe;
Ey=ye;
Px=xp;
Py=yp;
s.r=[];
s.xc=[];
s.yc=[];

for i=1:10
    %k=e/p;
xc=(xe-((xp)*(k^2)))/(1-k^2);
yc=(ye-((yp)*(k^2)))/(1-k^2);
r=double(sqrt(xc^2+yc^2-((xe^2+ye^2)/(1-k^2))+(k^2*(xp^2+yp^2))/(1-k^2)));

%% equation of line joining target and center of circle and solving line and circle to get Intersection point
coefficients = polyfit([tx, xc], [ty, yc], 1);
a = coefficients (1);
b = coefficients (2);   
syms x y 
[solx,soly]=solve((x-xc)^2+(y-yc)^2==r^2,(a*x-y)==-b);
X1 = [double(solx(1,1)),double(soly(1,1));tx,ty];
 d1 = pdist(X1,'euclidean');
X2 = [double(solx(2,1)),double(soly(2,1));tx,ty];
d2 = pdist(X2,'euclidean');
d=min(d1,d2);
if (d==d1)
    solxm=double(solx(1,1));
    solym=double(soly(1,1));
else
    solxm=double(solx(2,1));
    solym=double(soly(2,1));
end
if(i==1)
    u(1)=solxm;
    u(2)=solym;
end
%
s.r(end+1)=r;
s.xc(end+1)=xc;
s.yc(end+1)=yc;

h=circle(xc,yc,r);
hold on 
%plot(solx,soly,'ro')
%plot(xe,ye,'*')  % evader

plot(xc,yc,'.')  % center of circle
%plot(xp,yp,'+')   % pursuer
%plot(solxm,solym,'bo')
%{
%This code is to generate actual Apollonius circles of the game.
E=mapupdated(u(1),u(2),xp,yp,xe,ye,ve,0.5);
if(sqrt((xe-tx)^2+(ye-ty)^2)<=r)
E=mapupdated(tx,ty,xp,yp,xe,ye,ve,0.1);
end
P=mapupdated(u(1),u(2),xe,ye,xp,yp,vp,0.5);
%}
%{
 %This code is to generate line L.
if(i==1)
coefficients = polyfit([double(solxm), tx], [double(solym), ty], 1);
a2 = coefficients (1);
b2 = coefficients (2);
plot(solxm,solym,'r*')
end
xe=xe+2*vp*cos(atan(a2)); %corresponding to distance moved by evader
ye=(a2)*(xe)+Ey(1)-(a2)*(Ex(1));

E(1)=xe;E(2)=ye;
P(1)=xp;P(2)=yp;
%}
%
rr=k*sqrt((xp-solxm)^2+(yp-solym)^2);
if(i==1)
circle(solxm,solym,rr)
for j=1:7
Ex(end+1)=solxm+rr*cos(j*2*pi/7);
Ey(end+1)=solym+rr*sin(j*2*pi/7);
end
end
 %This code is to generate circle C1.

E(1)=Ex(i+1);E(2)=Ey(i+1);
P(1)=xp;P(2)=yp;
%}


Ex(end+1)=E(1);
Ey(end+1)=E(2);
Px(end+1)=P(1);
Py(end+1)=P(2);
xp=Px(end);
yp=Py(end);
xe=Ex(end);
ye=Ey(end);

%}
%% for the movement of pursuer and evader 
%{
coefficients = polyfit([double(solxm), xe], [double(solym), ye], 1);
a1 = coefficients (1);
b1 = coefficients (2);
e=double(solxm);
xe2=xe;
ye2=ye;
if(xe~=e)
    xe=xe+sign(e-xe)*0.01*abs(e-xei); %0.05 is step size
ye=(a1)*(xe)+b1;
end
coefficients = polyfit([double(solxm), xp], [double(solym), yp], 1);
a2 = coefficients (1);
b2 = coefficients (2);
X3 = [xe2,ye2;xe,ye];
 d3 = pdist(X3,'euclidean');
if((xp~=e))
    xp=xp+sign(e-xp)*(1/k)*d3*cos(atan(a2)); %corresponding to distance moved by evader
yp=(a2)*(xp)+b2;
end
%}
end
I=[solxm;solym];
plot(tx,ty,'b*')  % target
%plot(Ex,Ey)
plot(Px,Py,'b+')
%plot(solxm,solym,'bo')
plot(Ex,Ey,'r*')
%}
s.Ex=Ex;
s.Ey=Ey;
s.Px=Px;
s.Py=Py;

