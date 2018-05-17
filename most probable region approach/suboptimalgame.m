function D = suboptimalgame(tx,ty,xe,ye,xp,yp,k)
ve=1;
vp=ve/k;
T=100;
hh=0;
delT=.5;
Ix=[];Iy=[];
 I=mapkal(tx,ty,xe(end),ye(end),xp(end),yp(end),k); 
Ix(end+1)=I(1);Iy(end+1)=I(2);
for i=1:90
 %{
coefficients = polyfit([tx, xe(end)], [ty, ye(end)], 1);
aesuboptimal = coefficients (1);
besuboptimal = coefficients (2);
coefficients = polyfit([I(1), xe(end)], [I(2), ye(end)], 1);
aeoptimal = coefficients (1);
beoptimal = coefficients (2);
coefficients = polyfit([xp(end), xe(end)], [yp(end), ye(end)], 1);
apsuboptimal = coefficients (1);
bpsuboptimal = coefficients (2);
coefficients = polyfit([xp(end), I(1)], [yp(end), I(2)], 1);
apoptimal = coefficients (1);
bpoptimal = coefficients (2);
%}
%
if(hh==0)
E=mapupdatedkal(I(1),I(2),xe(end),ye(end),ve,delT);
else
    E=mapupdatedkal(tx,ty,xe(end),ye(end),ve,delT);

end
%}
%E=mapupdatedkal(tx,ty,xe(end),ye(end),ve,delT);
%P=mapupdatedkal(I(1),I(2),xp(end),yp(end),vp,delT);
P=mapupdatedkal(xe(end),ye(end),xp(end),yp(end),vp,delT);
xe(end+1)=E(1);ye(end+1)=E(2);
xp(end+1)=P(1);yp(end+1)=P(2);
 I=mapkal(tx,ty,xe(end),ye(end),xp(end),yp(end),k); 
Ix(end+1)=I(1);Iy(end+1)=I(2);
 Xe = [xe(end),ye(end);Ix(end),Iy(end)];
 de = pdist(Xe,'euclidean');
  Xp = [xp(end),yp(end);xe(end),ye(end)];
  dp= pdist(Xp,'euclidean');
  Xt = [xe(end),ye(end);tx,ty];
  dte = pdist(Xt,'euclidean');
   if(dp<vp*delT/10)
        disp('Pursuer won');
        i
        break;  
   end
   if(dte<de)
        hh=1;
         disp('Evader won');
   end
   if(dte<ve*delT/10)
    i
    break;  
    end
end
plot(tx,ty,'r+');
hold on
plot(Ix(1:end-1),Iy(1:end-1),'ro');
plot(xe,ye);
plot(xp,yp);
D=sqrt((xe(end)-tx)^2+(ye(end)-ty)^2);
