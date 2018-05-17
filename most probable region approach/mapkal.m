
function I= mapkal(tx,ty,xe,ye,xp,yp,k)
xc=[];yc=[];
for i=1:1
    %k=e/p;
    if(size(k,2)~=1)
        gg=1;
    end
xc(end+1)=(xe(end)-((xp(end))*(k.^2)))/(1-k.^2);
yc(end+1)=(ye(end)-((yp(end))*(k.^2)))/(1-k.^2);
r=double(sqrt(xc(end)^2+yc(end)^2-((xe(end)^2+ye(end)^2)/(1-k^2))+(k^2*(xp(end)^2+yp(end)^2))/(1-k^2)));

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
h=circle(xc(end),yc(end),r);
    hold on 
%plot(solx,soly,'ro')
plot(tx,ty,'b*')  % target
plot(xc,yc,'bo')
plot(xp,yp,'go')
plot(xe,ye,'r*')
plot(solxm,solym,'bo')

%}
%% for the movement of pursuer and evader 
%{
coefficients = polyfit([double(solxm), xe(end)], [double(solym), ye(end)], 1);
a1 = coefficients (1);
b1 = coefficients (2);
e=double(solxm);
xe2=xe(end);
ye2=ye(end);
if(xe(end)~=e)
    xe(end+1)=xe(end)+sign(e-xe(end))*0.4*abs(e-xe(end)); %0.05 is step size
ye(end+1)=(a1)*(xe(end))+b1;
end
coefficients = polyfit([double(solxm), xp(end)], [double(solym), yp(end)], 1);
a2 = coefficients (1);
b2 = coefficients (2);
X3 = [xe2,ye2;xe(end),ye(end)];
 d3 = pdist(X3,'euclidean');
if((xp(end)~=e))
    xp(end+1)=xp(end)+sign(e-xp(end))*(1/k)*d3*cos(atan(a2)); %corresponding to distance moved by evader
yp(end+1)=(a2)*(xp(end))+b2;
end
%}
end
I=[solxm;solym];
%{
plot(xe(1:end-1),ye(1:end-1))

plot(xc,yc)  % center of circle
plot(xp(1:end-1),yp(1:end-1))
%}
