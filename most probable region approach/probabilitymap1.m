
function s=probabilitymap1(tx,ty,xp,yp,xemean,yemean,kemean,sx,sy,sk,m)
% m is the interval boundary which is considered so that probability is nonzeroProb=0;
I1=0;
I2=0;
X=[];
Y=[];
K=[];
inc=0;
Inc=0;
Prob=0;
Prob1=0;
ke1=kemean-3*sk;
for i=1:2*m+1
    ke1=ke1+sk;

    ye=yemean-3*sy;
    for j=1:2*m+1
        ye=ye+sy;
            xe=xemean-3*sx;
        for l=1:2*m+1
            xe=xe+sx;
            X(end+1)=xe;
            Y(end+1)=ye;
            K(end+1)=ke1;
            inc=inc+1 %remember inc=52 for example  s=probabilitymap(0,1,-2,-2,-15,-11,3,3,3,0.5,2)
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
if(~((isinf(xcm))&&(isinf(ycm))&&(isnan(rm))))
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
%
t = box(xcm,ycm,rm,m*sx,m*sy,xemean,yemean,kemean,m*sk);

t(isnan(t))=[];

lim=[];
for i=1:2:size(t,2)
    T=limits2(t(i),t(i+1),kt);
    lim=[lim T];
end
lim(isnan(lim))=[];
%%
limll=lim;
%if(~isempty(lim))
%lim1=segregate(lim);
%end
lim1=lim;
thetaI=atan2((I(2)-ycm),(I(1)-xcm));
if(thetaI>0)
    thetakmax=thetaI-pi;
else
    thetakmax=thetaI+pi;
end
%{
for i=1:2:size(lim1,2)
    % this code is to eliminate those sections in the curve which don't
    % result in intersection point I.
if((thetaI>lim(i))&&(thetaI<lim(i+1)))
    lim(i)=thetaI; 
    1
end  
if((thetakmax>lim(i))&&(thetakmax<lim(i+1)))
    lim(i+1)=thetakmax; 
    2
end 
end
%}
if(~isempty(lim))
lim1=segregate(lim);
end
limll=lim1;
for i=1:2:size(lim1,2)
    xd1=xcm+rm*cos(lim1(i));
yd1=ycm+rm*sin(lim1(i));
k11=sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*(xd1*(xcm-I(1))+yd1*(ycm-I(2))))/(R1));
if(imag(k11)~=0)
k11=0;
end
I11=mapkal(tx,ty,xd1,yd1,xp,yp,k11);
%{
xc=(xd1-((xp)*(k11^2)))/(1-k11^2);
yc=(yd1-((yp)*(k11^2)))/(1-k11^2);
r=double(sqrt(xc^2+yc^2-((xd1^2+yd1^2)/(1-k11^2))+(k11^2*(xp^2+yp^2))/(1-k11^2)));

    coefficients = polyfit([tx, xc], [ty, yc], 1);
a = coefficients (1);
b = coefficients (2);
syms x y 
if(~(tx-xc==0))
   [solx,soly]=solve((x-xc)^2+(y-yc)^2==r^2,(a*x-y)==-b);
else
   [solx,soly]=solve((x-xc)^2+(y-yc)^2==r^2,(x)==xc);
end
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
%}
if(abs(I11-I(1))>0.1)
    limll(i)=NaN;
    limll(i+1)=NaN;
    3
    
end
end
%end
        limll(isnan(limll))=[];
%%
%for i=1:2:size(lim,2)
 %   arc(xcm,ycm,rm,lim(i),lim(i+1))
%end
for i=1:2:size(limll,2)
    if(limll(i)>limll(i+1))
        limll(i+1)=limll(i+1)+2*pi;
    end
end
kfun1=@(x)(sqrt((rm^2-(xcm^2-I(1)^2)-(ycm^2-I(2)^2)+2*((xcm+rm*cos(x))*(xcm-I(1))+(ycm+rm*sin(x))*(ycm-I(2))))/(R1)));

