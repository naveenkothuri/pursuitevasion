load('s130.mat')
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
  %Igevader=A.Igevader;
  for i=1:size(xtru,2)
  Igevader=mapkal(tx,ty,xtru(i),ytru(i),xp(i),yp(i),vtru(end)/10);
  Igtrux(i)=Igevader(1);  Igtruy(i)=Igevader(2);
  dist(i)=  sqrt((tx-Igevader(1))^2+(ty-Igevader(2))^2);
  %dist1(i)=sqrt((xp(i+1)-xp(i))^2+(yp(i+1)-yp(i))^2);
    %dist2(i)=sqrt((xtru(i+1)-xtru(i))^2+(ytru(i+1)-ytru(i))^2);

  end
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
  plot(Igtrux,Igtruy,'bo')
  plot(tx,ty,'r*');
  plot(xp(1:end-2),yp(1:end-2),'b.');
  plot(Igevader(1),Igevader(2),'bo');
  posteriorvec1(1)=vecm(1);
  for i=1:size(posteriorvec,2)
      posteriorvec1(i+1)=posteriorvec(i);
  end
 plot(posteriorposx,posteriorposy,'r.')
 plot(xtru,ytru,'g.')
     figure
 plot(vecm,'r.')
 hold on
 plot(posteriorvec1,'b-');
  plot(vtru,'g-')
  hold off
  figure
  subplot(3,1,1)
  plot(covx)
  subplot(3,1,2)
  plot(covv.*5)
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
  sqrt((tx-Igxe(1))^2+(ty-Igye(1))^2)
  sqrt((tx-Igevader(1))^2+(ty-Igevader(2))^2)
