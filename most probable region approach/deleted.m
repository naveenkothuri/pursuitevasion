function t = deleted(xcm,ycm,rm,sx,sy,xemean,yemean,kemean,sk)
p=0;
a=0;
    
%standard deviations sx,sy
%means xemean,yemean
%so sides of a square x=xemean+sx;x=xemean-sx;y=yemean+sy;y=yemean-sy;
t(1)=0;
syms x y
[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,x==xemean-sx);

if(imag(soly(1,1))==0)
    I=closestpoint(solx,soly,xemean-sx,yemean-sy);
    if(~((I(2)>yemean+sy)||(I(2)<yemean-sy)))
        t(end+1)=angle1((I(1)-xcm),(I(2)-ycm));
        a=1;
    end
    if((p==1)||(a==0))
        if(I(1)==solx(1))
          if(~((soly(2)>yemean+sy)||(soly(2)<yemean-sy)))
           t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm)); 
          end
        else
          if(~((soly(1)>yemean+sy)||(soly(1)<yemean-sy)))
           t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm));  
          end
        end
    end


end
a=0;
[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,y==yemean-sy);
if(imag(solx(1,1))==0)
    I=closestpoint(solx,soly,xemean-sx,yemean-sy);

    if(~((I(1)>xemean+sx)||(I(1)<xemean-sx)))
        t(end+1)=angle1(I(1)-xcm,I(2)-ycm);
        a=1;
    end
    if((p==1)||(a==0))
        if(I(1)==solx(1))
           if(~((solx(2)>xemean+sx)||(solx(2)<xemean-sx))) 
             t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm)); 
           end
           else
            if(~((solx(1)>xemean+sx)||(solx(1)<xemean-sx)))
              t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm));
            end
        end
    end

end
%%
a=0;
[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,y==yemean-sy);
if(imag(solx(1,1))==0)
    I=closestpoint(solx,soly,xemean+sx,yemean-sy);

    if(~((I(1)>xemean+sx)||(I(1)<xemean-sx)))
        t(end+1)=angle1(I(1)-xcm,I(2)-ycm);
        a=1;
    end
    if((p==3)||(a==0))
        if(I(1)==solx(1))
            if(~((solx(2)>xemean+sx)||(solx(2)<xemean-sx)))
               t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm)); 
            end
        else
            if(~((solx(1)>xemean+sx)||(solx(1)<xemean-sx)))
               t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm)); 
            end
        end
    end

end
a=0;
[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,x==xemean+sx);
if(imag(soly(1,1))==0)
    I=closestpoint(solx,soly,xemean+sx,yemean-sy);

    if(~((I(2)>yemean+sy)||(I(2)<yemean-sy)))
        t(end+1)=angle1(I(1)-xcm,I(2)-ycm);
        a=1;
    end
    if((p==3)||(a==0))
        if(I(1)==solx(1))
            if(~((soly(2)>yemean+sy)||(soly(2)<yemean-sy)))
               t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm));
            end
        else
            if(~((soly(1)>yemean+sy)||(soly(1)<yemean-sy)))
               t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm)); 
            end
        end
    end

end
a=0;
%


[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,x==xemean+sx);
if(imag(soly(1,1))==0)
    I=closestpoint(solx,soly,xemean+sx,yemean+sy);

    if(~((I(2)>yemean+sy)||(I(2)<yemean-sy)))
        t(end+1)=angle1(I(1)-xcm,I(2)-ycm);
        a=1;
    end
    if((p==4)||(a==0))
        if(I(1)==solx(1))
          if(~((soly(2)>yemean+sy)||(soly(2)<yemean-sy)))
           t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm)); 
          end
        else
             if(~((soly(1)>yemean+sy)||(soly(1)<yemean-sy)))
               t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm));
             end
        end
    end

end
a=0;
[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,y==yemean+sy);
if(imag(solx(1,1))==0)
    I=closestpoint(solx,soly,xemean+sx,yemean+sy);

    if(~((I(1)>xemean+sx)||(I(1)<xemean-sx)))
        t(end+1)=angle1(I(1)-xcm,I(2)-ycm);
        a=1;
    end
    if((p==4)||(a==0))
        if(I(1)==solx(1))
            if(~((solx(2)>xemean+sx)||(solx(2)<xemean-sx)))
              t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm)); 
            end
        else
            if(~((solx(2)>xemean+sx)||(solx(2)<xemean-sx)))
             t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm)); 
            end
        end
    end