fun1=@(x)(abs(sqrt(abs(det(transpose([((cos(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((2.*I(1)- 2.*xp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + 1) ((cos(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((I(1)- xp).^2 + (I(2)- yp).^2)./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + ((2.*I(2)- 2.*yp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) (-sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)); ((sin(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) - (I(1)- xp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx).*(I(2)- ty))./((I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) ((sin(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) - (I(2)- yp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx))./((I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + 1) (cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) ;(((2.*(((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).*((I(1)- xp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - (sin(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx).*(I(2)- ty))./((I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) + 2.*(cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).*((cos(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((2.*I(1)- 2.*xp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)))./((I(1)- xp).^2 + (I(2)- yp).^2) - ((2.*I(1)- 2.*xp).*((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2))./((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(2.*(((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2)./((I(1)- xp).^2 + (I(2)- yp).^2)).^(1./2))) (-((2.*(((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).*((sin(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) - (I(2)- yp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx))./((I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) - 2.*(cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).*((cos(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((I(1)- xp).^2 + (I(2)- yp).^2)./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + ((2.*I(2)- 2.*yp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)))./((I(1)- xp).^2 + (I(2)- yp).^2) + ((2.*I(2)- 2.*yp).*((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2))./((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(2.*(((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2)./((I(1)- xp).^2 + (I(2)- yp).^2)).^(1./2))) (-(2.*cos(x).*(((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + 2.*sin(x).*(cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2))./(2.*(((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2)./((I(1)- xp).^2 + (I(2)- yp).^2)).^(1./2).*((I(1)- xp).^2 + (I(2)- yp).^2)))])*([((cos(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((2.*I(1)- 2.*xp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + 1) ((cos(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((I(1)- xp).^2 + (I(2)- yp).^2)./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + ((2.*I(2)- 2.*yp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) (-sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)); ((sin(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) - (I(1)- xp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx).*(I(2)- ty))./((I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) ((sin(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) - (I(2)- yp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx))./((I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + 1) (cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) ;(((2.*(((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).*((I(1)- xp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - (sin(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx).*(I(2)- ty))./((I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) + 2.*(cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).*((cos(x).*(((2.*I(1)- 2.*xp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*(I(2)- ty).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((2.*I(1)- 2.*xp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty).^2)./(2.*(I(1)- tx).^3.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)))./((I(1)- xp).^2 + (I(2)- yp).^2) - ((2.*I(1)- 2.*xp).*((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2))./((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(2.*(((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2)./((I(1)- xp).^2 + (I(2)- yp).^2)).^(1./2))) (-((2.*(((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).*((sin(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) - (I(2)- yp)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2).*(xp - tx))./((I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)) - 2.*(cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).*((cos(x).*(((2.*I(2)- 2.*ty).*((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(4.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) + ((2.*I(2)- 2.*yp).*((I(1)- xp).^2 + (I(2)- yp).^2).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2) - (((I(1)- xp).^2 + (I(2)- yp).^2).^2.*(xp - tx).*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^3)))./(2.*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)) + ((I(1)- xp).^2 + (I(2)- yp).^2)./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) + ((2.*I(2)- 2.*yp).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx))) - (((I(1)- xp).^2 + (I(2)- yp).^2).*(xp - tx).*(I(2)- ty))./(2.*(I(1)- tx).^2.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)))./((I(1)- xp).^2 + (I(2)- yp).^2) + ((2.*I(2)- 2.*yp).*((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2))./((I(1)- xp).^2 + (I(2)- yp).^2).^2)./(2.*(((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2)./((I(1)- xp).^2 + (I(2)- yp).^2)).^(1./2))) (-(2.*cos(x).*(((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + 2.*sin(x).*(cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2))./(2.*(((cos(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2) + (((I(1)- xp).^2 + (I(2)- yp).^2).*(I(2)- ty))./(2.*(I(1)- tx).*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)))).^2 + (((I(1)- xp).^2./2 + (I(2)- yp).^2./2)./(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)) - sin(x).*((((I(1)- xp).^2 + (I(2)- yp).^2).^2.*((I(2)- ty).^2./(I(1)- tx).^2 + 1))./(4.*(ty - yp + ((xp - tx).*(I(2)- ty))./(I(1)- tx)).^2)).^(1./2)).^2)./((I(1)- xp).^2 + (I(2)- yp).^2)).^(1./2).*((I(1)- xp).^2 + (I(2)- yp).^2)))]))))))*(exp((-1./(2.*sx.^2)).*(((xcm+rm*cos(x))-xemean).^2+((ycm+rm*sin(x))-yemean).^2)).*exp((-1./(2.*sk.^2)).*((kfun1(x)-kemean).^2))./(((2.*pi).^1.5).*(sx.^2).*sk));

prob=0;
%prob1=0;
for i=1:2:size(limll,2)
    datax=limll(i):((limll(i+1)-limll(i))/100):limll(i+1);
    for ll=1:size(datax,2)
    datay(ll)=fun1(datax(ll));
    %datay1(ll)=fun2(datax(ll));
    end 
    if(isempty(datax))
        datay=[];
       % datay1=[];
    end
prob=prob+1.1481*trapz(datax,datay); %the factor is to normalize for 2*sigma interval gaussian distribution,1/(0.955^3)
%prob1=prob1+1.1481*trapz(datax,datay1);

end
else
    prob=0;
    %prob1=0;
end
if((isempty(lim)))
   % prob=(exp((-1./(2.*sx.^2)).*(((xe)-xemean).^2+((ye)-yemean).^2)).*exp((-1./(2.*sk.^2)).*((ke1-kemean).^2))./(((2.*pi).^1.5).*(sx.^2).*sk));
     prob=0;
     %prob1=0;
end
if((~(isempty(t)))&&(isempty(lim)))
    Inc(end+1)=inc;
end
Prob(end+1)=prob;
%Prob1(end+1)=prob1; %prob1 is with length element, no jacobian
        end
        
    end
   
end
I1=I1(2:end);
I2=I2(2:end);
Prob=Prob(2:end);
Inc=Inc(2:end);
s.I=[I1;I2];
s.prob=Prob;
%s.prob1=Prob1;
s.X=X;
s.Y=Y;
s.K=K;
s.inc=Inc;
for i=1:size(s.I,2)
    if(s.prob(i)==max(s.prob))
        ind=i;
    end
end
%%
