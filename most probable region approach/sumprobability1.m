function s=sumprobability1(tx,ty,xp,yp,xemean,yemean,kemean,sx,sy,sk)
m=2; % this is the interval boundary which is considered so that probability is non-zero
Prob=0;
I1=0;
I2=0;
Xcm=0;
Ycm=0;
Rm=0;
X=[];
Y=[];
K=[];
KT=[0 0 0 0];
inc=0;
Inc=0;

ke1=kemean-3*sk;
for i=1:5
    ke1=ke1+sk;

    ye=yemean-3*sy;
    for j=1:5
        ye=ye+sy;
            xe=xemean-3*sx;
        for l=1:5
            xe=xe+sx;
            X(end+1)=xe;
            Y(end+1)=ye;
            K(end+1)=ke1;
            inc=inc+1;
            %}
H1=curveparameters(tx,ty,xe,ye,xp,yp,ke1); % here k is that k which gives an interception point when evader points are xe,ye(initial points)
% In reverse approach we don't need this here forward approach is employed.
I1(end+1)=H1(1);
I2(end+1)=H1(2);
I=[H1(1) H1(2)];
R1=((xp-I(1)).^2+(yp-I(2)).^2);
xcm=H1(3);
ycm=H1(4);
rm=H1(5);
%{
th = 0:pi/100:2*pi;
xd = rm*cos(th) + xcm;
yd = rm*sin(th) + ycm;
ke=sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*(xd*(xcm-I(1))+yd*(ycm-I(2))))/(R1));
plot3(xd,yd,ke)
%}
A=(R1*((kemean-m*sk)^2)-rm^2+(xcm^2-I(1)^2)+(ycm^2-I(2)^2)-2*xcm*(xcm-I(1))-2*ycm*(ycm-I(2)))/(2*rm);
B=(R1*((kemean+m*sk)^2)-rm^2+(xcm^2-I(1)^2)+(ycm^2-I(2)^2)-2*xcm*(xcm-I(1))-2*ycm*(ycm-I(2)))/(2*rm);
syms uu 
ktl=real(solve((xcm-I(1))*cos(uu)+sin(uu)*(ycm-I(2))-A==0));
kth=real(solve((xcm-I(1))*cos(uu)+sin(uu)*(ycm-I(2))-B==0));
if(double(kth(1))==double(kth(2)))
    kfun=@(t)(-sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*((xcm-I(1))*(xcm+rm*cos(t))+(ycm-I(2))*(ycm+rm*sin(t))))/R1));

    l=fminbnd(kfun,-pi,pi);
    C=(R1*((-kfun(l))^2)-rm^2+(xcm^2-I(1)^2)+(ycm^2-I(2)^2)-2*xcm*(xcm-I(1))-2*ycm*(ycm-I(2)))/(2*rm); %% because upperlimit is lower than kemean+m*sk,I am making the maximum of ke function the upper limit
    kth=real(solve((xcm-I(1))*cos(uu)+sin(uu)*(ycm-I(2))-C==0));
end
%kt=[min(ktl(1),kth(1)) max(ktl(1),kth(1)) min(ktl(2),kth(2)) max(ktl(2),kth(2))];
p=double(ktl);
q=double(kth);
ktl=real(double(ktl));
kth=real(double(kth));
ktl1=min(ktl);
ktl2=max(ktl);
kth1=min(kth);
kth2=max(kth);

ktl=[ktl1 ktl2];
kth=[kth1 kth2];
if((ktl(1)>kth(2))&&(ktl(2)>kth(2)))
   kt=[real(double(kth(2))) real(double(ktl(1))) real(double(ktl(2))) real(double(kth(1)))];
elseif((ktl(2)<kth(1))&&(ktl(1)<kth(2)))
   kt=[real(double(kth(2))) real(double(ktl(1))) real(double(ktl(2))) real(double(kth(1)))];
elseif((ktl(1)>kth(1))&&(ktl(1)<kth(2)))
   kt=[real(double(kth(1))) real(double(ktl(1))) real(double(ktl(2))) real(double(kth(2)))];
