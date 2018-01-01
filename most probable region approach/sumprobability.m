function s=sumprobability(tx,ty,xp,yp,xemean,yemean,kemean,sx,sy,sk)
m=1; % this is the interval boundary which is considered so that probability is non-zero
prob=0;
I1=0;
I2=0;
Xcm=0;
Ycm=0;
Rm=0;
KT=[0 0 0 0];
inc=0;
Inc=0;
H1=curveparameters(tx,ty,xemean,yemean,xp,yp,kemean); % here k is that k which gives an interception point when evader points are xe,ye(initial points)
% In reverse approach we don't need this here forward approach is employed.
I1(end+1)=H1(1);
I2(end+1)=H1(2);
I=[H1(1) H1(2)];
R1=((xp-I(1)).^2+(yp-I(2)).^2);
xcm=H1(3);
ycm=H1(4);
rm=H1(5);

th = 0:pi/100:2*pi;
xd = rm*cos(th) + xcm;
yd = rm*sin(th) + ycm;
ke=sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*(xd*(xcm-I(1))+yd*(ycm-I(2))))/(R1));
plot3(xd,yd,ke)
A=(R1*((kemean-m*sk)^2)-rm^2+(xcm^2-I(1)^2)+(ycm^2-I(2)^2)-2*xcm*(xcm-I(1))-2*ycm*(ycm-I(2)))/(2*rm);
B=(R1*((kemean+m*sk)^2)-rm^2+(xcm^2-I(1)^2)+(ycm^2-I(2)^2)-2*xcm*(xcm-I(1))-2*ycm*(ycm-I(2)))/(2*rm);
syms x 
ktl=real(solve((xcm-I(1))*cos(x)+sin(x)*(ycm-I(2))-A==0));
kth=real(solve((xcm-I(1))*cos(x)+sin(x)*(ycm-I(2))-B==0));
if(double(kth(1))==double(kth(2)))
    kfun=@(t)(-sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*((xcm-I(1))*(xcm+rm*cos(t))+(ycm-I(2))*(ycm+rm*sin(t))))/R1));

    l=fminbnd(kfun,-pi,pi);
    C=(R1*((-kfun(l))^2)-rm^2+(xcm^2-I(1)^2)+(ycm^2-I(2)^2)-2*xcm*(xcm-I(1))-2*ycm*(ycm-I(2)))/(2*rm); %% because upperlimit is lower than kemean+m*sk,I am making the maximum of ke function the upper limit
    u=1;
    kth=real(solve((xcm-I(1))*cos(x)+sin(x)*(ycm-I(2))-C==0));
end
%kt=[min(ktl(1),kth(1)) max(ktl(1),kth(1)) min(ktl(2),kth(2)) max(ktl(2),kth(2))];
p=double(ktl);
q=double(kth);
%{
for i=1:size(p,2)
    if(((p(i)>pi/2)&&(q(i)<-pi/2))||((p(i)<-pi/2)&&(q(i)>pi/2)))
    if(p(i)>0)
        ktl(i)=ktl(i)-2*pi;
    end
    if(q(i)>0)
        kth(i)=kth(i)-2*pi;
    end 
    end
end
   %}
    
%if((p(2)<q(1))||(q(2)<p(1)))
%kt=[min(real(double(ktl(1))),real(double(ktl(2)))) max(real(double(ktl(1))),real(double(ktl(2)))) min(real(double(kth(1))),real(double(kth(2)))) max(real(double(kth(1))),real(double(kth(2))))];
%else
%kt=[min(real(double(ktl(1))),real(double(kth(1)))) max(real(double(ktl(1))),real(double(kth(1)))) min(real(double(ktl(2))),real(double(kth(2)))) max(real(double(ktl(2))),real(double(kth(2)))) min(real(double(ktl(1))),real(double(kth(2)))) max(real(double(ktl(1))),real(double(kth(2))))];
%kt=[min(real(double(ktl(1))),real(double(kth(1)))) max(real(double(ktl(1))),real(double(kth(1)))) min(real(double(ktl(2))),real(double(kth(2)))) max(real(double(ktl(2))),real(double(kth(2))))];

