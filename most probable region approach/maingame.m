function I=maingame(xt,yt,xe,ye,xp,yp,ketru,sx,sy,sk,m)
%all the incoming values are taken as initial values
delT=0.1;
I=[];
vp=1;

%% for evader movement
for i=1:10
solx=@(x,y,k)(((x-xp(end).*k.^2)./(1-k.^2)+sign(xt-(x-xp(end).*k.^2)./(1-k.^2)).*sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp(end)).^2+(y-yp(end)).^2))./sqrt(1+((yt.*(1-k.^2)-y+yp(end).*k.^2).^2)./(xt.*(1-k.^2)-x+xp(end).*k.^2).^2)));
soly=@(x,y,k)(yt+((yt.*(1-k.^2)-y+yp(end).*k.^2)./(xt.*(1-k.^2)-x+xp(end).*k.^2)).*(solx(x,y,k)-xt));    
coefficients = polyfit([double(solx(xe(end),ye(end),ketru)), xp(end)], [double(soly(xe(end),ye(end),ketru)), yp(end)], 1);
ae = coefficients (1);
be = coefficients (2);
xe(end+1)=xe(end)+sign(solx(xe(end),ye(end),ketru)-xp(end))*ketru*delT*vp*cos(atan(ae));
ye(end+1)=(ae)*(xe(end-1))+be;

%% for pursuer movement
s=probabilitymap(xt,yt,xp(end),yp(end),xe(end),ye(end),ketru,sx,sy,sk,m);
for i=1:size(s.prob,2)
    if(s.prob(i)==max(s.prob))
        maxindex=i;
    end
end
I(1,end+1)=s.I(1,maxindex);
I(2,end)=s.I(2,maxindex);
coefficients = polyfit([I(1,end), xp(end)], [I(2,end), yp(end)], 1);
ap = coefficients (1);
bp = coefficients (2);
xp(end+1)=xp(end)+sign(I(1,end)-xp(end))*delT*vp*cos(atan(ap));
yp(end+1)=(ap)*(xp(end-1))+bp;
end