elseif((ktl(1)<kth(1))&&(kth(2)<ktl(2)))
   kt=[real(double(ktl(1))) real(double(kth(2))) real(double(kth(2))) real(double(ktl(2)))];

end
KT=[KT;kt];
%
hold on
t = box(xcm,ycm,rm,m*sx,m*sy,xemean,yemean,kemean,m*sk);

t(isnan(t))=[];

lim=[];
for i=1:2:size(t,2)
    T=limits(t(i),t(i+1),kt);
    lim=[lim T];
end
lim(isnan(lim))=[];
%%
if(~isempty(lim))
lim1=lim;
for i=1:2:size(lim1,2)
    % this code is to eliminate those sections in the curve which don't
    % result in intersection point I.
    xd1=xcm+rm*cos(lim1(i));
yd1=ycm+rm*sin(lim1(i));
k11=sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*(xd1*(xcm-I(1))+yd1*(ycm-I(2))))/(R1));
xc=(xd1-((xp)*(k11^2)))/(1-k11^2);
yc=(yd1-((yp)*(k11^2)))/(1-k11^2);
r=double(sqrt(xc^2+yc^2-((xd1^2+yd1^2)/(1-k11^2))+(k11^2*(xp^2+yp^2))/(1-k11^2)));

    coefficients = polyfit([tx, xc], [ty, yc], 1);
a = coefficients (1);
b = coefficients (2);
syms x y 
[solx,soly]=solve((x-xc)^2+(y-yc)^2==r^2,(a*x-y)==-b);
X1 = [double(solx(1,1)),double(soly(1,1));tx,ty];
 d1 = pdist(X1,'euclidean');
X2 = [double(solx(2,1)),double(soly(2,1));tx,ty];
d2 = pdist(X2,'euclidean');
d=min(d1,d2);
if (d==d1)
    I11=double(solx(1,1));
    I12=double(soly(1,1));
else
    I11=double(solx(2,1));
    I12=double(soly(2,1));
end
if(abs(I11-I(1))>0.1)
    lim(i)=[];
    lim(i)=[];
end
end
        end
        lim(isnan(lim))=[];
%%
%for i=1:2:size(lim,2)
 %   arc(xcm,ycm,rm,lim(i),lim(i+1))
%end
for i=1:2:size(lim,2)
    if(lim(i)>lim(i+1))
        lim(i+1)=lim(i+1)+2*pi;
    end
end
kfun1=@(x)(sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*((xcm+rm*cos(x))*(xcm-I(1))+(ycm+rm*sin(x))*(ycm-I(2))))/(R1)));
%xcor1=@(t)((((xcm+rm*cos(t))-xp.*kfun(t).^2)./(1-kfun(t).^2)+sqrt((kfun(t)./(1-kfun(t).^2)).^2).*(sqrt(((xcm+rm*cos(t))-xp).^2+((ycm+rm*sin(t))-yp).^2).*(xt.*(1-kfun(t).^2)-(xcm+rm*cos(t))+xp.*kfun(t).^2))./((xt.*(1-kfun(t).^2)-(xcm+rm*cos(t))+xp.*kfun(t).^2).^2+(yt.*(1-kfun(t).^2)-(ycm+rm*sin(t))+yp.*kfun(t).^2).^2).^0.5));
%ycor1=@(t)((((ycm+rm*sin(t))-yp.*kfun(t).^2)./(1-kfun(t).^2)+sqrt((kfun(t)./(1-kfun(t).^2)).^2).*(sqrt(((xcm+rm*cos(t))-xp).^2+((ycm+rm*sin(t))-yp).^2).*(yt.*(1-kfun(t).^2)-(ycm+rm*sin(t))+yp.*kfun(t).^2))./((xt.*(1-kfun(t).^2)-(xcm+rm*cos(t))+xp.*kfun(t).^2).^2+(yt.*(1-kfun(t).^2)-(ycm+rm*sin(t))+yp.*kfun(t).^2).^2).^0.5));
fun1=@(x)(sqrt(rm^2+(((rm*((xcm-I(1))*(-sin(x))+(ycm-I(2))*cos(x)))/(sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*((xcm+rm*cos(x))*(xcm-I(1))+(ycm+rm*sin(x))*(ycm-I(2))))/(R1))))^2))*exp((-1./(2.*sx.^2)).*(((xcm+rm*cos(x))-xemean).^2+((ycm+rm*sin(x))-yemean).^2)).*exp((-1./(2.*sk.^2)).*((kfun1(x)-kemean).^2))./(((2.*pi).^1.5).*(sx.^2).*sk));
fun2=@(x)
prob=0;
for i=1:2:size(lim,2)
prob=prob+integral(fun1,lim(i),lim(i+1));
end
if((isempty(lim)))
   % prob=(exp((-1./(2.*sx.^2)).*(((xe)-xemean).^2+((ye)-yemean).^2)).*exp((-1./(2.*sk.^2)).*((ke1-kemean).^2))./(((2.*pi).^1.5).*(sx.^2).*sk));
     prob=0;
