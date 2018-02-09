function A=maingame(xt,yt,xe,ye,xp,yp,ketru,sx,sy,sk,m)
%all the incoming values are taken as initial values
delT=1.5;
Ix=[];
Iy=[];
Iactx=[];
Iacty=[];
Iactx1=[];
Iacty1=[];
vp=1;
xp2=xp;
yp2=yp;
I1=[];
xe1=xe;
ye1=ye;
%% for evader movement
for i=1:5
    i
solx=@(x,y,k)(((x-xp(end).*k.^2)./(1-k.^2)+sign(xt-(x-xp(end).*k.^2)./(1-k.^2)).*sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp(end)).^2+(y-yp(end)).^2))./sqrt(1+((yt.*(1-k.^2)-y+yp(end).*k.^2).^2)./(xt.*(1-k.^2)-x+xp(end).*k.^2).^2)));
soly=@(x,y,k)(yt+((yt.*(1-k.^2)-y+yp(end).*k.^2)./(xt.*(1-k.^2)-x+xp(end).*k.^2)).*(solx(x,y,k)-xt));    
solx1=solx(xe(end),ye(end),ketru);
soly1=soly(xe(end),ye(end),ketru);
Iactx(end+1)=solx1;
Iacty(end+1)=soly1;
coefficients = polyfit([double(solx1), xe(end)], [double(soly1), ye(end)], 1);
ae = coefficients (1);
be = coefficients (2);
xe(end+1)=xe(end)+sign(double(solx1)-xe(end))*ketru*delT*vp*cos(atan(ae));
ye(end+1)=(ae)*(xe(end))+be;


%% for pursuer movement
s=probabilitymap(xt,yt,xp(end),yp(end),xe(end)+sx*rand,ye(end)+sy*rand,ketru+sk*rand,sx,sy,sk,m);
for q=1:size(s.prob,2)
    if(s.prob(q)==max(s.prob))
        maxindex=q;
    end
end
Ix(end+1)=s.I(1,maxindex);
Iy(end+1)=s.I(2,maxindex);
coeff = polyfit([Ix(end), xp(end)], [Iy(end), yp(end)], 1);
ap = coeff (1);
bp = coeff (2);
xp(end+1)=xp(end)+sign(Ix(end)-xp(end))*delT*vp*cos(atan(ap));
yp(end+1)=(ap)*(xp(end))+bp;
%%
%{

solxa=@(x,y,k)(((x-xp2(end).*k.^2)./(1-k.^2)+sign(xt-(x-xp2(end).*k.^2)./(1-k.^2)).*sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp2(end)).^2+(y-yp2(end)).^2))./sqrt(1+((yt.*(1-k.^2)-y+yp2(end).*k.^2).^2)./(xt.*(1-k.^2)-x+xp2(end).*k.^2).^2)));
solya=@(x,y,k)(yt+((yt.*(1-k.^2)-y+yp2(end).*k.^2)./(xt.*(1-k.^2)-x+xp2(end).*k.^2)).*(solx(x,y,k)-xt));    
solx2=solxa(xe1(end),ye1(end),ketru);
soly2=solya(xe1(end),ye1(end),ketru);
Iactx1(end+1)=solx2;
Iacty1(end+1)=soly2;
coefficients = polyfit([double(solx2), xe1(end)], [double(soly2), ye1(end)], 1);
ae1 = coefficients (1);
be1 = coefficients (2);
xe1(end+1)=xe1(end)+sign(double(solx2)-xe1(end))*ketru*delT*vp*cos(atan(ae1));
ye1(end+1)=(ae1)*(xe1(end))+be1;
for q=1:size(s.prob1,2)
    if(s.prob1(q)==max(s.prob1))
        maxindex=q;
    end
end
I1(1,end+1)=s.I1(1,maxindex);
I1(2,end+1)=s.I1(2,maxindex);
coeffa = polyfit([I1(1,end), xp2(end)], [I1(2,end), yp2(end)], 1);
ap1 = coeffa (1);
bp1 = coeffa (2);
xp2(end+1)=xp2(end)+sign(I1(1,end)-xp2(end))*delT*vp*cos(atan(ap1));
yp2(end+1)=(ap1)*(xp2(end))+bp1;
%}
end
A.xp=xp;
A.yp=yp;
A.Ix=Ix;
A.Iy=Iy;
A.Iactx=Iactx;
A.Iacty=Iacty;
A.xe=xe;
A.ye=ye;
A.xp2=xp2;
A.yp2=yp2;
A.I1=I1;
A.xe1=xe1;
A.ye1=ye1;
A.Iactx1=Iactx1;
A.Iacty1=Iacty1;