ktl=real(double(ktl));
kth=real(double(kth));
ktl1=min(ktl);
ktl2=max(ktl);
kth1=min(kth);
kth2=max(kth);

ktl=[ktl1 ktl2];
kth=[kth1 kth2];
%end
if((ktl(1)>kth(2))&&(ktl(2)>kth(2)))
   kt=[real(double(kth(2))) real(double(ktl(1))) real(double(ktl(2))) real(double(kth(1)))];
elseif((ktl(2)<kth(1))&&(ktl(1)<kth(2)))
   kt=[real(double(kth(2))) real(double(ktl(1))) real(double(ktl(2))) real(double(kth(1)))];
elseif((ktl(1)>kth(1))&&(ktl(1)<kth(2)))
   kt=[real(double(kth(1))) real(double(ktl(1))) real(double(ktl(2))) real(double(kth(2)))];
elseif((ktl(1)<kth(1))&&(kth(2)<ktl(2)))
   kt=[real(double(ktl(1))) real(double(kth(2))) real(double(kth(2))) real(double(ktl(2)))];

end
%
hold on
t = box(xcm,ycm,rm,m*sx,m*sy,xemean,yemean,kemean,m*sk)

t(isnan(t))=[];

lim=[];
for i=1:2:size(t,2)
    T=limits2(t(i),t(i+1),kt);
    lim=[lim T];
end
lim(isnan(lim))=[];
for i=1:2:size(lim,2)
    arc(xcm,ycm,rm,lim(i),lim(i+1))
end
for i=1:2:size(lim,2)
    if(lim(i)>lim(i+1))
        lim(i+1)=lim(i+1)+2*pi;
    end
end
kfun=@(t)sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*((xcm-I(1))*(xcm+rm*cos(t))+(ycm-I(2))*(ycm+rm*sin(t))))/R1);
%xcor1=@(t)((((xcm+rm*cos(t))-xp.*kfun(t).^2)./(1-kfun(t).^2)+sqrt((kfun(t)./(1-kfun(t).^2)).^2).*(sqrt(((xcm+rm*cos(t))-xp).^2+((ycm+rm*sin(t))-yp).^2).*(xt.*(1-kfun(t).^2)-(xcm+rm*cos(t))+xp.*kfun(t).^2))./((xt.*(1-kfun(t).^2)-(xcm+rm*cos(t))+xp.*kfun(t).^2).^2+(yt.*(1-kfun(t).^2)-(ycm+rm*sin(t))+yp.*kfun(t).^2).^2).^0.5));
%ycor1=@(t)((((ycm+rm*sin(t))-yp.*kfun(t).^2)./(1-kfun(t).^2)+sqrt((kfun(t)./(1-kfun(t).^2)).^2).*(sqrt(((xcm+rm*cos(t))-xp).^2+((ycm+rm*sin(t))-yp).^2).*(yt.*(1-kfun(t).^2)-(ycm+rm*sin(t))+yp.*kfun(t).^2))./((xt.*(1-kfun(t).^2)-(xcm+rm*cos(t))+xp.*kfun(t).^2).^2+(yt.*(1-kfun(t).^2)-(ycm+rm*sin(t))+yp.*kfun(t).^2).^2).^0.5));
fun1=@(t)(exp((-1./(2.*sx.^2)).*(((xcm+rm*cos(t))-xemean).^2+((ycm+rm*sin(t))-yemean).^2)).*exp((-1./(2.*sk.^2)).*((kfun(t)-kemean).^2))./(((2.*pi).^1.5).*(sx.^2).*sk));
prob=0;
for i=1:2:size(lim,2)
prob(end+1)=prob(end)+integral(fun1,lim(i),lim(i+1));
end
if(isempty(lim))
    Xcm(end+1)=xcm;
    Rm(end+1)=rm;
    Ycm(end+1)=ycm;
    Inc(end+1)=inc;
end
I1=I1(2:end);
I2=I2(2:end);
s.I=[I1;I2];
s.prob=prob;
Xcm=Xcm(2:end);
Ycm=Ycm(2:end);
Rm=Rm(2:end);
s.xcm=Xcm;
s.ycm=Ycm;
s.rm=Rm;
s.kt=kt;
s.inc=Inc;