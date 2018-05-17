tx=0;ty=54;
xp=-50;yp=30;vp=4;ve=3;delT=1;xe=100;ye=60;
Iact=mapkal(tx,ty,xe,ye,xp,yp,ve/vp);
D=sqrt((Iact(1)-tx)^2+(Iact(2)-ty)^2);
Ix=[];Iy=[];d=[];
i=1;
for th=0:pi/100:2*pi
    ex(i)=xe+ve*delT*cos(i);
    ey(i)=ye+ve*delT*sin(i);
    i=i+1;
end
i=1;
for th=0:pi/100:2*pi
    x(i)=xp+vp*delT*cos(i);
    y(i)=yp+vp*delT*sin(i);
        i=i+1;
end
xpI=xp+vp*delT*cos(atan2((Iact(2)-yp),(Iact(1)-xp)));
ypI=yp+vp*delT*sin(atan2((Iact(2)-yp),(Iact(1)-xp)));

i=1;

for i=1:size(ex,2)
    I=mapkal(tx,ty,ex(i),ey(i),xpI,ypI,ve/vp);
    Ix(end+1)=I(1);Iy(end+1)=I(2);
    d(end+1)=sqrt((Ix(end)-tx)^2+(Iy(end)-ty)^2);
end
plot(tx,ty,'r*')
hold on
plot(Ix,Iy,'b.')
plot(ex,ey,'ro')
plot(Iact(1),Iact(2),'ro')
