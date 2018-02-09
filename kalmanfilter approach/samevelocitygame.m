function I = samevelocitygame(tx,ty,xe,ye,xp,yp)
ve=2;

for i=1:1

M=(ye-yp)/(xe-xp);
M=-1/M;

cb=((ye+yp)/2-M*(xe+xp)/2);

ct=(ty+(1/M)*tx); %because line joining target and interception point is perpendicular to bisector

syms x y

I(1) = (ct-cb)/(M+1/M);
I(2)=M*I(1)+cb;

plot(tx,ty,'r+');
hold on
plot(I(1),I(2),'ro');
plot(xe,ye,'r*');
plot(xp,yp,'b+');
x=min(min(xe,xp),tx)-5:1:max(max(xe,xp),tx)+2;
yb=M*x+cb;
yt=(-1/M)*x+ct;
y=(-1/M)*x+ye+(1/M)*xe;
plot(x,yb);
%plot(x,yt);
    plot(x,y);
    E=mapupdated(I(1),I(2),xp,yp,xe,ye,ve,0.1);
if(((xe-tx)^2+(ye-ty)^2)<=(xe-I(1))^2+(ye-I(2))^2)
E=mapupdated(ty,tx,xp,yp,xe,ye,ve,0.1);
end
xe=E(1);ye=E(2);
P=mapupdated(I(1),I(2),xe,ye,xp,yp,ve,0.1);
xp=P(1);yp=P(2);
end  
    
