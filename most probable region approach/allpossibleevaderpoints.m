function I= allpossibleevaderpoints(tx,ty,xe,ye,xp,yp,k)

xc=(xe-((xp)*(k^2)))/(1-k^2);
yc=(ye-((yp)*(k^2)))/(1-k^2);
r=double(sqrt(xc^2+yc^2-((xe^2+ye^2)/(1-k^2))+(k^2*(xp^2+yp^2))/(1-k^2)));
s=curveparameters(tx,ty,xe,ye,xp,yp,k);
I=s.I;
M=((I(2))-ty)/((I(1))-tx);
c=(yc-M*(xc));
R1=((xp-I(1)).^2+(yp-I(2)).^2);
P1=(yp-M*xp-c);
L=R1/P1;
 th = 0:pi/100:2*pi;
xe2 = s.Rm*cos(th) + s.xcm;
ye2 = s.Rm*sin(th) + s.ycm;
ke2=sqrt((ye2-M*xe2-c)/P1);
for i=1:size(ke2,2)
    Id=curveparameters(tx,ty,xe2(i),ye2(i),xp,yp,ke2(i));
    if(Id.I(1)==I(1))
    plot(xe2(i),ye2(i),'r+')
    xct=(xe2(i)-((xp)*(ke2(i)^2)))/(1-ke2(i)^2);
yct=(ye2(i)-((yp)*(ke2(i)^2)))/(1-ke2(i)^2);
r=double(sqrt(xct^2+yct^2-((xe2(i)^2+ye2(i)^2)/(1-ke2(i)^2))+(ke2(i)^2*(xp^2+yp^2))/(1-ke2(i)^2)));
    hold on
  h=circle(xct,yct,r);
    plot(tx,ty,'b*')  % target
plot(xct,yct,'ro')  % center of circle
plot(xp,yp,'+')   % pursuer
plot(Id.I(1),Id.I(2),'bo')
    end
        
end