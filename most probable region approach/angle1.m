function theta=angle1(x,y)
if((x>=0)&&(y>=0))
    theta=atan(y/x);
elseif((x>=0)&&(y<=0))
    theta=atan(y/x);
elseif((x<=0)&&(y<=0))
    
    theta=atan(y/x)-pi;
else
    theta=atan(y/x)+pi;
end
