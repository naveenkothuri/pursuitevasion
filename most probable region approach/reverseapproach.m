
function ev = reverseapproach(tx,ty,xI,yI,xp,yp,k)
        I(1)=xI;
        I(2)=yI;
        M=(ty-I(2))/(tx-I(1));
        figure
%{
yIg=yI;
for j=1:1
    xI=xI+1;
    yI=yIg;
    for k1=1:1
        I(1)=xI;
        I(2)=yI;
        yI=yI+1;
        M=(I(2)-ty)/(I(1)-tx);
    %k=e/p;
    %}
%%
recm=double(sqrt(k^2*((xp-I(1))^2+(yp-I(2))^2)));
j=circle(I(1),I(2),recm);
hold on
xv=-20:1;
yv=M*xv+(((yp-ty)-M*(xp-tx))*k^2+ty-M*tx);
Q=((yp-ty)-M*(xp-tx))*k^2+ty-M*tx;
%Q1=Q*(tx-I(1));
%Q2=(yp*k^2+ty*(1-k^2))*(tx-I(1))-(ty-I(2))*(xp*k^2+tx*(1-k^2));
%Q3=k^2*((yp*(tx-I(1))-xp*(ty-I(2)))+(ty*I(1)-tx*I(2)));
%Q1-Q3
B=2*(M*(Q-I(2))-I(1));
A=1+M^2;
C=(I(1)^2+(Q-I(2))^2-recm^2);
s=sign(B^2-4*A*C)
%(recm^2*(1+M^2)-(M*I(1)+Q-I(2))^2)
Dpi=(xp-I(1))^2+(yp-I(2))^2;
Dti=(tx-I(1))^2+(ty-I(2))^2;
plot(xv,yv);
syms x y
[xe,ye]=solve((x-I(1))^2+(y-I(2))^2==recm^2,(M*x-y)==-(((yp-ty)-M*(xp-tx))*k^2+ty-M*tx));%this is from reverse approach
ev=double([xe ye]);
for u=1:size(xe,1)
    if(s==-1)
        break;
    end
    xc(u)=(xe(u)-((xp)*(k^2)))/(1-k^2);
yc(u)=(ye(u)-((yp)*(k^2)))/(1-k^2);
r(u)=(sqrt(xc(u)^2+yc(u)^2-((xe(u)^2+ye(u)^2)/(1-k^2))+(k^2*(xp^2+yp^2))/(1-k^2)));
g=circle(xc(u),yc(u),r(u));
        hold on
%% equation of line joining target and center of circle and solving line and circle to get Intersection point
coefficients = polyfit([tx, xc(u)], [ty, yc(u)], 1);
a = coefficients (1);
b = coefficients (2);

syms x y 
[solx,soly]=solve((x-xc(u))^2+(y-yc(u))^2==r(u)^2,(a*x-y)==-b);
X1 = [double(solx(1,1)),double(soly(1,1));tx,ty];
 d1 = pdist(X1,'euclidean');
X2 = [double(solx(2,1)),double(soly(2,1));tx,ty];
d2 = pdist(X2,'euclidean');
d=min(d1,d2);
if (d==d1)
    solxm(u)=double(solx(1,1));
    solym(u)=double(soly(1,1));
else
    solxm(u)=double(solx(2,1));
    solym(u)=double(soly(2,1));
end
solxm;
solym;
if(u==2)
    xc=double(xc);
    %Notes: we have two exceptional cases in this approach.
    % 1. second center (In this approach, any center as we don't what is second what is first)
       % falling in between given interception point and
    % target. This exception is the same exception we have in forward
    % approach where we give evader point and find other evader point
    % corresponding to same interception point.
    % 2. Refer fig "reverse approach exceptional case to be avoided."
    % We give an interception point and solve a circle and a line to get
    % evader points. But the solution turns out to have two different
    % interception points but whose apollonius circles pass through given
    % interception point.,i.e it lies on diametrically opposite end of
    % respective interception points. To avoid this the centers must not
    % fall between given interception point and target. This is the same
    % condition we are considering to avoid exception (1). But this turns
    % out it also avoids second exceptional case too. In this case we say
    % that NO(not single evader point corresponds to given interception
    % point) evader point is feasible and hence ignore the given
    % interception point.
    if((((I(1))<(xc(2)))&&((xc(2))<=(tx)))||(((tx)<(xc(2)))&&((xc(2))<=(I(1)))))  %for the exceptions (C1 T C2 I) and (C1 I C2 T)
        disp('exception encountered');
        %if((tx-I(1))*sign(solxm(u)-I(1))>r*(1/(M^2+1)))
        if((xc(2)-I(1))*(xc(2)+I(1)-2*tx)+(yc(2)-I(2))*(yc(2)+I(2)-2*ty)<0)
            disp('this condition is true s');
        end     
        break;  
    elseif((((I(1))<(xc(1)))&&((xc(1))<=(tx)))||(((tx)<(xc(1)))&&((xc(1))<=(I(1))))) %as now both evader points are unknown we don't know which center will fall between I and T
        disp('exception encountered');
        %if((tx-I(1))*sign(solxm(u)-I(1))>r*(1/(M^2+1))) %this condition has to be rederived for this case
        if((xc(1)-I(1))*(xc(1)+I(1)-2*tx)+(yc(1)-I(2))*(yc(1)+I(2)-2*ty)<0) 
        disp('this condition is true');
        end     
        break;
    end
end
end

;
%{
xe=xemirror;
ye=yemirror;
Em=[xe;ye];
plot(xe,ye,'r+')
h=circle(xc,yc,r);
%}
if(s==1)
hold on 
plot(xe,ye,'r*')  % evader
plot(tx,ty,'b*')  % target
plot(xc,yc,'ro')  % center of circle
plot(xp,yp,'+')   % pursuer
plot(solxm,solym,'bo')
end
%{


R1=((xp-I(1)).^2+(yp-I(2)).^2);
c=(ty-M*tx);
P1=(yp-M*xp-c);
L=R1/P1;


[xl,yl]=meshgrid(-150:3:150);
%z1=((yl-M*xl-c)/(yp-M*xp-c)); %z1=ke^2 in this equation,%this is from forward approach
z1=(yl-M*xl-ty+M*tx)/((yp-M*xp)-(ty-M*tx)); %this is from reverse approach
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
ke2=sqrt((yd-M*xd-ty+M*tx)/((yp-M*xp)-(ty-M*tx)));%this is from reverse approach
plot3(xd,yd,ke2)
hold on
xlabel('abscissa of evader');
ylabel('ordinate of evader');
zlabel('velocity of evader');
%ke=sqrt((Rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*(xd*(xcm-I(1))+yd*(ycm-I(2))))/(R1));%this is from forward approach
%plot3(xd,yd,ke)
plot3(xd,yd,k*ones(size(xd,2)))
%}
[x,y]=meshgrid(-30:30);
M=(y-ty)./(x-tx);
Q=((yp-ty)-M*(xp-tx))*k^2+ty-M*tx;
B=2*(M.*(Q-y)-x);
A=ones(61)+M.^2;
recm=double(sqrt(k^2*((xp-x).^2+(yp-y).^2)));
C=(x.^2+(Q-y).^2-recm.^2);
figure
s=B.^2-4*A.*C;
%s=(((xp-x)^2+(yp-y)^2)*((tx-x)^2+(ty-y)^2)-(k*((yp*(tx-x)-xp*(ty-y))+(ty*x-tx*y)))^2); %condition for existance of evader points
plot3(x,y,s)
%plot3(x,y,s)
    end
%{
end
end
%}