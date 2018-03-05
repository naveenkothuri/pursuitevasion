op=[2 3];
oe=[7 7];
ot=[3 5];
e=1;p=2
k1=e/p;
t2 = zeros(1,100);

for i=1:100
    tic
    pe=oe-op;
    pt=ot-op;
    theta=atan2(pe(2),pe(1))-atan2(pt(2),pt(1));
    k0=(norm(pt))/(norm(pe));

    k2=k0*(1-(k1^2));
    a=k2*cos(theta);
    b=(k2*k2);
    k3=b-(2*a)+1;
    angle_phi2=asin(k1*sqrt((b-a^2)/(k3*((k1*k1)-(2*k1*abs(k2*cos(theta)-1)/sqrt(k3))+1))));
    t2(i)=toc;

    op=op+[0.1 0.1];
    oe=oe+[0.1 0.1];

end
