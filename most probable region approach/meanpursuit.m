tx=-40;ty=70;
x0=[];
y0=[];Igpursuerx=[];Igpursuery=[];
v0=[];Igevaderx=[];Igevadery=[];
sx=10;
sy=10;
vp=1;
sk=0.125;
ketru=0.7;
xp=-20;yp=35;
vtru=ketru*vp;
hh=0;
sv=vp*sk;
T=400; %simulation steps T*delT will give total time
delT=1.5;
pause(1)
xetru=100;yetru=45;
x0(end+1)=xetru(end)+randn*sx;y0(end+1)=yetru(end)+randn*sy;v0(end+1)=(ketru+randn*sk)*vp;
%x0(end+1)=108;y0(end+1)=54;v0(end+1)=0.716;
%map1(tx,ty,x0,y0,xp,yp,v0/vp)
%figure
for t=1:T
Ievader=mapkal(tx,ty,xetru(end),yetru(end),xp(end),yp(end),ketru);
Igevaderx(end+1)=Ievader(1);Igevadery(end+1)=Ievader(2);
Ipursuer= abscissamean(x0(end),y0(end),v0(end),sx,sv,xp(end),yp(end),tx,ty,vp);
Igpursuerx(end+1)=Ipursuer(1);Igpursuery(end+1)=Ipursuer(2);

if hh~=1
     E=(mapupdatedkal(Ievader(1),Ievader(2),xetru(end),yetru(end),ketru(end)*vp,delT));
else
     E=(mapupdatedkal(tx,ty,xetru(end),yetru(end),ketru(end)*vp,delT));
     hh
end
xetru(end+1)=double(E(1));yetru(end+1)=double(E(2));
 P=(mapupdatedkal(Ipursuer(1),Ipursuer(2),xp(end),yp(end),vp,delT));
xp(end+1)=double(P(1));yp(end+1)=double(P(2));
 X4 = [xp(end),yp(end);xetru(end),yetru(end)];
        d4 = pdist(X4,'euclidean');
                X3 = [xetru(end),yetru(end);Ievader(1),Ievader(2)];
        d3 = pdist(X3,'euclidean');
        X2 = [xetru(end),yetru(end);tx,ty];
        d2 = pdist(X2,'euclidean');
     if(d4<sx*1.3)
        disp('Pursuer won');
        t
        break;                        
     else
        if(d2<d3)
        disp('Evader won');
        hh=1;
        t
        if(d2<3)
        break;  
        end
        end
     end
    x0(end+1)=xetru(end)+randn*sx;y0(end+1)=yetru(end)+randn*sy;v0(end+1)=(ketru+randn*sk)*vp;
end
 hold on 
 %
 xc=(xetru(1)-((xp(1))*((ketru(1))^2)))/(1-(ketru(1))^2);
yc=(yetru(1)-((yp(1))*((ketru(1))^2)))/(1-(ketru(1))^2);
r=double(sqrt(xc^2+yc^2-((xetru(1)^2+yetru(1)^2)/(1-(ketru(1))^2))+((ketru(1))^2*(xp(1)^2+yp(1)^2))/(1-(ketru(1))^2)));
h=circle(xc,yc,r);
 hold on
  plot(xetru,yetru,'r.');
  plot(tx,ty,'r*');
  plot(xp,yp,'b.');
  plot(x0,y0,'bo');
  plot(Igevaderx,Igevadery,'ro');
 %{
 figure
 plot(posmIx,posmIy,'ro');
 hold on
 plot(posteriorposIx,posteriorposIy,'b*')
  hold off
  %}
  for i=1:t
          ketru(end+1)=ketru(end);
  end
  figure
  plot(ketru*vp)
  hold on
  plot(v0)
  Distancmovedbyevader=sqrt((xetru(1)-xetru(end))^2+(yetru(1)-yetru(end))^2)
  Timetakenbyevader=Distancmovedbyevader/vtru(end)
  Distancmovedbypursuer=sqrt((xp(1)-xp(end))^2+(yp(1)-yp(end))^2)
  Timetakenbypursuer=Distancmovedbypursuer/vp
  Initialinterceptionpoint=[Igevaderx(1);Igevadery(1)]
  Finalinterceptionpoint=[Igevaderx(end);Igevadery(end)]
    Distancebetweenevaderandpursuer=sqrt((xp(end)-xetru(end))^2+(yp(end)-yetru(end))^2)