end
a=0;
%
[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,y==yemean+sy);
if(imag(solx(1,1))==0)
    I=closestpoint(solx,soly,xemean-sx,yemean+sy);

    if(~((I(1)>xemean+sx)||(I(1)<xemean-sx)))
        t(end+1)=angle1(I(1)-xcm,I(2)-ycm);
        a=1;
    end
    if((p==2)||(a==0))
        if(I(1)==solx(1))
           t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm)); 
        else
           t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm));  
        end
    end

end
a=0;
[solx,soly]=solve((x-xcm)^2+(y-ycm)^2==rm^2,x==xemean-sx);
if(imag(soly(1,1))==0)
    I=closestpoint(solx,soly,xemean-sx,yemean+sy);

    if(~((I(2)>yemean+sy)||(I(2)<yemean-sy)))
        t(end+1)=angle1((I(1)-xcm),(I(2)-ycm));
        a=1;
    end
    if((p==2)||(a==0))
        if(I(1)==solx(1))
            if(~((soly(2)>yemean+sy)||(soly(2)<yemean-sy)))
              t(end+1)=angle1((solx(2)-xcm),(soly(2)-ycm));
            end
        else
            if(~((soly(1)>yemean+sy)||(soly(1)<yemean-sy)))
           t(end+1)=angle1((solx(1)-xcm),(soly(1)-ycm));  
            end
        end
    end

end
t=t(2:end);
lh=0;
if(~isempty(t))
t=[t t(end) t(1)];
for i=1:size(t,2)
   if(t(i)<0)
        t(i)=t(i)+2*pi;
   end
end
for o=1:(size(t,2)-1)
    if(t(o)~=t(o+1))
            
            th= (t(o)+t(o+1))/2; 
             x1=xcm+rm*cos(th);
             y1=ycm+rm*sin(th);
             u=0;
             if(t(o)>t(o+1))
             x2=xcm+rm*cos(th+pi);
             y2=ycm+rm*sin(th+pi);
             u=1;
             else
                 x2=x1;
                 y2=y1;
             end
               if(((x1>=xemean-sx)&&(x1<=xemean+sx)&&(y1>=yemean-sy)&&(y1<=yemean+sy))&&(u==0))
                    lh(end+1)=1;
                    
               elseif((x2>=xemean-sx)&&(x2<=xemean+sx)&&(y2>=yemean-sy)&&(y2<=yemean+sy)&&(u==1))
                    lh(end+1)=1;

               else
                    lh(end+1)=0;
               end

    else
        lh(end+1)=0;
    end
end
for i=1:size(t,2)
if(t(i)>pi)
        t(i)=t(i)-2*pi;
end
end
T=0;
    lh=lh(2:end);
    for h=1:size(lh,2)
        if(lh(h)==1)
            T=[T t(h) t(h+1)];
        end
    end
    T=T(2:end);

else
        if((xcm>=xemean-sx)&&(xcm<=xemean+sx)&&(ycm>=yemean-sy)&&(ycm<=yemean+sy))
               T=[0 pi/2 pi/2 pi -pi/2 0 -pi -pi/2];
        else
            T=[NaN NaN];
        end
end
t=T;

for i=1:2:size(t,2)
    arc(xcm,ycm,rm,t(i),t(i+1))
  hold on
end
circle(xcm,ycm,rm)
hold on
plot(sx*ones(size((-sx:1:sx),2))+xemean*ones(size((-sx:1:sx),2)),-sy+yemean:1:sy+yemean)
hold on
plot(-sx*ones(size((-sx:1:sx),2))+xemean*ones(size((-sx:1:sx),2)),-sy+yemean:1:sy+yemean)
hold on
plot(-sx+xemean:1:sx+xemean,sy*ones(size((-sy:1:sy),2))+yemean*ones(size((-sy:1:sy),2)))
plot(-sx+xemean:1:sx+xemean,-sy*ones(size((-sy:1:sy),2))+yemean*ones(size((-sy:1:sy),2)))
