
function I= map(tx,ty,xe,ye,xp,yp,k)


for i=1:1
    %k=e/p;
xc=(xe-((xp)*(k^2)))/(1-k^2);
yc=(ye-((yp)*(k^2)))/(1-k^2);
r=double(sqrt(xc^2+yc^2-((xe^2+ye^2)/(1-k^2))+(k^2*(xp^2+yp^2))/(1-k^2)));

%% equation of line joining target and center of circle and solving line and circle to get Intersection point
coefficients = polyfit([tx, xc], [ty, yc], 1);
a = coefficients (1);
b = coefficients (2);
if(i==1)
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
end
%{
h=circle(xc,yc,r);
hold on 
%plot(solx,soly,'ro')
plot(xe,ye,'r*')  % evader
plot(tx,ty,'b*')  % target
plot(xc,yc,'ro')  % center of circle
plot(xp,yp,'+')   % pursuer
plot(solxm,solym,'bo')

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


%}
