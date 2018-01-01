function sol = region(xe,ye,ke,sx,sk,msk)
%xe is xemean, ye is yemean ke is kemean
%sk is variance of sk, msk is the integral coefficient of sk that comes in the limit we want to put on k.
%this file is to generate all points that form ellipsoid.
%Ellipsoid in our problem is circle whose radius varies depending on sk
N=2; % N here decides no. of points we want to generate
m=4;
solxe=[];
th = 0:pi/50:2*pi;
solye=[];
solze=[];
for k=ke-msk*sk:sk/5:ke+msk*sk
 for r= 0:sqrt(2*(sx^2)*(2-(((k-ke)^2)/(2*sk^2))))/5: sqrt(2*(sx^2)*(2-(((k-ke)^2)/(2*sk^2)))) % here 2 is because (x-xe)^2+(y-ye)^2=2sx^2 
    % when k=ke and the radius can go to a maximum of 2*sx so to make maximum radius 2sx^2
    % we have to multiply by 2.
    hold on
xunit = r * cos(th) + xe;
yunit = r * sin(th) + ye;
h = plot3(xunit, yunit,k*ones(size(th,2),2));
    for j=1:N*m
        solxe(end+1)=xe+r*cos(2*pi*j/(N*m));
        solye(end+1)=ye+r*sin(2*pi*j/(N*m));
        solze(end+1)=k;
        
    %{
        syms x y
[solx,soly]=solve((x-xe)^2+(y-ye)^2==i^2,(tan(2*pi*k/(N*i)))*x-y==(tan(2*pi*k/(N*i)))*xe-ye);
    solx(1,1)=double(solx(1,1));
    solx(2,1)=double(solx(2,1));
    soly(1,1)=double(soly(1,1));
    soly(2,1)=double(soly(2,1));
    
    %hold on
    %plot(solx,soly,'ro');
    a=cos(2*pi*k/(N*i));
    b=sin(2*pi*k/(N*i));
    if(a>=0&&(solx(1,1)-xe)>=0)
        solxe(end+1)=solx(1,1);
    elseif(a>=0&&(solx(2,1)-xe)>=0)
        solxe(end+1)=solx(2,1);

    elseif(a<0&&(solx(1,1)-xe)<0)
        solxe(end+1)=solx(1,1);
 
    else
        solxe(end+1)=solx(2,1);

    end
    %
    if(b>=0&&(soly(1,1)-ye)>=0)
        solye(end+1)=soly(1,1);
    elseif(b>=0&&(soly(2,1)-ye)>=0)
        solye(end+1)=soly(2,1);

    elseif(b<0&&(soly(1,1)-ye)<0)
        solye(end+1)=soly(1,1);
 
    else
        solye(end+1)=soly(2,1);

    end
        %}
        
   
    end  
 end
 hold on
   plot3(solxe,solye,solze,'b+')
end
sol=[solxe solye];
for i=ke-msk*sk:sk/5:ke+msk*sk
plot3(msk*sx*ones(size((-msk*sx:1:msk*sx),2))+xe*ones(size((-msk*sx:1:msk*sx),2)),-msk*sx+ye:1:msk*sx+ye,i*ones(size((-msk*sx:1:msk*sx),2)))
hold on
plot3(-msk*sx*ones(size((-msk*sx:1:msk*sx),2))+xe*ones(size((-msk*sx:1:msk*sx),2)),-msk*sx+ye:1:msk*sx+ye,i*ones(size((-msk*sx:1:msk*sx),2)))
plot3(-msk*sx+xe:1:msk*sx+xe,msk*sx*ones(size((-msk*sx:1:msk*sx),2))+ye*ones(size((-msk*sx:1:msk*sx),2)),i*ones(size((-msk*sx:1:msk*sx),2)))
plot3(-msk*sx+xe:1:msk*sx+xe,-msk*sx*ones(size((-msk*sx:1:msk*sx),2))+ye*ones(size((-msk*sx:1:msk*sx),2)),i*ones(size((-msk*sx:1:msk*sx),2)))
end
%{
vp=100;
ve=160;
xp=700;
yp=1200;
tx=-700;
ty=-1500;
intx=[];
inty=[];
v=ve;
%Ixmean=abscissamean(xe,ye,ve,20,40,xp,yp,tx,ty,vp)

for j=1:size(v,1)
    k=v(j)/vp;
    for i=1:size(solxe,2)
    mirror=map(tx,ty,solxe(1,i),solye(1,i),xp,yp,k);
    hold on
    plot(mirror(1),mirror(2),'b+');
    xci=(solxe(1,i)-((xp)*(k^2)))/(1-k^2);
    yci=(solye(1,i)-((yp)*(k^2)))/(1-k^2);
    R=double(sqrt(xci^2+yci^2-((solxe(1,i)^2+solye(1,i)^2)/(1-k^2))+(k^2*(xp^2+yp^2))/(1-k^2)));

%% equation of line joining target and center of circle and solving line and circle to get Intersection point
coefficients = polyfit([tx, xci], [ty, yci], 1);
a = coefficients (1);
b = coefficients (2);
syms x y 
[solx,soly]=solve((x-xci)^2+(y-yci)^2==R^2,(a*x-y)==-b);
X1 = [double(solx(1,1)),double(soly(1,1));tx,ty];
 d1 = pdist(X1,'euclidean');
X2 = [double(solx(2,1)),double(soly(2,1));tx,ty];
d2 = pdist(X2,'euclidean');
d=min(d1,d2);
if (d==d1)
    solxm=double(solx(1,1));
    solym=double(soly(1,1));
else
    solxm=double(solx(2,1));
    solym=double(soly(2,1));
end

    intx(end+1)=solxm;
    inty(end+1)=solym;
    hold on
    h=circle(xci,yci,R);
    
    end
end
hold on
plot(intx,inty,'r*')
plot(tx,ty,'b*');
plot(xp,yp,'r*');
figure
plot(intx,inty,'r*')
%}
