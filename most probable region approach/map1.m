
function Imean= map1(xt,yt,xe,ye,xp,yp,sx,sk,k)
figure
xcor1=@(x,y,k)(((x-xp.*k.^2)./(1-k.^2)-sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp).^2+(y-yp).^2).*abs(xt.*(1-k.^2)-x+xp.*k.^2))./((xt.*(1-k.^2)-x+xp.*k.^2).^2+(yt.*(1-k.^2)-y+yp.*k.^2).^2).^0.5));
%ycor1=@(x,y,k)(-1*(xt-xcor1(x,y,k)).*((yt.*(1-k.^2)-y+yp.*k.^2)./(xt.*(1-k.^2)-x+xp.*k.^2))+yt);
ycor1=@(x,y,k)(((y-yp.*k.^2)./(1-k.^2)-sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp).^2+(y-yp).^2).*abs(yt.*(1-k.^2)-y+yp.*k.^2))./((xt.*(1-k.^2)-x+xp.*k.^2).^2+(yt.*(1-k.^2)-y+yp.*k.^2).^2).^0.5));


%{
N=2;
solxe=[];
solye=[];
for r=4  
    
    for j=1:N*r
        solxe(end+1)=xe+r*cos(2*pi*j/(N*r));
        solye(end+1)=ye+r*sin(2*pi*j/(N*r));
    end  
end
%}
n=sx;
xeg=xe;
kg=k;
yeg1=ye-2*n-n;
yeg=ye;
k=k-(sk)*3;
for k2=1:5
k=k+(0.1);
ye=yeg1;
for j=1:5
   
    xe=xeg-3*n;
     ye=ye+n;
    for k1=1:5
        xe=xe+n;
%}
for i=1:1
    %k=e/p;
xc=(xe-((xp)*(k^2)))/(1-k^2);
yc=(ye-((yp)*(k^2)))/(1-k^2);
r=double(sqrt(xc^2+yc^2-((xe^2+ye^2)/(1-k^2))+(k^2*(xp^2+yp^2))/(1-k^2)));

%% equation of line joining target and center of circle and solving line and circle to get Intersection point
coefficients = polyfit([xt, xc], [yt, yc], 1);
a = coefficients (1);
b = coefficients (2);
if(i==1)
syms x y 
[solx,soly]=solve((x-xc)^2+(y-yc)^2==r^2,(a*x-y)==-b);
X1 = [double(solx(1,1)),double(soly(1,1));xt,yt];
 d1 = pdist(X1,'euclidean');
X2 = [double(solx(2,1)),double(soly(2,1));xt,yt];
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
%
h=circle(xc,yc,r);
hold on 
%plot(solx,soly,'ro')
plot(xe,ye,'r*')  % evader
plot(xt,yt,'b*')  % target
plot(xc,yc,'ro')  % center of circle
plot(xp,yp,'+')   % pursuer
plot(solxm,solym,'bo')
%plot(xcor1(xe,ye,k),ycor1(xe,ye,k),'r*');
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
if((xe==xeg)&&(ye==yeg)&&(k2==1.2))
    Imean=[solxm;solym];
end
I=[solxm;solym];

end
end
sx=2*n;%%standard deviation is 1 we are varying xe,ye,ke in this program from -2*sigma to 2*sigma 
sy=2*n;% "Inequalities" program takes total bounds within which we are varying the variables 
sk=0;
%inequalities(xeg-sx,xeg+sx,yeg-sy,yeg+sy,k-sk,k+sk,xeg,yeg,k,xp,yp,xt,yt) %for each k we are finding bounds. otherwise error is very high
end
vp=10;
vemean=kg*vp;
sx=n; %"abscissamean" program takes only standard deviation values, so only 1 and 0.3 are being given. 
sk=0.1;
sv=sk*vp;
%P=abscissamean(xeg,yeg,vemean,sx,sv,xp,yp,xt,yt,vp)
%l=reverseapproach(xt,yt,P(1),P(2),xp,yp,1.4)
%}
