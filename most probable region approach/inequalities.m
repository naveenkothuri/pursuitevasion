function I=inequalities(xmin,xmax,ymin,ymax,kmin,kmax,xmean,ymean,kmean,xp,yp,xt,yt)
%%
%for k/(1-k^2) term
 c1=1/(1-(kmax^2))^2;
 c2=1/(1-kmin^2)^2;
 if(c1>c2)
     e=c1;
     c1=c2;
     c2=e;
 end
 if((1/(1-kmean^2)^2)<c1)
     c2=c1;
     c1=0;
 end
 min1=sqrt(c1*(kmin)^2);
 max1=sqrt(c2*(kmax)^2);
 %%
 
% for square root term
c1x= (xmin-xp)^2;
c2x=(xmax-xp)^2;
 if(c1x>c2x)
     e=c1x;
     c1x=c2x;
     c2x=e;
 end
 if(((xmean-xp)^2)<c1x)
     c2x=c1x;
     c1x=0;
 end
 c1y= (ymin-yp)^2;
c2y=(ymax-yp)^2;
 if(c1y>c2y)
     e=c1y;
     c1y=c2y;
     c2y=e;
 end
 if(((ymean-yp)^2)<c1y)
     c2y=c1y;
     c1y=0;
 end
 c1num=sqrt(c1x+c1y)*min1;
 c2num=sqrt(c2x+c2y)*max1;
 %%
 %for center
 
 c1x=min([-xp*kmin^2,-xp*kmax^2]);
 c2x=max([-xp*kmin^2,-xp*kmax^2]);
 c11x=xmin+c1x;
 c22x=xmax+c2x;
 c1k=min([1/(1-kmin^2),1/(1-kmax^2)]);
 c2k=max([1/(1-kmin^2),1/(1-kmax^2)]);
c1xc=min([c11x*c1k,c11x*c2k,c22x*c1k,c22x*c2k]);
c2xc=max([c11x*c1k,c11x*c2k,c22x*c1k,c22x*c2k]);


     c1y=min([-yp*kmin^2,-yp*kmax^2]);
 c2y=max([-yp*kmin^2,-yp*kmax^2]);
 c11y=ymin+c1y;
 c22y=ymax+c2y;
 
c1yc=min([c11y*c1k,c11y*c2k,c22y*c1k,c22y*c2k]);
c2yc=max([c11y*c1k,c11y*c2k,c22y*c1k,c22y*c2k]);

%%
% for slopeterm : this is for 1/sqrt(m^2+1)
c1ym=c1yc-yt;
c2ym=c2yc-yt;
c1xm=c1xc-xt;
c2xm=c2xc-xt;
c11m=min([c1ym/c1xm,c1ym/c2xm,c2ym/c1xm,c2ym/c2xm]); %slope limits c11m<M<c12m
c12m=max([c1ym/c1xm,c1ym/c2xm,c2ym/c1xm,c2ym/c2xm]);
c2m=1/sqrt((c11m)^2+1);
c1m=1/sqrt((c12m)^2+1);
if(c1m>c2m)
    e=c2m;
    c2m=c1m;
    c1m=e;
end
c1=c1num*c1m;
c2=c2num*c2m;

Ixmin1 = c1xc-c2;
Ixmax1=c2xc-c1;
Ixmin2=c1xc+c1;
Ixmax2=c2xc+c2;
d1=((Ixmin2+Ixmax2)/2-xt)^2;
d2=((Ixmin1+Ixmax1)/2-xt)^2;
if(d1<d2)
    Ixmin=Ixmin2;
    Ixmax=Ixmax2;
else
     Ixmin=Ixmin1;
    Ixmax=Ixmax1;
end
if(Ixmax<Ixmin)
    e=Ixmin;
    Ixmin=Ixmax;
    Ixmax=e;
end
%%
% for Imin and Imax of y coordinate
%{
cin11=Ixmin-xt;
cin12=Ixmax-xt;
cin1=min([c11m*cin11,c11m*cin12,c12m*cin11,c12m*cin12]);
 Iymins=yt+cin1                     %yt+M*(x-xt)
 cin2=max([c11m*cin11,c11m*cin12,c12m*cin11,c12m*cin12]);
 Iymaxs=yt+cin2
%}
c11m=abs(c11m);
c12m=abs(c12m);
if(c11m>c12m)
    e=c11m;
    c11m=c12m;
    c12m=e;
end
xcmean=(xmean-xp*kmean^2)/(1-kmean^2);
ycmean=(ymean-yp*kmean^2)/(1-kmean^2);
M=(ycmean-yt)/(xcmean-xt);
if(sqrt(M^2)<c11m)
    c12m=c11m;
    c11m=0;
end


    c1=c1*c11m;
c2=c2*c12m;
Iymin1 = c1yc-c2;
Iymax1=c2yc-c1;
Iymin2=c1yc+c1;
Iymax2=c2yc+c2;
d1=((Iymin2+Iymax2)/2-yt)^2;
d2=((Iymin1+Iymax1)/2-yt)^2;
if(d1<d2)
    Iymin=Iymin2;
    Iymax=Iymax2;
else
     Iymin=Iymin1;
    Iymax=Iymax1;   
end
if(Iymax<Iymin)
    e=Iymin;
    Iymin=Iymax;
    Iymax=e;
end
I=[Ixmin Ixmax;Iymin Iymax];
%exception problem : map1(-30.47,18.43,-20.369,11.76,-5,-4,1/2)
     