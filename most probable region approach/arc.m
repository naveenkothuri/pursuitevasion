function h = arc(x,y,r,t1,t2)
hold on
if(t1>t2)
    t2=t2+2*pi;
end
th = t1:pi/400:t2;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit);
hold off