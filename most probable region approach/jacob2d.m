function minLrequired = jacob2d(xe,ye,xt,yt,xp,yp,sx,k)

Bx= 1+((yt*(1-k^2)-ye+yp*k^2)/(xt*(1-k^2)-xe+xp*k^2))^2;
C= ((xe-xp)^2+(ye-yp)^2)*(k^2)/((1-k^2)^2);
dcx= 2*(k^2/(1-k^2)^2)*(xe-xp);
dcy= 2*(k^2/(1-k^2)^2)*(ye-yp);
dbxx= 2*(yt*(1-k^2)-ye+yp*k^2)^2/((xt*(1-k^2)-xe+xp*k^2)^3);
dbyx=-2*(yt*(1-k^2)-ye+yp*k^2)/(xt*(1-k^2)-xe+xp*k^2)^2;
f1=(1)/(1-k^2)+0.5*sqrt(Bx/C)*(Bx*dcx-C*dbxx)/Bx^2;
f2=0+0.5*sqrt(Bx/C)*(Bx*dcy-C*dbyx)/Bx^2;
By= 1+((xt*(1-k^2)-xe+xp*k^2)/(yt*(1-k^2)-ye+yp*k^2))^2;

dbxy= 2*(xt*(1-k^2)-xe+xp*k^2)^2/((yt*(1-k^2)-ye+yp*k^2)^3);
dbyy=-2*(xt*(1-k^2)-xe+xp*k^2)/(yt*(1-k^2)-ye+yp*k^2)^2;
if(isinf(By))
    By=1e+200;
    dbxy=By;
    dbyy=By;
end
f4=0+0.5*sqrt(By/C)*(By*dcx-C*dbxy)/By^2;
f5=(1)/(1-k^2)+0.5*sqrt(By/C)*(By*dcy-C*dbyy)/By^2;
Den=(xt*(1-k^2)-xe+xp*k^2);
Num=(yt*(1-k^2)-ye+yp*k^2);
if(isinf(Num))
    Num=By;
end
dDkx=2*(xe-xp)*k/(1-k^2)^2;
dDky=2*(ye-yp)*k/(1-k^2)^2;
dCk=(2*k*(1+k^2)/(1-k^2)^3)*((xe-xp)^2+(ye-yp)^2);
dBkx=2*(Num/Den)*(Den*(2*k*(yp-yt))-Num*(2*k*(xp-xt)))/(Den)^2;
dBky=2*(Den/Num)*(Num*(2*k*(xp-xt))-Den*(2*k*(yp-yt)))/(Num)^2;

f3=dDkx+0.5*sqrt(Bx/C)*(Bx*dCk-C*dBkx)/Bx^2;
f6=dDky+0.5*sqrt(By/C)*(By*dCk-C*dBky)/By^2;
M=[f1 f2;f4 f5];
h=(transpose(M))*M;
singularvalue=min(sqrt(abs(eig(h))));
minLrequired=(singularvalue)/(2*sx); %This is the minimum value required to prove the set is NON-Convex







