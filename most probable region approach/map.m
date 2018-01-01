
function I = map(tx,ty,xe,ye,xp,yp,k)
%{
for j=1:4
    xe=xe+1;
    ye=yeg;
    
    for k1=1:5
        ye=ye+1;
        yp=ypg;
        xp=xpg;
%}
for i=1:2
    %k=e/p;
xc=(xe-((xp)*(k^2)))/(1-k^2);
yc=(ye-((yp)*(k^2)))/(1-k^2);

r=double(sqrt(xc^2+yc^2-((xe^2+ye^2)/(1-k^2))+(k^2*(xp^2+yp^2))/(1-k^2)));

%% equation of line joining target and center of circle and solving line and circle to get Intersection point
coefficients = polyfit([tx, xc], [ty, yc], 1);
a = coefficients (1);
b = coefficients (2);
coefficients = polyfit([xe, xc], [ye, yc], 1);
a1 = coefficients (1);
b1 = coefficients (2);
if(i==1)
syms x y 
if((~(isinf(a)||isnan(a)))&&(~isinf(b)))
[solx,soly]=solve((x-xc)^2+(y-yc)^2==r^2,(a*x-y)==-b);
elseif((isinf(a)))
    [solx,soly]= solve((x-xc)^2+(y-yc)^2==r^2,(x-0*y)==tx);
elseif((a==0)&&(~isinf(b)))
    [solx,soly]= solve((x-xc)^2+(y-yc)^2==r^2,(y)==b);
elseif((isnan(a)))  
    [solx,soly]= solve((x-xc)^2+(y-yc)^2==r^2,(a1*x-y)==-b1);
end
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

if(i==2)
    if((((I(1))<(xc))&&((xc)<=(tx)))||(((tx)<(xc))&&((xc)<=(I(1)))))  %for the exceptions (C1 T C2 I) and (C1 I C2 T)
        disp('exception encountered');
        if((tx-I(1))*sign(solxm-I(1))>r*(1/(M^2+1)))
            disp('this condition is true');
        end     
      
    end
end
%}
%%
if(i==1)
I=[solxm;solym];
M=(solym-ty)/(solxm-tx);
figure
recm=double(sqrt(k^2*((xp-solxm)^2+(yp-solym)^2)));
j=circle(solxm,solym,recm);
hold on
[xem,yem]=solve((x-solxm)^2+(y-solym)^2==recm^2,(a*x-y)==(a*xe-ye));%this is from forward approach

if(M*(solym-ye)/(solxm-xe)~=-1) %to check if mirror exists or not, mirror exists iff the line is not a tangent to the circle
if(abs(xe-xem(1))<0.0001) %since  matlab expression is is not converging onto exact value of expression
    xemirror=xem(2);
    yemirror=yem(2);
    plot(xem(1),yem(1),'r*')
else
    xemirror=xem(1);
    yemirror=yem(1);
     plot(xem(2),yem(2),'r*')
end
else
    xemirror=xe;
    yemirror=ye;
end
xv=xe-15:xe+15;
yv=M*xv+(ye-M*xe);
plot(xv,yv);
end
xe=xemirror;
ye=yemirror;
Em=[xe;ye];

h=circle(xc,yc,r);
hold on 
%plot(xe,ye,'r*')  % evader
plot(solxm,solym,'bo')
plot(xc,yc,'ro')  % center of circle
%plot(xp,yp,'+')   % pursuer
%plot(solxm,solym,'bo')
if(i==1)
    xct=xc;
    yct=yc;
    s.xct=xct;
    s.yct=yct;
end

hold on



end
plot(tx,ty,'b*')  % target
plot(xp,yp,'+')   % pursuer
plot(xe,ye,'g+')
M=(I(2)-ty)/(I(1)-tx);
c=(yct-M*xct);
R1=((xp-I(1)).^2+(yp-I(2)).^2);
P1=(yp-M*xp-c);
L=R1/P1;
[xl,yl]=meshgrid(-150:3:150);
z1=((yl-M*xl-c)/(yp-M*xp-c)); %z1=ke^2 in this equation,%this is from forward approach
figure
plot3(xl,yl,z1)
z2=(((xl-I(1)).^2+(yl-I(1)).^2)/R1); %z2=ke^2 in this equation
hold on
surf(xl,yl,z2)
figure
xcm=I(1)-L*M/2;
ycm=I(2)+L/2;
Rm=sqrt(((L^2)*(M^2+1)/4)-L*(M*I(1)-I(2)+c));

%h=circle(xcm,ycm,Rm)
    th = 0:pi/100:2*pi;
xd = Rm*cos(th) + xcm;
yd = Rm*sin(th) + ycm;
%ke=sqrt(((xd-I(1)).^2+(yd-I(1)).^2)/R1);
ke2=sqrt((yd-M*xd-c)/P1); %this is from forward approach

plot3(xd,yd,ke2)
hold on
%plot3(xd,yd,ke)
xlabel('abscissa of evader');
ylabel('ordinate of evader');
zlabel('velocity of evader');
ke=sqrt((Rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*(xd*(xcm-I(1))+yd*(ycm-I(2))))/(R1));%this is from forward approach
plot3(xd,yd,ke)
plot3(xd,yd,k*ones(size(xd,2)))
end
