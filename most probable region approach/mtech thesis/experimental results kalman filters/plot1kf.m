load('s120.mat')
A=s;
%%
xtru=s.xtru;
  ytru=s.ytru;
 xp=A.xp;
  yp=A.yp;
  tx=A.tx;
  ty=A.ty;
  vp=A.vp;
  vtru=A.vtru;
  R=A.R;
  posteriorposx=A.posteriorposx;
  posteriorposy=A.posteriorposy;
  posteriorvec=A.posteriorvec;
  posmx=A.posmx;
  posmy=A.posmy;
  vecm=A.vecm;
  Igevader=A.Igevader;
  pursuerInterceptpointx=A.Igpursuerx;
  pursuerInterceptpointy=A.Igpursuery;
  covx=A.covx;covy=A.covy;covv=A.covv;
  Ig=mapkal(tx,ty,xtru(1),ytru(1),xp(1),yp(1),vtru(1)/vp);
  Igxe=Ig(1);  Igye=Ig(2);

%%
 xc=(xtru(1)-((xp(1))*((vtru(1)/vp)^2)))/(1-(vtru(1)/vp)^2);
yc=(ytru(1)-((yp(1))*((vtru(1)/vp)^2)))/(1-(vtru(1)/vp)^2);
r=double(sqrt(xc^2+yc^2-((xtru(1)^2+ytru(1)^2)/(1-(vtru(1)/vp)^2))+((vtru(1)/vp)^2*(xp(1)^2+yp(1)^2))/(1-(vtru(1)/vp)^2)));
h=circle(xc,yc,r);

 hold on
 %{
 xc1=(xtru1(1)-((xp(1))*((vtru1(1)/vp)^2)))/(1-(vtru1(1)/vp)^2);
yc1=(ytru1(1)-((yp(1))*((vtru1(1)/vp)^2)))/(1-(vtru1(1)/vp)^2);
r1=double(sqrt(xc1^2+yc1^2-((xtru1(1)^2+ytru1(1)^2)/(1-(vtru1(1)/vp)^2))+((vtru1(1)/vp)^2*(xp(1)^2+yp(1)^2))/(1-(vtru1(1)/vp)^2)));
h=circle(xc1,yc1,r1);
hold on
 %}
  %plot(posmx,posmy,'r.')
  plot(pursuerInterceptpointx,pursuerInterceptpointy,'bo')
  plot(tx,ty,'r*');
  plot(xp,yp,'b.');
  plot(Igevader(1),Igevader(2),'ro');
  
 plot(posteriorposx,posteriorposy,'r.')
 plot(xtru,ytru,'g.')
     figure
 plot(vecm,'r.')
 hold on
 plot(posteriorvec,'b-');
  plot(vtru,'g-')
  hold off
  figure
  subplot(3,1,1)
  plot(covx)
  subplot(3,1,2)
  plot(covv)
  subplot(3,1,3)
  plot(covy)
  
      figure
  plot(xtru(2:end)-posteriorposx)
    Distancmovedbyevader=sqrt((xtru(1)-xtru(end))^2+(ytru(1)-ytru(end))^2)
    vtru(end)
  Timetakenbyevader=Distancmovedbyevader/vtru(end)
  Distancmovedbypursuer=sqrt((xp(1)-xp(end))^2+(yp(1)-yp(end))^2)
  Timetakenbypuruser=Distancmovedbypursuer/vp
    Initialinterceptionpoint=[Igxe;Igye]
  Finalinterceptionpoint=[Igevader(1);Igevader(2)]