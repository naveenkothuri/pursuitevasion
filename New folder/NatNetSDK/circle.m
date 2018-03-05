function h = circle(x,y,r,target)

T=target;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,'m--');
plot([x T(1)],[y T(2)],'k:')