end
if((~(isempty(t)))&&(isempty(lim)))
    Inc(end+1)=inc;
end
Prob(end+1)=prob;
if(isempty(lim))
    Xcm(end+1)=xcm;
    Rm(end+1)=rm;
    Ycm(end+1)=ycm;

    
end
        end
        
    end
   
end
I1=I1(2:end);
I2=I2(2:end);
Prob=Prob(2:end);
Inc=Inc(2:end);
s.I=[I1;I2];
s.prob=Prob;
Xcm=Xcm(2:end);
Ycm=Ycm(2:end);
Rm=Rm(2:end);
s.xcm=Xcm;
s.ycm=Ycm;
s.rm=Rm;
KT=KT(2:end,:);
s.kt=KT;
s.X=X;
s.Y=Y;
s.K=K;
s.inc=Inc;
%%
function T = limits(a,b,c)
N=800;
z=zeros(N,1);
zc=z;
%{
if(a<0)
    a=a+2*pi;
end
if(b<=0)
    b=b+2*pi;
end
for i=1:size(c,2)
    if(c(i)<0)
     c(i)=c(i)+2*pi;
    end
end
%}
p=round(a*(N/2)/pi);
q=round(b*(N/2)/pi);
if(p>q)
    q=q+N;
end
for i=p:q
     if(i<=0)
      z(i+N)=1;
     elseif(i>N)
        z(i-N)=1;
     else
         z(i)=1;
    end
end
T=1;
for i=1:2:size(c,2)

pc=round(c(i)*(N/2)/pi);
qc=round(c(i+1)*(N/2)/pi);
if(pc>qc)
qc=qc+N;
end
zc=zeros(N,1);
for j=pc:qc
    if(j<=0)
      zc(j+N)=1;
    elseif(j>N)
        zc(j-N)=1;
    
    else
        zc(j)=1;
    end
end
T1(1)=0;
T2(1)=0;
zsum=0;
zsum=z+zc;
    if(zsum(1)==2)
      T1(end+1)=1;
    end  
for k=2:size(zsum,1)
    if(((zsum(k)-zsum(k-1))==2)||((((zsum(k)-zsum(k-1))==1))&&zsum(k)==2))
        T1(end+1)=k;
    end
    if(((zsum(k-1)-zsum(k))==2)||((((zsum(k-1)-zsum(k))==1))&&zsum(k-1)==2))
        T2(end+1)=k;
    end
end
if(zsum(N)==2)
    T2(end+1)=N;
end
T1=T1(2:end);
T2=T2(2:end);
for l=1:size(T1,2)
    T=[T T1(l) T2(l)];
end
if(i==1)
T=T(2:end);
end
end

T=T*pi/(N/2);
for i=1:size(T,2)
    if(T(i)>pi)
        T(i)=T(i)-2*pi;
    end
end