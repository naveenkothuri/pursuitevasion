function I= abscissamean(x0,y0,v0,sx,sv,xp,yp,xt,yt,vp)
%function s=sumprobability1(tx,ty,xp,yp,xemean,yemean,kemean,sx,sy,sk)

sk=sv./vp; % standard dev
k0=v0./vp; % standard dev
%xcor1=@(x,y,k)(((x-xp.*k.^2)./(1-k.^2)-sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp).^2+(y-yp).^2).*(xt.*(1-k.^2)-x+xp.*k.^2))./((xt.*(1-k.^2)-x+xp.*k.^2).^2+(yt.*(1-k.^2)-y+yp.*k.^2).^2).^0.5));
xcor1=@(x,y,k)(((x-xp.*k.^2)./(1-k.^2)+sign(xt-(x-xp.*k.^2)./(1-k.^2)).*sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp).^2+(y-yp).^2))./sqrt(1+((yt.*(1-k.^2)-y+yp.*k.^2).^2)./(xt.*(1-k.^2)-x+xp.*k.^2).^2)));

fun1=@(x,y,k)(xcor1(x,y,k).*exp((-1./(2.*sx.^2)).*((x-x0).^2+(y-y0).^2)).*exp((-1./(2.*sk.^2)).*((k-k0).^2))./(((2.*pi).^1.5).*(sx.^2).*sk));
%ycor1=@(x,y,k)(((y-yp.*k.^2)./(1-k.^2)-sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp).^2+(y-yp).^2))./sqrt(1+((xt.*(1-k.^2)-x+xp.*k.^2).^2)./(yt.*(1-k.^2)-y+yp.*k.^2).^2)));
%%ycor1=@(x,y,k)(((y-yp.*k.^2)./(1-k.^2)+sqrt((k./(1-k.^2)).^2).*(sqrt((x-xp).^2+(y-yp).^2).*abs(yt.*(1-k.^2)-y+yp.*k.^2))./sqrt((xt.*(1-k.^2)-x+xp.*k.^2).^2+(yt.*(1-k.^2)-y+yp.*k.^2).^2)));
ycor1=@(x,y,k)(yt+((yt.*(1-k.^2)-y+yp.*k.^2)./(xt.*(1-k.^2)-x+xp.*k.^2)).*(xcor1(x,y,k)-xt));    
fun2=@(x,y,k)(ycor1(x,y,k).*exp((-1./(2.*sx.^2)).*((x-x0).^2+(y-y0).^2)).*exp((-1./(2.*sk.^2)).*((k-k0).^2))./(((2.*pi).^1.5).*(sx.^2).*sk));
map1(xt,yt,x0,y0,xp,yp,k0)
ux=[];
uy=[];
ke=k0-3*sk;
for k1=1:5
ke=ke+sk;
ye=y0-3*sx;
for j=1:5
xe=x0-3*sx;
ye=ye+sx;
for l=1:5
xe=xe+sx;
ux(end+1)=xcor1(xe,ye,ke);
uy(end+1)=ycor1(xe,ye,ke);
end
end
end
plot(ux,uy,'*')
%{
[x,y]=meshgrid(-3*sx+x0:x0+3*sx,-3*sx+y0:y0+3*sx);
figure
plot3(x,y,fun1(x,y,2));
figure
plot3(x,y,fun2(x,y,2));
figure
plot(xcor1(x,y,2),ycor1(x,y,2),'*')
     %}
m=2;
I(1)=integral3(fun1,-m*sx+x0,m*sx+x0,-m*sx+y0,m*sx+y0,-m*sk+k0,m*sk+k0,'AbsTol', 0,'RelTol',1e-6);
I(2)=integral3(fun2,-m*sx+x0,m*sx+x0,-m*sx+y0,m*sx+y0,-m*sk+k0,m*sk+k0,'AbsTol', 0,'RelTol',1e-3);
%{
xcor2=@(x,y,k)(((x-xp.*k.^2)./(1-k.^2)-(k./(1-k.^2)).*(sqrt((x-xp).^2+(y-yp).^2).*(xt.*(1-k.^2)-x+xp.*k.^2))./((xt.*(1-k.^2)-x+xp.*k.^2).^2+(yt.*(1-k.^2)-y+yp.*k.^2).^2).^0.5));
fun3=@(x,y,k)(xcor2(x,y,k).*exp((-1./(2.*sx.^2)).*((x-x0).^2+(y-y0).^2)).*exp((-1./(2.*sk.^2)).*((k-k0).^2))./(((2.*pi).^1.5).*sx.^2.*sk));
ycor2=@(x,y,k)(-1*(xt-xcor2(x,y,k)).*((yt.*(1-k.^2)-y+yp.*k.^2)./(xt.*(1-k.^2)-x+xp.*k.^2))+yt);
fun4=@(x,y,k)(ycor2(x,y,k).*exp((-1./(2.*sx.^2)).*((x-x0).^2+(y-y0).^2)).*exp((-1./(2.*sk.^2)).*((k-k0).^2))./(((2.*pi).^1.5).*sx.^2.*sk));
x=-3*sx+x0:x0+3*sx;
y=-3*sx+y0:y0+3*sx;
[x,y]=meshgrid(-3*sx+x0:x0+3*sx,-3*sx+y0:y0+3*sx);
%fun=@(x,y,k)((((x-xp*k^2)/(1-k^2))+((k/(1-k^2))^2*(x^2+y^2-2*x*xp-2*y*yp+xp^2+yp^2))/((yt*(1-k^2)-y+yp*k^2)/(xt*(1-k^2)-x+xp*k.^2))+1)*(exp((-1*((x-x0)^2+(y-y0)^2))/(2*sx^2)))*(exp((-1*((k-k0)^2))/(2*sk^2)))/(2*pi*sx*sk));
Ix2=integral3(fun3,-3*sx+x0,3*sx+x0,-3*sx+y0,3*sx+y0,-3*sk+k0,3*sk+k0,'AbsTol', 0,'RelTol',1e-9);
Iy2=integral3(fun4,-3*sx+x0,3*sx+x0,-3*sx+y0,3*sx+y0,-3*sk+k0,3*sk+k0,'AbsTol', 0,'RelTol',1e-9);


p=(Ix1-xt)^2+(Iy1-yt)^2;
q=(Ix2-xt)^2+(Iy2-yt)^2;
if(p<q)
    Ix=Ix1;
    Iy=Iy1;
else
    Ix=Ix2;
    Iy=Iy2;
end
.*exp((-1./(2.*sk.^2)).*((k-k0).^2))
.*((x-x0).^2+(y-y0).^2)
%}